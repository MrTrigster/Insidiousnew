local QBCore = exports['qb-core']:GetCoreObject()

local PaletoTrolley1 = nil
local PaletoTrolley2 = nil

local EmptyTrolley1 = nil
local EmptyTrolley2 = nil

local copsCalled = false

-- Functions

local function removePaletoTarget(targetName)
    CreateThread(function()
        exports['qb-target']:RemoveZone(targetName)
    end)
end

function OpenPaletoDoor()
    local paletoDoor = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
    local entityHeading = Config.BigBanks['paleto']['heading'].closed

    if object ~= 0 then
        SetEntityHeading(paletoDoor, Config.BigBanks['paleto']['heading'].open)
    end
end

local function spawnPaletoObj()
    local TrolleyModel = 'hei_prop_hei_cash_trolly_01'
    RequestModel(TrolleyModel)
    Citizen.Wait(100)
    PaletoTrolley1 = CreateObject(269934519, -104.39, 6478.74, 30.63, 1, 0, 0)
    PaletoTrolley2 = CreateObject(269934519, -103.72, 6475.46, 30.63, 1, 0, 0)
    SetEntityHeading(PaletoTrolley1, 96.45)
    SetEntityHeading(PaletoTrolley2, 69.73)

    CreateThread(function()
        exports['qb-target']:AddCircleZone('paletotrolley1', vector3(-104.39, 6478.74, 30.63), 0.65, {
            name = 'paletotrolley1',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'i13-bankrobbery:client:startPaletoCashGrab1',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
        exports['qb-target']:AddCircleZone('paletotrolley2', vector3(-103.72, 6475.46, 30.63), 0.65, {
            name = 'paletotrolley2',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'i13-bankrobbery:client:startPaletoCashGrab2',
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
        trolley = PaletoTrolley1
        trolleyPos = vector3(-104.39, 6478.74, 31.11)
        trolleyRot = GetEntityRotation(PaletoTrolley1)
        trolleyHeading = 96.45
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
        trolley = PaletoTrolley2
        trolleyPos = vector3(-103.72, 6475.46, 31.11)
        trolleyRot = GetEntityRotation(PaletoTrolley2)
        trolleyHeading = 69.73
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
    end

    if cartLocation == 1 then
        removePaletoTarget('paletotrolley1')
    elseif cartLocation == 2 then
        removePaletoTarget('paletotrolley2')
    end

    TriggerServerEvent('i13-bankrobbery:server:recieveItem', 'paleto')
end

-- Events

RegisterNetEvent('i13-bankrobbery:client:deletePaletoTrolleys', function()
    DeleteObject(EmptyTrolley1)
    DeleteObject(EmptyTrolley2)
    DeleteObject(PaletoTrolley1)
    DeleteObject(PaletoTrolley2)
    removePaletoTarget('paletotrolley1')
    removePaletoTarget('paletotrolley2')

    copsCalled = false
end)

RegisterNetEvent('i13-bankrobbery:client:startPaletoCashGrab1', function()
    grabCash(1)
end)

RegisterNetEvent('i13-bankrobbery:client:startPaletoCashGrab2', function()
    grabCash(2)
end)

RegisterNetEvent('i13-bankrobbery:client:usePaletoLaptop', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dist = #(pos - Config.BigBanks['paleto']['coords'])
    if dist < 1.5 then
        QBCore.Functions.TriggerCallback('i13-bankrobbery:server:isPaletoActive', function(isBusy)
            if not isBusy then
                local dist = #(pos - Config.BigBanks['paleto']['coords'])
                if dist < 1.5 then
                    if CurrentCops >= Config.MinimumPaletoPolice then
                        if not Config.BigBanks['paleto']['isOpened'] then
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                if result then
                                    if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
                                        TriggerServerEvent('evidence:server:CreateFingerDrop', pos)
                                    end
                                    TriggerServerEvent('QBCore:Server:RemoveItem', 'electronickit', 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['electronickit'], 'remove')
                                    TriggerServerEvent('i13-durability:server:RemoveItemQuality', 34, 'laptop_paleto')
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
                                        exports['hacking']:OpenHackingGame(function(success)
                                            if success then
                                                TriggerServerEvent('i13-bankrobbery:server:setBankState', 'paleto', true)
                                                TriggerServerEvent('i13-bankrobbery:server:spawnPaletoCarts')
                                                if not blackoutIsActive then
                                                    if not copsCalled then
                                                        -- local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Paleto Bay Pank'}
                                                        -- local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(-105.61, 6472.03, 31.62)}
                                                        -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                                                        exports['qb-dispatch']:PaletoBankRobbery()
                                                        copsCalled = true
                                                    end
                                                end
                                                TriggerServerEvent('i13-bankrobbery:server:laptopAlert', 'paleto')
                                            else
                                                QBCore.Functions.Notify('Hack Ebaõnnestus', 'error')
                                                if not blackoutIsActive then
                                                    if not copsCalled then
                                                        -- local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Paleto Bay Pank'}
                                                        -- local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(-105.61, 6472.03, 31.62)}
                                                        -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                                                        exports['qb-dispatch']:PaletoBankRobbery()
                                                        copsCalled = true
                                                    end
                                                end
                                            end
                                        end)    
                                    end, function() -- Cancel
                                        StopAnimTask(PlayerPedId(), 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                                        QBCore.Functions.Notify('Katkestatud', 'error')
                                    end)
                                else
                                    QBCore.Functions.Notify('Sul on midagi puudu', 'error')
                                end
                            end, 'electronickit')
                        else
                            QBCore.Functions.Notify('Uks on juba avatud', 'error')
                        end
                    else
                        QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke. Vaja ('..Config.MinimumPaletoPolice..')', 'error')
                    end
                end
            else
                QBCore.Functions.Notify('Turvalukk on aktiivne, hetkel ei saa ust avada', 'error')
            end
        end)
    end
end)

RegisterNetEvent('i13-bankrobbery:client:spawnPaletoCarts', function()
    spawnPaletoObj()
end)