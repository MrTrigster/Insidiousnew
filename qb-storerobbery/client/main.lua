local QBCore = exports['qb-core']:GetCoreObject()
local uiOpen = false
local currentRegister   = 0
local currentSafe = 0
local copsCalled = false
local CurrentCops = 0
local PlayerJob = {}
local onDuty = false
local usingAdvanced = false

CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData().job ~= nil and next(QBCore.Functions.GetPlayerData().job) then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

CreateThread(function()
    while true do
        Wait(1000 * 60 * 5)
        if copsCalled then
            copsCalled = false
        end
    end
end)
CreateThread(function()
    Wait(1000)
    setupRegister()
    setupSafes()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        for k, v in pairs(Config.Registers) do
            local dist = #(pos - Config.Registers[k][1].xyz)
            if dist <= 1 and Config.Registers[k].robbed then
                inRange = true
                DrawText3Ds(Config.Registers[k][1].xyz, 'Kassa on tühi')
            end
        end
        if not inRange then
            Wait(2000)
        end
        Wait(3)
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        local inRange = false
        if QBCore ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            for safe,_ in pairs(Config.Safes) do
                local dist = #(pos - Config.Safes[safe][1].xyz)
                if dist < 3 then
                    inRange = true
                    if dist < 1.0 then
                        if not Config.Safes[safe].robbed then
                            DrawText3Ds(Config.Safes[safe][1].xyz, '~g~E~w~ - Proovi Kombinatsiooni')
                            if IsControlJustPressed(0, 38) then
                                if CurrentCops >= Config.MinimumStoreRobberyPolice then
                                    currentSafe = safe
                                    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                    end
                                    if math.random(100) <= 50 then
                                        TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                                    end
                                    if Config.Safes[safe].type == "keypad" then
                                        SendNUIMessage({
                                            action = "openKeypad",
                                        })
                                        SetNuiFocus(true, true)
                                    else
                                        QBCore.Functions.TriggerCallback('i13-storerobbery:server:getPadlockCombination', function(combination)
                                            TriggerEvent("SafeCracker:StartMinigame", combination)
                                        end, safe)
                                    end

                                    if not copsCalled then
                                        -- local pos = GetEntityCoords(PlayerPedId())
                                        -- local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
                                        -- local street1 = GetStreetNameFromHashKey(s1)
                                        -- local street2 = GetStreetNameFromHashKey(s2)
                                        -- local streetLabel = street1
                                        -- if street2 ~= nil then
                                        --     streetLabel = streetLabel .. " " .. street2
                                        -- end
                                        -- TriggerServerEvent("i13-storerobbery:server:callCops", "safe", currentSafe, streetLabel, pos)
                                        exports['qb-dispatch']:StoreRobbery()
                                        copsCalled = true
                                    end
                                else
                                    QBCore.Functions.Notify("Pole piisavalt politseinikke (".. Config.MinimumStoreRobberyPolice .." Vaja)", "error")
                                end
                            end
                        else
                            DrawText3Ds(Config.Safes[safe][1].xyz, 'Safe Avatud')
                        end
                    end
                end
            end
        end

        if not inRange then
            Wait(2000)
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = true
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced)
    usingAdvanced = isAdvanced
    for k, v in pairs(Config.Registers) do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = #(pos - Config.Registers[k][1].xyz)
        if dist <= 1 and not Config.Registers[k].robbed then
            if CurrentCops >= Config.MinimumStoreRobberyPolice then
                -- print(usingAdvanced)
                local openingDoor = false
                local circles = math.random(4, 7)
                local seconds = math.random(6, 10)
                if usingAdvanced then
                    local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
                    if success then
                        currentRegister = k
                        if not IsWearingHandshoes() then
                            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                        end
                        if not copsCalled then
                            -- local data = {displayCode = '10-72', description = 'Poerööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Poerööv'}
                            -- local dispatchData = {dispatchData = data, caller = 'Poealarm', coords = pos}
                            -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                            exports['qb-dispatch']:StoreRobbery()
                            copsCalled = true
                        end
                        if currentRegister ~= 0 then
                            TriggerServerEvent('i13-storerobbery:server:setRegisterStatus', currentRegister)
                            local lockpickTime = 60000
                            LockpickDoorAnim(lockpickTime)
                            QBCore.Functions.Progressbar("search_register", "Tühjendab kassat...", lockpickTime, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "veh@break_in@0h@p_m_one@",
                                anim = "low_force_entry_ds",
                                flags = 16,
                            }, {}, {}, function() -- Done
                                openingDoor = false
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent('i13-storerobbery:server:takeMoney', currentRegister, true)
                                currentRegister = 0
                            end, function() -- Cancel
                                openingDoor = false
                                ClearPedTasks(PlayerPedId())
                                QBCore.Functions.Notify("Katkestatud", "error")
                                currentRegister = 0
                            end)
                        end
                    else
                        if math.random(1, 100) <= 30 then
                            TriggerServerEvent("QBCore:Server:RemoveItem", "advancedlockpick", 1, false)
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["advancedlockpick"], "remove")
                        end
                        QBCore.Functions.Notify('Ebaõnnestus', 'error', 2500)
                    end
                else
                    local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
                    if success then
                        currentRegister = k
                        if not IsWearingHandshoes() then
                            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                        end
                        if not copsCalled then
                            -- local data = {displayCode = '10-72', description = 'Poerööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Poerööv'}
                            -- local dispatchData = {dispatchData = data, caller = 'Poealarm', coords = pos}
                            -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                            exports['qb-dispatch']:StoreRobbery()
                            copsCalled = true
                        end
                        if currentRegister ~= 0 then
                            TriggerServerEvent('i13-storerobbery:server:setRegisterStatus', currentRegister)
                            local lockpickTime = 60000
                            LockpickDoorAnim(lockpickTime)
                            QBCore.Functions.Progressbar("search_register", "Tühjendab kassat...", lockpickTime, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "veh@break_in@0h@p_m_one@",
                                anim = "low_force_entry_ds",
                                flags = 16,
                            }, {}, {}, function() -- Done
                                openingDoor = false
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent('i13-storerobbery:server:takeMoney', currentRegister, true)
                                currentRegister = 0
                            end, function() -- Cancel
                                openingDoor = false
                                ClearPedTasks(PlayerPedId())
                                QBCore.Functions.Notify("Katkestatud", "error")
                                currentRegister = 0
                            end)
                        end
                    else
                        if math.random(1, 100) <= 50 then
                            TriggerServerEvent("QBCore:Server:RemoveItem", "lockpick", 1, false)
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick"], "remove")
                        end
                        QBCore.Functions.Notify('Ebaõnnestus', 'error', 2500)
                    end
                end
            else
                QBCore.Functions.Notify("Pole piisavalt politseinikke ("..Config.MinimumStoreRobberyPolice.." Vaja)", "error")
            end
        end
    end
end)

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true

    if model == GetHashKey("mp_m_freemode_01") then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

function setupRegister()
    QBCore.Functions.TriggerCallback('i13-storerobbery:server:getRegisterStatus', function(Registers)
        for k, v in pairs(Registers) do
            Config.Registers[k].robbed = Registers[k].robbed
        end
    end)
end

function setupSafes()
    QBCore.Functions.TriggerCallback('i13-storerobbery:server:getSafeStatus', function(Safes)
        for k, v in pairs(Safes) do
            Config.Safes[k].robbed = Safes[k].robbed
        end
    end)
end

DrawText3Ds = function(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function lockpick(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    SetCursorLocation(0.5, 0.2)
    uiOpen = bool
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(100)
    end
end

function takeAnim()
    local ped = PlayerPedId()
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Wait(100)
    end
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Wait(2500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end

--[[local openingDoor = false
RegisterNUICallback('success', function()
    if currentRegister ~= 0 then
        lockpick(false)
        TriggerServerEvent('i13-storerobbery:server:setRegisterStatus', currentRegister)
        local lockpickTime = 25000
        LockpickDoorAnim(lockpickTime)
        QBCore.Functions.Progressbar("search_register", "Tühjendab kassat", lockpickTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "veh@break_in@0h@p_m_one@",
            anim = "low_force_entry_ds",
            flags = 16,
        }, {}, {}, function() -- Done
            openingDoor = false
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('i13-storerobbery:server:takeMoney', currentRegister, true)
            currentRegister = 0
        end, function() -- Cancel
            openingDoor = false
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify("Katkestatud", "error")
            currentRegister = 0
        end)
        CreateThread(function()
            while openingDoor do
                TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                Wait(10000)
            end
        end)
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
end)]]

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            TriggerServerEvent('i13-storerobbery:server:takeMoney', currentRegister, false)
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

RegisterNUICallback('callcops', function()
    TriggerEvent("police:SetCopAlert")
end)

RegisterNetEvent('SafeCracker:EndMinigame', function(won)
    if currentSafe ~= 0 then
        if won then
            if currentSafe ~= 0 then
                if not Config.Safes[currentSafe].robbed then
                    SetNuiFocus(false, false)
                    TriggerServerEvent("i13-storerobbery:server:SafeReward", currentSafe)
                    TriggerServerEvent("i13-storerobbery:server:setSafeStatus", currentSafe)
                    currentSafe = 0
                    takeAnim()
                end
            else
                SendNUIMessage({
                    action = "kekw",
                })
            end
        end
    end
    copsCalled = false
end)

RegisterNUICallback('PadLockSuccess', function()
    if currentSafe ~= 0 then
        if not Config.Safes[currentSafe].robbed then
            SendNUIMessage({
                action = "kekw",
            })
        end
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
end)

RegisterNUICallback('PadLockClose', function()
    SetNuiFocus(false, false)
    copsCalled = false
end)

RegisterNUICallback("CombinationFail", function(data, cb)
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
end)

RegisterNUICallback('fail', function()
    if usingAdvanced then
        if math.random(1, 100) < 20 then
            TriggerServerEvent("QBCore:Server:RemoveItem", "advancedlockpick", 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["advancedlockpick"], "remove")
            QBCore.Functions.Notify("Lockpick läks katki", "error")
        end
    else
        if math.random(1, 100) < 40 then
            TriggerServerEvent("QBCore:Server:RemoveItem", "lockpick", 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick"], "remove")
            QBCore.Functions.Notify("Lockpick läks katki", "error")
        end
    end
    if (IsWearingHandshoes() and math.random(1, 100) <= 25) then
        local pos = GetEntityCoords(PlayerPedId())
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    lockpick(false)
end)

RegisterNUICallback('exit', function()
    lockpick(false)
end)

RegisterNUICallback('TryCombination', function(data, cb)
    QBCore.Functions.TriggerCallback('i13-storerobbery:server:isCombinationRight', function(combination)
        if tonumber(data.combination) ~= nil then
            if tonumber(data.combination) == combination then
                TriggerServerEvent("i13-storerobbery:server:SafeReward", currentSafe)
                TriggerServerEvent("i13-storerobbery:server:setSafeStatus", currentSafe)
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = false,
                })
                currentSafe = 0
                takeAnim()
            else
                TriggerEvent("police:SetCopAlert")
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = true,
                })
                currentSafe = 0
            end
        end
    end, currentSafe)
end)

RegisterNetEvent('i13-storerobbery:client:setRegisterStatus', function(batch, val)
    -- Has to be a better way maybe like adding a unique id to identify the register
    if(type(batch) ~= "table") then
        Config.Registers[batch] = val
    else
        for k, v in pairs(batch) do
            Config.Registers[k] = batch[k]
        end
    end
end)

RegisterNetEvent('i13-storerobbery:client:setSafeStatus', function(safe, bool)
    Config.Safes[safe].robbed = bool
end)

RegisterNetEvent('i13-storerobbery:client:robberyCall', function(type, key, streetLabel, coords)
    if PlayerJob.name == "police" and onDuty then
        local cameraId = 4
        if type == "safe" then
            cameraId = Config.Safes[key].camId
        else
            cameraId = Config.Registers[key].camId
        end

        QBCore.Functions.Notify('Poerööv', 'police')
        TriggerEvent('i13-phone:client:sendPoliceNotification')

        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        TriggerEvent('i13-policealerts:client:AddPoliceAlert', {
            timeOut = 5000,
            alertTitle = "10-72 | Poerööv",
            coords = {
                x = coords.x,
                y = coords.y,
                z = coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-video"></i>',
                    detail = cameraId,
                },
                [2] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = streetLabel,
                },
            },
            callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
        })

        local transG = 250
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 458)
        SetBlipColour(blip, 1)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, transG)
        SetBlipScale(blip, 1.0)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("10-72 | Poerööv")
        EndTextCommandSetBlipName(blip)
        while transG ~= 0 do
            Wait(180 * 4)
            transG = transG - 1
            SetBlipAlpha(blip, transG)
            if transG == 0 then
                SetBlipSprite(blip, 2)
                RemoveBlip(blip)
                return
            end
        end
    end
end)
