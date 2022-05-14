if Config.FurnishCommand.Enabled then
    RegisterCommand(Config.FurnishCommand.Command, function()
        local instance = cache.currentInstance

        if not instance then
            return
        end

        local allowedFurnish = Config.Furnish == "all" or cache.identifier == instance.owner
        if not allowedFurnish and Config.Furnish == "key" then
            allowedFurnish = exports.loaf_keysystem:HasKey(GetKeyName(instance.property, instance.id))
        end
        
        if allowedFurnish then
            SelectFurnitureMenu()
        end
    end)
end
-- SelectFurnitureMenu

function InstanceMarker(action)
    if action == "use" then
        OpenInstanceMenu()
    end
end

function Teleport(coords)
    for i = 1, 25 do
        SetEntityCoords(PlayerPedId(), coords.xyz)
        Wait(50)
    end
    while IsEntityWaitingForWorldCollision(PlayerPedId()) do
        SetEntityCoords(PlayerPedId(), coords.xyz)
        Wait(50)
    end
    if type(coords) == "vector4" then
        SetEntityHeading(PlayerPedId(), coords.w)
    end
end

function StorageMenuHandler(data)
    local action, propertyId, uniqueId, furnitureId, owner = table.unpack(data)

    if Config.Inventory == "ox" then
        if action == "exit" then
            exports.ox_inventory:setStashTarget()
        elseif action == "enter" then
            exports.ox_inventory:setStashTarget(propertyId .. "_" .. uniqueId .. "_" .. furnitureId, owner)
        end
    end

    if action == "use" then
        ChooseStorageMenu(propertyId, uniqueId, furnitureId, owner)
    end
end

function LoadFurniture()
    RemoveInteractableFurniture("REMOVE_ALL")
    DeleteFurniture()
    cache.spawnedFurniture = {}
    for k, v in pairs(cache.currentInstance.furniture) do
        local coords = vector3(v.offset.x, v.offset.y, v.offset.z)
        if cache.shell then
            coords = GetOffsetFromEntityInWorldCoords(cache.shell, coords)
        end

        local toInsert = {
            coords = coords,
            id = k,
            data = v
        }

        if v.items or v.item == "NOT_AN_ITEM" then
            local propertyId, uniqueId, furnitureId, owner = cache.currentInstance.property, cache.currentInstance.id, k, cache.currentInstance.owner
            local marker = lib.AddMarker({
                coords = coords,
                type = 1,
                alpha = 0,
                scale = vector3(2.0, 2.0, 2.0),
                callbackData = {
                    enter = {"enter", propertyId, uniqueId, furnitureId, owner},
                    press = {"use", propertyId, uniqueId, furnitureId, owner},
                    exit = {"exit", propertyId, uniqueId, furnitureId, owner}
                },
                key = "secondary",
                text = v.items and Strings["access_storage"] or Strings["access_wardrobe"],
            }, StorageMenuHandler, StorageMenuHandler, StorageMenuHandler)
            toInsert.marker = marker
        end

        local model = lib.LoadModel(v.item)
        if model.success then
            local object = CreateObject(model.model, coords, false, false, false)
            FreezeEntityPosition(object, true)
            SetEntityCoordsNoOffset(object, coords)
            SetEntityHeading(object, v.offset.h)
            if v.offset.tilt then
                SetEntityRotation(object, v.offset.tilt, 0.0, v.offset.h, 2, true)
            end
            
            toInsert.object = object

            LoadInteractableFurniture(object, v.item, k)

            local _, _, furnitureData = FindFurniture(v.item)
            if furnitureData then
                if furnitureData.attached then
                    toInsert.attached = {}
                    for k, v in pairs(furnitureData.attached) do
                        local model = lib.LoadModel(v.object)
                        if model.success then
                            local attached = CreateObject(model.model, coords, false, false, false)
                            FreezeEntityPosition(attached, true)
                            AttachEntityToEntity(attached, object, 0, v.offset.xyz, vector3(0.0, 0.0, v.offset.w), false, false, false, false, 2, true)

                            table.insert(toInsert.attached, attached)
                        else
                            Notify("Could not load model " .. v.object)
                            print(model.error)
                        end
                    end
                end
            else
                print("could not find furniture data.")
            end
        elseif v.item ~= "NOT_AN_ITEM" then
            Notify("Could not load model " .. v.item)
            print(model.error)
        end

        table.insert(cache.spawnedFurniture, toInsert)
    end
end

function DeleteFurniture()
    if not cache.spawnedFurniture then return end
    for k, v in pairs(cache.spawnedFurniture) do
        if v.object then DeleteEntity(v.object) end
        if v.marker then lib.RemoveMarker(v.marker) end
        if v.attached then
            for _, attached in pairs(v.attached) do
                DeleteEntity(attached)
            end
        end
    end
    cache.spawnedFurniture = {}
end

local weatherSyncScripts = {
    "qb-weathersync",
    "cd_easytime"
}
RegisterNetEvent("loaf_housing:weather_sync", function()
    if not cache.shell then -- we only need to set the weather & time when inside a shell, mlo & ipl already looks good with all weather & time
        return 
    end

    StartAudioScene("MP_LEADERBOARD_SCENE") -- disable ambient sounds CRED: https://github.com/DevTestingPizza/JoinTransition/blob/master/cloading.lua#L19
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")

    TriggerEvent("ToggleWeatherSync", false)
    TriggerEvent("qb-weathersync:client:DisableSync")
    TriggerEvent("cd_easytime:PauseSync", true)

    SetRainFxIntensity(0.0)
    local hasWeathersync = false
    for _, script in pairs(weatherSyncScripts) do
        if GetResourceState(script) == "started" then
            hasWeathersync = true
        end
    end

    while cache.inInstance do
        Wait(250)
        if not hasWeathersync then
            SetWeather()
        end
    end
    
    Wait(1000)
    SetWindSpeed(previousWind)

    TriggerEvent("ToggleWeatherSync", true)
    TriggerEvent("qb-weathersync:client:EnableSync")
    TriggerEvent("cd_easytime:PauseSync", false)

    StopAudioScene("MP_LEADERBOARD_SCENE") -- re-enable ambient sounds
    StopAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
end)

RegisterNetEvent("loaf_housing:refresh_conceal", function(instances)
    --[[local toConceal = {}
    if not cache.inInstance then 
        if Config.SpawnAboveHouse then
            for _, instance in pairs(instances) do
                for _, guest in pairs(instance.guests) do
                    print("CONCEAL", guest)
                    toConceal[tostring(guest)] = true
                end
            end
        else
            return
        end
    elseif not cache.currentInstance.interior and not Config.SpawnAboveHouse then 
        for _, player in pairs(GetActivePlayers()) do
            NetworkConcealPlayer(player, false)
        end
        return
    else
        for _, instance in pairs(instances) do
            if instance.instanceid ~= cache.currentInstance.instanceid then
                for _, guest in pairs(instance.guests) do
                    toConceal[tostring(guest)] = true
                end
            end
        end
    end

    for _, player in pairs(GetActivePlayers()) do
        if toConceal[tostring(GetPlayerServerId(player))] and player ~= PlayerId() then
            NetworkConcealPlayer(player, true)
        else
            NetworkConcealPlayer(player, false)
        end
    end]]
end)

RegisterNetEvent("loaf_housing:refresh_furniture", function(newFurniture)
    if not cache.currentInstance then return end
    cache.currentInstance.furniture = newFurniture
    LoadFurniture()
end)

function Furnish(item)
    CloseMenu()
    if not cache.inInstance then return end

    local _, _, furnitureData = FindFurniture(item)

    StartLoading(Strings["loading_object"])
    local model = lib.LoadModel(item)
    Wait(250)
    BusyspinnerOff()
    if not model.success then 
        Notify(Strings["couldnt_load"]:format(item))
        return
    end
    local object = CreateObject(model.model, GetEntityCoords(PlayerPedId()), false, false, false)

    local attachments = {}
    for _, attachment in pairs(furnitureData.attached or {}) do
        StartLoading(Strings["loading_object"])
        local model = lib.LoadModel(attachment.object)
        BusyspinnerOff()
        if model.success then
            local attached = CreateObject(model.model, GetEntityCoords(object), false, true)
            FreezeEntityPosition(attached, true)
            table.insert(attachments, attached)
    
            AttachEntityToEntity(attached, object, 0, attachment.offset.xyz, vector3(0.0, 0.0, attachment.offset.w), false, false, false, false, 2, true)
        else
            Notify(Strings["couldnt_load"]:format(attachment.object))
        end
    end

    cache.busy = true
    local speed, pressDelay = 1.0, 0
    local placed, coords

    while cache.busy do
        local rotation = GetEntityRotation(object, 2)
        DisplayHelp(Strings["furnishing"]:format(speed, math.floor(rotation.z + 0.5), math.floor(rotation.x + 0.5)))
        SetEntityCollision(object, false, true)

        DisableControlAction(0, 24, true) -- Attack
        DisableControlAction(0, 257, true) -- Attack 2
        DisableControlAction(0, 25, true) -- Aim
        DisableControlAction(0, 263, true) -- Melee Attack 1
        DisableControlAction(0, 45, true) -- Reload
        DisableControlAction(0, 47, true)  -- Disable weapon
        DisableControlAction(0, 264, true) -- Disable melee
        DisableControlAction(0, 257, true) -- Disable melee
        DisableControlAction(0, 140, true) -- Disable melee
        DisableControlAction(0, 141, true) -- Disable melee
        DisableControlAction(0, 142, true) -- Disable melee
        DisableControlAction(0, 143, true) -- Disable melee
        DisableControlAction(0, 14, true) -- Disable weapon wheel
        DisableControlAction(0, 15, true) -- Disable weapon wheel
        DisableControlAction(0, 16, true) -- Disable weapon wheel
        DisableControlAction(0, 17, true)  -- Disable weapon wheel
        DisableControlAction(0, 261, true) -- Disable weapon wheel
        DisableControlAction(0, 262, true)  -- Disable weapon wheel
        DisableControlAction(0, 44, true) -- Cover

        DrawEntityBox(object)
        for _, v in pairs(attachments) do
            DrawEntityBox(v)
        end

        if pressDelay <= GetGameTimer() then
            if IsDisabledControlPressed(0, 44) then -- q (decrease speed) 
                speed = speed - 0.1
                if speed < 0.1 then speed = 0.1 end
                pressDelay = GetGameTimer() + 100
            elseif IsDisabledControlPressed(0, 46) then -- e (increase speed)
                speed = speed + 0.1
                pressDelay = GetGameTimer() + 100
            end
        end

        if 
            IsDisabledControlPressed(0, 175) or
            IsDisabledControlPressed(0, 174) or
            IsDisabledControlPressed(0, 173) or
            IsDisabledControlPressed(0, 172) or
            IsDisabledControlPressed(0, 15) or
            IsDisabledControlPressed(0, 14)
        then
            SetEntityRotation(object, 0.0, 0.0, rotation.z, 2, true)
        end

        -- move up / down
        if IsDisabledControlPressed(0, 15) then -- scroll up 
            SetEntityCoordsNoOffset(object, GetEntityCoords(object) + vec3(0.0, 0.0, 0.01 * speed))
        elseif IsDisabledControlPressed(0, 14) then -- scrol down
            SetEntityCoordsNoOffset(object, GetEntityCoords(object) - vec3(0.0, 0.0, 0.01 * speed))
        end

        -- move forward/left/right/back
        if IsDisabledControlPressed(0, 174) then -- arrow left
            SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, 0.01 * speed, 0.0, 0.0))
        elseif IsDisabledControlPressed(0, 175) then -- arrow right
            SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, -0.01 * speed, 0.0, 0.0))
        end
        if IsDisabledControlPressed(0, 172) then -- arrow up
            SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, 0.0, -0.01 * speed, 0.0))
        elseif IsDisabledControlPressed(0, 173) then -- arrow down
            SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, 0.0, 0.01 * speed, 0.0))
        end

        SetEntityRotation(object, rotation.x, 0.0, rotation.z, 2, true)

        -- heading 
        if IsDisabledControlPressed(0, 24) then -- mouse left
            if IsDisabledControlPressed(0, 21) then
                if pressDelay <= GetGameTimer() then
                    SetEntityRotation(object, rotation.x, 0.0, Round(rotation.z, 5, false)/1.0, 2, true)
                    pressDelay = GetGameTimer() + 100
                end
            else
                SetEntityRotation(object, rotation.x, 0.0, rotation.z - speed, 2, true)
            end
            rotation = GetEntityRotation(object, 2)
        elseif IsDisabledControlPressed(0, 25) then -- mouse right
            if IsDisabledControlPressed(0, 21) then
                if pressDelay <= GetGameTimer() then
                    SetEntityRotation(object, rotation.x, 0.0, Round(rotation.z, 5, true)/1.0, 2, true)
                    pressDelay = GetGameTimer() + 100
                end
            else
                SetEntityRotation(object, rotation.x, 0.0, rotation.z + speed, 2, true)
            end
            rotation = GetEntityRotation(object, 2)
        end

        -- tilt
        if IsDisabledControlPressed(0, 246) then -- y
            if IsDisabledControlPressed(0, 21) then
                if pressDelay <= GetGameTimer() then
                    SetEntityRotation(object, Round(rotation.x, 5, true)/1.0, 0.0, rotation.z, 2, true)
                    pressDelay = GetGameTimer() + 100
                end
            else
                SetEntityRotation(object, rotation.x + speed, 0.0, rotation.z, 2, true)
            end
        elseif IsDisabledControlPressed(0, 74) then -- h
            if IsDisabledControlPressed(0, 21) then
                if pressDelay <= GetGameTimer() then
                    SetEntityRotation(object, Round(rotation.x, 5, false)/1.0, 0.0, rotation.z, 2, true)
                    pressDelay = GetGameTimer() + 100
                end
            else
                SetEntityRotation(object, rotation.x - speed, 0.0, rotation.z, 2, true)
            end
        end

        if IsDisabledControlPressed(0, 47) then -- g (teleport to self)
            SetEntityCoordsNoOffset(object, GetEntityCoords(PlayerPedId()))
        end

        if IsControlJustReleased(0, 191) then -- enter (place)
            placed = true
            if cache.shell then
                coords = GetEntityCoords(object) - GetEntityCoords(cache.shell)
            else
                coords = GetEntityCoords(object)
            end

            cache.busy = false
            break
        end

        if IsControlJustReleased(0, 194) then -- backspace (cancel)
            cache.busy = false
            break
        end

        Wait(0)
    end

    local heading = GetEntityHeading(object)
    local tilt = GetEntityRotation(object, 2).x

    ClearHelpText()
    for _, v in pairs(attachments) do
        DeleteEntity(v)
    end
    DeleteEntity(object)

    if placed then
        StartLoading(Strings["placing_furniture"])
        lib.TriggerCallbackSync("loaf_housing:place_furniture", cache.currentInstance.instanceid, item, coords, heading, tilt)
        StopLoading()
    end
end

function ManagePlacedFurniture()
    if not cache.inInstance then return end

    cache.busy = true
    while cache.busy do
        Wait(0)

        for i, v in pairs(cache.spawnedFurniture or {}) do
            Draw3DText(i, v.coords + vector3(0.0, 0.0, 0.75))
        end
    end
end

function ExitInstance()
    DeleteFurniture()

    if cache.shell then
        local shell = cache.shell
        SetTimeout(750, function()
            DeleteEntity(shell)
        end)
    end

    TriggerServerEvent("loaf_housing:exit_property", cache.currentInstance.instanceid)
    if cache.doorMarker then
        lib.RemoveMarker(cache.doorMarker)
        cache.doorMarker = nil
    end
    cache.inInstance = false
    cache.shell = nil
    cache.spawnedFurniture = nil
    cache.currentInstance = nil
    cache.busy = false
end

function RefreshConceal()
    local currentInstance = LocalPlayer.state.instance
    for _, player in pairs(GetActivePlayers()) do
        local instance = Player(GetPlayerServerId(player)).state.instance
        local shouldConceal = (instance and instance ~= currentInstance and player ~= PlayerId()) or false
        print(("2 shouldConceal: %s, source: %i"):format(shouldConceal, GetPlayerServerId(player)))
        NetworkConcealPlayer(player, shouldConceal)
    end
end

AddStateBagChangeHandler("instance", nil, function(bagName, key, value)
    if bagName:sub(1, #"player:") ~= "player:" then
        return
    end

    local source = tonumber(bagName:sub(#"player:" + 1, #bagName))
    if source == GetPlayerServerId(PlayerId()) then
        return
    end

    local playerId = GetPlayerFromServerId(source)
    local timer = GetGameTimer() + 10000
    while not playerId and timer > GetGameTimer() do
        Wait(250)
        playerId = GetPlayerFromServerId(source)
        print("Waiting for player to exist on client machine")
    end

    local instance = value
    local currentInstance = LocalPlayer.state.instance
    local shouldConceal = (instance and instance ~= currentInstance) or false
    
    print(("1 shouldConceal: %s, source: %i"):format(shouldConceal, source))
    NetworkConcealPlayer(playerId, shouldConceal)
end)

RegisterNetEvent("loaf_housing:enter_instance", function(data)
    CloseMenu()

    cache.inInstance = true
    cache.currentInstance = data
    cache.busy = true

    local doorHeading, doorPosition = 0.0
    local housedata = Houses[data.property]

    if data.shell then
        local shell = Shells[data.shell]
        if not shell then 
            ExitInstance()
            return print("^1SHELL "..data.shell.." DOES NOT EXIST")
        end
        local shell_model = lib.LoadModel(shell.object)
        if not shell_model.success then 
            ExitInstance()
            Notify(Strings["couldnt_load"]:format(data.shell))
            return
        end
        
        cache.shell = CreateObject(shell_model.model, data.coords.xyz, false, false, false)
        SetEntityHeading(cache.shell, 0.0)
        FreezeEntityPosition(cache.shell, true)

        doorPosition = GetOffsetFromEntityInWorldCoords(cache.shell, shell.doorOffset)
        if shell.doorHeading then
            doorHeading = shell.doorHeading
        end
    elseif data.interior then
        if data.interior.ipl then
            RequestIpl(data.interior.ipl)
            while not IsIplActive(data.interior.ipl) do
                Wait(250)
                print("loading interior")
            end
        end

        doorPosition = data.interior.coords
        if data.interior.heading then
            doorHeading = data.interior.heading
        end
    end

    TriggerEvent("qb-anticheat:client:ToggleDecorate", true) -- disable qb-anticheat invisible check. qb devs, pls make this a server event instead so cheaters cant abuse :)
    SetEntityVisible(PlayerPedId(), false, 0)
    SetEntityInvincible(PlayerPedId(), true)

    DoScreenFadeOut(750)
    while not IsScreenFadedOut() do 
        Wait(0)
    end

    RefreshConceal()
    TriggerEvent("loaf_housing:weather_sync")
    TriggerEvent("loaf_housing:entered_property", data.property, Houses[data.property], data)

    cache.doorMarker = lib.AddMarker({
        coords = doorPosition,
        type = 1,
        callbackData = {
            enter = "enter",
            press = "use",
            exit = "exit"
        },
        key = "primary",
        text = housedata.type == "house" and Strings["manage_house"]:format(data.property) or Strings["manage_apart"]:format(data.property),
    }, InstanceMarker, InstanceMarker, InstanceMarker)

    Teleport(doorPosition)
    SetEntityHeading(PlayerPedId(), doorHeading)

    -- this should fix "not in cd image" error with furniture
    SetFocusPosAndVel(Config.FurnitureStore.Interior, 0.0, 0.0, 0.0)
    Wait(2500)
    ClearFocus()

    TriggerEvent("loaf_housing:refresh_furniture", cache.currentInstance.furniture)

    DoScreenFadeIn(500)

    TriggerEvent("qb-anticheat:client:ToggleDecorate", false)
    SetEntityVisible(PlayerPedId(), true, 0)
    SetTimeout(500, function()
        SetEntityInvincible(PlayerPedId(), false)
    end)

    while cache.inInstance do
        if #(GetEntityCoords(PlayerPedId()) - doorPosition) > 100.0 then
            SetEntityCoords(PlayerPedId(), doorPosition)
        end

        Wait(500)
    end

    TriggerEvent("qb-anticheat:client:ToggleDecorate", true)
    SetEntityVisible(PlayerPedId(), false, 0)
    SetEntityInvincible(PlayerPedId(), true)

    ExitInstance()
    
    CloseMenu()

    DoScreenFadeOut(750)
    while not IsScreenFadedOut() do 
        Wait(0)
    end

    Teleport(housedata.entrance - vector4(0.0, 0.0, 1.0, 0.0))
    DoScreenFadeIn(500)

    TriggerEvent("qb-anticheat:client:ToggleDecorate", false)
    SetEntityVisible(PlayerPedId(), true, 0)
    SetTimeout(500, function()
        SetEntityInvincible(PlayerPedId(), false)
    end)
end)

RegisterNetEvent("loaf_housing:exit_instance", function()
    cache.inInstance = false
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    DeleteFurniture()
    if cache.shell then
        DeleteEntity(cache.shell)
        Teleport(Houses[cache.currentInstance.property].entrance - vec4(0.0, 0.0, 1.0, 0.0))
    end
end)