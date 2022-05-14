function Lockpick(propertyId, uniqueId)
    CloseMenu()
    
    local lockpicks = lib.TriggerCallbackSync("loaf_housing:get_lockpicks")
    if lockpicks == 0 then 
        Notify(Strings["no_lockpicks"])
        return false 
    end    
    
    if not Config.Lockpicking.Enabled then return end
    local exists
    for _, v in pairs(cache.houses) do
        if v.propertyid == propertyId and v.id == uniqueId then
            exists = true
        end
    end
    local houseData = Houses[propertyId]
    local houseApart = (houseData.type == "house" and "house" or "apart")
    if not exists then return Notify(Strings[houseApart.."_not_exist"]:format(uniqueId)) end

    local enoughCops = lib.TriggerCallbackSync("loaf_housing:start_lockpicking", propertyId, uniqueId)
    if not enoughCops then
        Notify(Strings["no_cops"])
        return false
    end

    TaskAchieveHeading(PlayerPedId(), Houses[propertyId].entrance.w - 180.0, 1500)
    Wait(1500)

    local dict = "missheistfbisetup1"
    local aspectRatio = GetAspectRatio(true)

    local correct = {}
    local amountLocks = 5
    if houseData.interiortype == "shell" then
        amountLocks = Categories[houseData.category].lockpick or 5
    elseif houseData.interiortype == "interior" then
        amountLocks = Config.Interiors[houseData.interior].lockpick or 5
    end
    math.randomseed(math.floor(GetGameTimer() * GetFrameTime() + GetGameTimer()))
    for i = 1, amountLocks do
        table.insert(correct, {"lock_closed", math.random(0, 359), math.random(2, 7)})
    end

    local rotation, lockStart, currentLock, nextAudio, success = 0.0, 0.5, 1, 0, false
    for i = 1, math.floor(#correct/2) do
        lockStart = lockStart - 0.02375
    end

    ClearAllHelpMessages()
    ClearHelp(true)

    local function ShowHelp()
        AddTextEntry(GetCurrentResourceName().."lockpicking_help", Strings["lockpicking_help"]:format(lockpicks))
        BeginTextCommandDisplayHelp(GetCurrentResourceName().."lockpicking_help")
        EndTextCommandDisplayHelp(0, true, false, 0)
    end

    ShowHelp()

    RequestAmbientAudioBank("SAFE_CRACK")
    while true do
        if not IsEntityPlayingAnim(PlayerPedId(), dict, "hassle_intro_loop_f", 3) then
            TaskPlayAnim(PlayerPedId(), LoadDict(dict), "hassle_intro_loop_f", 8.0, -8.0, -1, 1, 0, false, false, false)
            while not IsEntityPlayingAnim(PlayerPedId(), dict, "hassle_intro_loop_f", 3) do Wait(0) end
        end

        while not HasStreamedTextureDictLoaded("MPSafeCracking") do
            Wait(0)
            RequestStreamedTextureDict("MPSafeCracking", true)
        end

        DrawSprite("MPSafeCracking", "Dial_BG", 0.5, 0.3, 0.3, aspectRatio * 0.3, 0, 255, 255, 255, 255)
        DrawSprite("MPSafeCracking", "Dial", 0.5, 0.3, 0.3 * 0.5, 0.3 * aspectRatio * 0.5, rotation, 255, 255, 255, 255)

        local offset = 0.0
        for k, v in pairs(correct) do
            DrawSprite("MPSafeCracking", v[1], lockStart + offset, 0.1, 0.03, aspectRatio * 0.025, 0, 255, 255, 255, 255)
            offset = offset + 0.025
        end

        local speed = 0.5
        if math.abs(correct[currentLock][2] - correct[currentLock][3] - rotation) <= 15.0 then
            speed = 0.3
        end

        if IsControlPressed(0, 175) or IsControlPressed(0, 174) then
            if nextAudio <= GetGameTimer() then
                PlaySoundFrontend(0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", 1)
                nextAudio = GetGameTimer() + (speed == 0.3 and 220 or 150)
            end
            if IsControlPressed(0, 175) then
                if rotation <= 0.0 then rotation = 360.0 end
                rotation = rotation - speed
            elseif IsControlPressed(0, 174) then
                rotation = rotation + speed
                if rotation >= 360.0 then rotation = 0.0 end
            end 
        end

        if IsControlJustPressed(0, 191) then
            nextAudio = GetGameTimer() + 500
            if math.abs(correct[currentLock][2] - rotation) <= 3.0 then
                if correct[currentLock + 1] then
                    correct[currentLock][1] = "lock_open"
                    currentLock = currentLock + 1
                    PlaySoundFrontend(0, "TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", 1)
                else
                    success = true
                    break
                end
            else
                PlaySoundFrontend(0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", 1)
                lockpicks = lib.TriggerCallbackSync("loaf_housing:get_lockpicks", true)
                ShowHelp()
            end
        elseif IsControlJustPressed(0, 194) then
            break
        end

        if lockpicks == 0 then
            Notify(Strings["ran_out_lockpicks"])
            break
        end

        Wait(0)
    end

    ClearAllHelpMessages()
    ClearHelp(true)
    ClearPedTasks(PlayerPedId())
    if success then
        TriggerServerEvent("loaf_housing:lockpicked", propertyId, uniqueId)
        Wait(1000)
        EnterProperty(propertyId, uniqueId)
    else
        TriggerServerEvent("loaf_housing:cancel_lockpick")
    end
    return success
end

RegisterNetEvent("loaf_housing:lockpick_alert", function(coords, uniqueId)
    Notify(Strings["robbery_progress"]:format(uniqueId))
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, 1)
    SetBlipColour(blip, 6)
    SetBlipRoute(blip, true)
    
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Strings["robbery"]:format(uniqueId))
    EndTextCommandSetBlipName(blip)

    Wait(5 * 60 * 1000) -- 5 min, then delete blip
    SetBlipRoute(blip, false)
    RemoveBlip(blip)
end) 