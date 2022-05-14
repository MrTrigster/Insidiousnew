local QBCore = exports['qb-core']:GetCoreObject()

local PacificTrolley1 = nil
local PacificTrolley2 = nil
local PacificTrolley3 = nil
local PacificTrolley4 = nil

local EmptyTrolley1 = nil
local EmptyTrolley2 = nil
local EmptyTrolley3 = nil
local EmptyTrolley4 = nil

local copsCalled = false

-- Functions

local function removePacificTarget(targetName)
    CreateThread(function()
        exports['qb-target']:RemoveZone(targetName)
    end)
end

function OpenPacificDoor()
    local pacificDoor = GetClosestObjectOfType(Config.BigBanks['pacific']['coords'][2]['x'], Config.BigBanks['pacific']['coords'][2]['y'], Config.BigBanks['pacific']['coords'][2]['z'], 20.0, Config.BigBanks['pacific']['object'], false, false, false)
    local entityHeading = Config.BigBanks['pacific']['heading'].closed

    if pacificDoor ~= 0 then
        CreateThread(function()
            while true do
                if entityHeading > Config.BigBanks['pacific']['heading'].open then
                    SetEntityHeading(pacificDoor, entityHeading - 10)
                    entityHeading = entityHeading - 0.5
                else
                    break
                end
                Wait(10)
            end
        end)
    end
end

local function spawnPacificObj()
    local TrolleyModel = 'hei_prop_hei_cash_trolly_01'
    RequestModel(TrolleyModel)
    Citizen.Wait(100)
    PacificTrolley1 = CreateObject(269934519, 266.15, 215.05, 100.68, 1, 0, 0)
    PacificTrolley2 = CreateObject(269934519, 264.94, 212.21, 100.68, 1, 0, 0)
    PacificTrolley3 = CreateObject(269934519, 262.23, 213.22, 100.68, 1, 0, 0)
    PacificTrolley4 = CreateObject(269934519, 263.27, 216.36, 100.68, 1, 0, 0)
    SetEntityHeading(PacificTrolley1, 71.21)
    SetEntityHeading(PacificTrolley2, 61.03)
    SetEntityHeading(PacificTrolley3, 338.01)
    SetEntityHeading(PacificTrolley4, 159.99)
    
    CreateThread(function()
        exports['qb-target']:AddCircleZone('trolley1', vector3(266.15, 215.05, 100.68), 0.65, {
            name = 'trolley1',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startPacificCashGrab1',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
        exports['qb-target']:AddCircleZone('trolley2', vector3(264.94, 212.21, 100.68), 0.65, {
            name = 'trolley2',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startPacificCashGrab2',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
        exports['qb-target']:AddCircleZone('trolley3', vector3(262.23, 213.22, 100.68), 0.65, {
            name = 'trolley3',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startPacificCashGrab3',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
        exports['qb-target']:AddCircleZone('trolley4', vector3(263.27, 216.36, 100.68), 0.65, {
            name = 'trolley4',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startPacificCashGrab4',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
    end)
end

local function grabCash(cartLocation)
    local animDict = 'anim@heists@ornate_bank@grab_cash'
    local emptyObj = 769923921
    local ped = PlayerPedId()

    if cartLocation == 1 then
        trolley = PacificTrolley1
        trolleyPos = vector3(266.15, 215.05, 101.16)
        trolleyRot = GetEntityRotation(PacificTrolley1)
        trolleyHeading = 71.21
        RequestAnimDict(animDict)
        RequestModel('hei_p_m_bag_var22_arm_s')
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'bag_grab', 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

        NetworkStartSynchronisedScene(netScene)
        Wait(36900)
        NetworkStopSynchronisedScene(netScene)

        EmptyTrolley1 = CreateObject(emptyObj, GetEntityCoords(trolley), true, false, false)
        SetEntityHeading(EmptyTrolley1, trolleyHeading)
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end
        DeleteObject(trolley)
        while DoesEntityExist(trolley) do
            Wait(1)
            DeleteObject(trolley)
        end
        PlaceObjectOnGroundProperly(EmptyTrolley1)
        DeleteObject(bag)
        FreezeEntityPosition(ped, false)
    elseif cartLocation == 2 then
        trolley = PacificTrolley2
        trolleyPos = vector3(264.94, 212.21, 101.16)
        trolleyRot = GetEntityRotation(PacificTrolley2)
        trolleyHeading = 61.03
        RequestAnimDict(animDict)
        RequestModel('hei_p_m_bag_var22_arm_s')
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'bag_grab', 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

        NetworkStartSynchronisedScene(netScene)
        Wait(36900)
        NetworkStopSynchronisedScene(netScene)

        EmptyTrolley2 = CreateObject(emptyObj, GetEntityCoords(trolley), true, false, false)
        SetEntityHeading(EmptyTrolley2, trolleyHeading)
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end
        DeleteObject(trolley)
        while DoesEntityExist(trolley) do
            Wait(1)
            DeleteObject(trolley)
        end
        PlaceObjectOnGroundProperly(EmptyTrolley2)
        DeleteObject(bag)
        FreezeEntityPosition(ped, false)
    elseif cartLocation == 3 then
        trolley = PacificTrolley3
        trolleyPos = vector3(262.23, 213.22, 101.16)
        trolleyRot = GetEntityRotation(PacificTrolley3)
        trolleyHeading = 338.01
        RequestAnimDict(animDict)
        RequestModel('hei_p_m_bag_var22_arm_s')
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'bag_grab', 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

        NetworkStartSynchronisedScene(netScene)
        Wait(36900)
        NetworkStopSynchronisedScene(netScene)

        EmptyTrolley3 = CreateObject(emptyObj, GetEntityCoords(trolley), true, false, false)
        SetEntityHeading(EmptyTrolley3, trolleyHeading)
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end
        DeleteObject(trolley)
        while DoesEntityExist(trolley) do
            Wait(1)
            DeleteObject(trolley)
        end
        PlaceObjectOnGroundProperly(EmptyTrolley3)
        DeleteObject(bag)
        FreezeEntityPosition(ped, false)
    elseif cartLocation == 4 then
        trolley = PacificTrolley4
        trolleyPos = vector3(263.27, 216.36, 101.16)
        trolleyRot = GetEntityRotation(PacificTrolley4)
        trolleyHeading = 159.99
        RequestAnimDict(animDict)
        RequestModel('hei_p_m_bag_var22_arm_s')
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'bag_grab', 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

        NetworkStartSynchronisedScene(netScene)
        Wait(36900)
        NetworkStopSynchronisedScene(netScene)

        EmptyTrolley4 = CreateObject(emptyObj, GetEntityCoords(trolley), true, false, false)
        SetEntityHeading(EmptyTrolley4, trolleyHeading)
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end
        DeleteObject(trolley)
        while DoesEntityExist(trolley) do
            Wait(1)
            DeleteObject(trolley)
        end
        PlaceObjectOnGroundProperly(EmptyTrolley4)
        DeleteObject(bag)
        FreezeEntityPosition(ped, false)
    end

    if cartLocation == 1 then
        removePacificTarget('trolley1')
    elseif cartLocation == 2 then
        removePacificTarget('trolley2')
    elseif cartLocation == 3 then
        removePacificTarget('trolley3')
    elseif cartLocation == 4 then
        removePacificTarget('trolley4')
    end

    TriggerServerEvent('qb-bankrobbery:server:recieveItem', 'pacific')
end

-- Events

RegisterNetEvent('qb-bankrobbery:client:deletePacificTrolleys', function()
    DeleteObject(EmptyTrolley1)
    DeleteObject(EmptyTrolley2)
    DeleteObject(EmptyTrolley3)
    DeleteObject(EmptyTrolley4)
    DeleteObject(PacificTrolley1)
    DeleteObject(PacificTrolley2)
    DeleteObject(PacificTrolley3)
    DeleteObject(PacificTrolley4)
    removePacificTarget('trolley1')
    removePacificTarget('trolley2')
    removePacificTarget('trolley3')
    removePacificTarget('trolley4')

    copsCalled = false
end)

RegisterNetEvent('qb-bankrobbery:client:startPacificCashGrab1', function()
    grabCash(1)
end)

RegisterNetEvent('qb-bankrobbery:client:startPacificCashGrab2', function()
    grabCash(2)
end)

RegisterNetEvent('qb-bankrobbery:client:startPacificCashGrab3', function()
    grabCash(3)
end)

RegisterNetEvent('qb-bankrobbery:client:startPacificCashGrab4', function()
    grabCash(4)
end)

RegisterNetEvent('qb-bankrobbery:client:usePacificLaptop', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dist = #(pos - Config.BigBanks['pacific']['coords'][2])
    if dist < 1.5 then
        QBCore.Functions.TriggerCallback('qb-bankrobbery:server:isPacificActive', function(isBusy)
            if not isBusy then
                local dist = #(pos - Config.BigBanks['pacific']['coords'][2])
                if dist < 1.5 then
                    if CurrentCops >= Config.MinimumPacificPolice then
                        if not Config.BigBanks['pacific']['isOpened'] then
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                if result then
                                    if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
                                        TriggerServerEvent('evidence:server:CreateFingerDrop', pos)
                                    end
                                    TriggerServerEvent('QBCore:Server:RemoveItem', 'electronickit', 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['electronickit'], 'remove')
                                    TriggerServerEvent('qb-durability:server:RemoveItemQuality', 34, 'laptop_pacific')

                                    local animDict = 'anim@heists@ornate_bank@hack'
                                    RequestAnimDict(animDict)
                                    RequestModel('hei_prop_hst_laptop')
                                    RequestModel('hei_p_m_bag_var22_arm_s')
                                    RequestModel('hei_prop_heist_card_hack_02')
                                    while not HasAnimDictLoaded(animDict)
                                        or not HasModelLoaded('hei_prop_hst_laptop')
                                        or not HasModelLoaded('hei_p_m_bag_var22_arm_s')
                                        or not HasModelLoaded('hei_prop_heist_card_hack_02') do
                                        Wait(100)
                                    end
                                    local ped = PlayerPedId()
                                    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
                                    local animPos = GetAnimInitialOffsetPosition(animDict, 'hack_enter', 253.34, 228.25, 101.39, 253.34, 228.25, 101.39, 0, 2) -- Animasyon kordinatları, buradan lokasyonu değiştirin // These are fixed locations so if you want to change animation location change here
                                    local animPos2 = GetAnimInitialOffsetPosition(animDict, 'hack_loop', 253.34, 228.25, 101.39, 253.34, 228.25, 101.39, 0, 2)
                                    local animPos3 = GetAnimInitialOffsetPosition(animDict, 'hack_exit', 253.34, 228.25, 101.39, 253.34, 228.25, 101.39, 0, 2)
                                    -- part1
                                    FreezeEntityPosition(ped, true)
                                    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
                                    local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), targetPosition, 1, 1, 0)
                                    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'hack_enter_bag', 4.0, -8.0, 1)
                                    local laptop = CreateObject(GetHashKey('hei_prop_hst_laptop'), targetPosition, 1, 1, 0)
                                    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, 'hack_enter_laptop', 4.0, -8.0, 1)
                                    local card = CreateObject(GetHashKey('hei_prop_heist_card_hack_02'), targetPosition, 1, 1, 0)
                                    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, 'hack_enter_card', 4.0, -8.0, 1)
                                    -- part2
                                    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
                                    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, 'hack_loop_bag', 4.0, -8.0, 1)
                                    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, 'hack_loop_laptop', 4.0, -8.0, 1)
                                    NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, 'hack_loop_card', 4.0, -8.0, 1)
                                    -- part3
                                    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, 'hack_exit', 1.5, -4.0, 1, 16, 1148846080, 0)
                                    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, 'hack_exit_bag', 4.0, -8.0, 1)
                                    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, 'hack_exit_laptop', 4.0, -8.0, 1)
                                    NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, 'hack_exit_card', 4.0, -8.0, 1)

                                    SetEntityHeading(ped, 63.60) -- Animasyon düzgün oturması için yön // for proper animation direction

                                    NetworkStartSynchronisedScene(netScene)
                                    Wait(5550) -- Burayı deneyerek daha iyi hale getirebilirsiniz // You can try editing this to make transitions perfect
                                    NetworkStopSynchronisedScene(netScene)

                                    NetworkStartSynchronisedScene(netScene2)
                                    Wait(4500)
                                    exports['hacking']:OpenHackingGame(function(success)
                                        if success then
                                            TriggerServerEvent('qb-bankrobbery:server:setBankState', 'pacific', true)
                                            TriggerServerEvent('qb-bankrobbery:server:spawnPacificCarts')

                                            NetworkStopSynchronisedScene(netScene2)
                                            NetworkStartSynchronisedScene(netScene3)
                                            Wait(4500)
                                            NetworkStopSynchronisedScene(netScene3)

                                            DeleteObject(bag)
                                            DeleteObject(laptop)
                                            DeleteObject(card)
                                            FreezeEntityPosition(ped, false)
                                            if not blackoutIsActive then
                                                if not copsCalled then
                                                    -- local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Pacific Standard Pank'}
                                                    -- local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(261.95, 223.11, 106.28)}
                                                    -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                                                    exports['qb-dispatch']:PacificBankRobbery()
                                                    copsCalled = true
                                                end
                                            end
                                            TriggerServerEvent('qb-bankrobbery:server:laptopAlert', 'pacific')
                                        else
                                            QBCore.Functions.Notify('Hack Ebaõnnestus', 'error')
                                            NetworkStopSynchronisedScene(netScene2)
                                            NetworkStartSynchronisedScene(netScene3)
                                            Wait(4500)
                                            NetworkStopSynchronisedScene(netScene3)

                                            DeleteObject(bag)
                                            DeleteObject(laptop)
                                            DeleteObject(card)
                                            FreezeEntityPosition(ped, false)
                                            if not blackoutIsActive then
                                                if not copsCalled then
                                                    -- local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Pacific Standard Pank'}
                                                    -- local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(261.95, 223.11, 106.28)}
                                                    -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                                                    exports['qb-dispatch']:PacificBankRobbery()
                                                    copsCalled = true
                                                end
                                            end
                                        end
                                    end)
                                else
                                    QBCore.Functions.Notify('Sul on midagi puudu', 'error')
                                end
                            end, 'electronickit')
                        else
                            QBCore.Functions.Notify('Uks on juba avatud', 'error')
                        end
                    else
                        QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke. Vaja ('..Config.MinimumPacificPolice..')', 'error')
                    end
                end
            else
                QBCore.Functions.Notify('Turvalukk on aktiivne, hetkel ei saa ust avada', 'error')
            end
        end)
    end
end)

RegisterNetEvent('qb-bankrobbery:client:useElectronicKit', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dist = #(pos - Config.BigBanks['pacific']['coords'][1])
    if dist < 1.5 then
        QBCore.Functions.TriggerCallback('qb-bankrobbery:server:isPacificActive', function(isBusy)
            if not isBusy then
                local dist = #(pos - Config.BigBanks['pacific']['coords'][1])
                if dist < 1.5 then
                    if CurrentCops >= Config.MinimumPacificPolice then
                        if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
                            TriggerServerEvent('evidence:server:CreateFingerDrop', pos)
                        end
                        TriggerServerEvent('QBCore:Server:RemoveItem', 'electronickit', 1)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['electronickit'], 'remove')
                        QBCore.Functions.Progressbar('hack_gate', 'Ühendab seadet...', math.random(5000, 10000), false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = 'anim@gangops@facility@servers@',
                            anim = 'hotwire',
                            flags = 16,
                        }, {}, {}, function() -- Done
                            StopAnimTask(PlayerPedId(), 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                            local minigame = exports['hackingminigame']:Open()
                            if minigame == true then
                                TriggerServerEvent('qb-doorlock:server:updateState', 1, false, false, false, true)
                                if not blackoutIsActive then
                                    if not copsCalled then
                                        -- local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Pacific Standard Pank'}
                                        -- local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(261.95, 223.11, 106.28)}
                                        -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                                        exports['qb-dispatch']:PacificBankRobbery()
                                        copsCalled = true
                                    end
                                end
                                TriggerServerEvent('qb-bankrobbery:server:electronickitAlert')
                            else
                                QBCore.Functions.Notify('Ebaõnnestus', 'error')
                                if not blackoutIsActive then
                                    if not copsCalled then
                                        -- local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Pacific Standard Pank'}
                                        -- local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(261.95, 223.11, 106.28)}
                                        -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                                        exports['qb-dispatch']:PacificBankRobbery()
                                        copsCalled = true
                                    end
                                end
                            end
                        end, function() -- Cancel
                            StopAnimTask(PlayerPedId(), 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                            QBCore.Functions.Notify('Katkestatud', 'error')
                        end)
                    else
                        QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke. Vaja ('..Config.MinimumPacificPolice..')', 'error')
                    end
                end
            else
                QBCore.Functions.Notify('Turvalukk on aktiivne, hetkel ei saa ust avada', 'error')
            end
        end)
    end
end)

RegisterNetEvent('qb-bankrobbery:client:spawnPacificCarts', function()
    spawnPacificObj()
end)