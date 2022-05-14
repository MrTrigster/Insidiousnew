local QBCore = exports['qb-core']:GetCoreObject()
local copsCalled1 = false
local copsCalled2 = false
local copsCalled3 = false
local copsCalled4 = false
local copsCalled5 = false
local copsCalled6 = false
local inRange
local PlayerJob = {}
local closestBank = nil
CurrentCops = 0
CurrentThermiteGate = 0

local FleecaOneTrolley = nil
local FleecaTwoTrolley = nil
local FleecaThreeTrolley = nil
local FleecaFourTrolley = nil
local FleecaFiveTrolley = nil
local FleecaSixTrolley = nil

local EmptyTrolley1 = nil
local EmptyTrolley2 = nil
local EmptyTrolley3 = nil
local EmptyTrolley4 = nil
local EmptyTrolley5 = nil
local EmptyTrolley6 = nil

-- Handlers

local function ResetBankDoors()
    for k,v in pairs(Config.SmallBanks) do
        local fleecaDoor = GetClosestObjectOfType(Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"], 5.0, Config.SmallBanks[k]["object"], false, false, false)
        if not Config.SmallBanks[k]['isOpened'] then
            SetEntityHeading(fleecaDoor, Config.SmallBanks[k]['heading'].closed)
        else
            SetEntityHeading(fleecaDoor, Config.SmallBanks[k]['heading'].open)
        end
    end

    if not Config.BigBanks["paleto"]["isOpened"] then
        local paletoDoor = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
        SetEntityHeading(paletoDoor, Config.BigBanks["paleto"]["heading"].closed)
    else
        local paletoDoor = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
        SetEntityHeading(paletoDoor, Config.BigBanks["paleto"]["heading"].open)
    end

    if not Config.BigBanks["pacific"]["isOpened"] then
        local pacificDoor = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
        SetEntityHeading(pacificDoor, Config.BigBanks["pacific"]["heading"].closed)
    else
        local pacificDoor = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
        SetEntityHeading(pacificDoor, Config.BigBanks["pacific"]["heading"].open)
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ResetBankDoors()
        --TriggerServerEvent('qb-bankrobbery:server:resetThermiteDoors')
        TriggerEvent('qb-bankrobbery:client:deletePacificTrolleys')
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:GetConfig', function(config)
        Config = config
    end)
    onDuty = true
    ResetBankDoors()
end)

-- Functions

local function removeFleecaTarget(targetName)
    CreateThread(function()
        exports['qb-target']:RemoveZone(targetName)
    end)
end

function IsWearingHandshoes() -- Globally Used
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
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

local function OpenBankDoor(bankId)
    local object = GetClosestObjectOfType(Config.SmallBanks[bankId]["coords"]["x"], Config.SmallBanks[bankId]["coords"]["y"], Config.SmallBanks[bankId]["coords"]["z"], 5.0, Config.SmallBanks[bankId]["object"], false, false, false)
    local entityHeading = Config.SmallBanks[bankId]['heading'].closed
    if object ~= 0 then
        CreateThread(function()
            while true do
                if entityHeading ~= Config.SmallBanks[bankId]['heading'].open then
                    SetEntityHeading(object, entityHeading - 10)
                    entityHeading = entityHeading - 0.5
                else
                    break
                end
                Wait(10)
            end
        end)
    end
end



local function spawnFleecaOneObj()
    local TrolleyModel = 'hei_prop_hei_cash_trolly_01'
    RequestModel(TrolleyModel)
    Citizen.Wait(100)
    FleecaOneTrolley = CreateObject(269934519, 311.47, -288.25, 53.15, 1, 0, 0)

    SetEntityHeading(FleecaOneTrolley, 338.86)
    
    CreateThread(function()
        exports['qb-target']:AddCircleZone('fleecatrolley1', vector3(311.47, -288.25, 53.15), 0.65, {
            name = 'fleecatrolley1',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startFleeca1CashGrab',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
    end)
end

local function spawnFleecaTwoObj()
    local TrolleyModel = 'hei_prop_hei_cash_trolly_01'
    RequestModel(TrolleyModel)
    Citizen.Wait(100)
    FleecaTwoTrolley = CreateObject(269934519, 147.64, -1047.77, 28.35, 1, 0, 0)

    SetEntityHeading(FleecaTwoTrolley, 249.41)
    
    CreateThread(function()
        exports['qb-target']:AddCircleZone('fleecatrolley2', vector3(147.64, -1047.77, 28.35), 0.65, {
            name = 'fleecatrolley2',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startFleeca2CashGrab',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
    end)
end

local function spawnFleecaThreeObj()
    local TrolleyModel = 'hei_prop_hei_cash_trolly_01'
    RequestModel(TrolleyModel)
    Citizen.Wait(100)
    FleecaThreeTrolley = CreateObject(269934519, -351.09, -59.92, 48.01, 1, 0, 0)

    SetEntityHeading(FleecaThreeTrolley, 15.06)
    
    CreateThread(function()
        exports['qb-target']:AddCircleZone('fleecatrolley3', vector3(-351.09, -59.92, 48.01), 0.65, {
            name = 'fleecatrolley3',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startFleeca3CashGrab',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
    end)
end

local function spawnFleecaFourObj()
    local TrolleyModel = 'hei_prop_hei_cash_trolly_01'
    RequestModel(TrolleyModel)
    Citizen.Wait(100)
    FleecaFourTrolley = CreateObject(269934519, -1206.08, -335.83, 36.76, 1, 0, 0)

    SetEntityHeading(FleecaFourTrolley, 114.78)
    
    CreateThread(function()
        exports['qb-target']:AddCircleZone('fleecatrolley4', vector3(-1206.08, -335.83, 36.76), 0.65, {
            name = 'fleecatrolley4',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startFleeca4CashGrab',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
    end)
end

local function spawnFleecaFiveObj()
    local TrolleyModel = 'hei_prop_hei_cash_trolly_01'
    RequestModel(TrolleyModel)
    Citizen.Wait(100)
    FleecaFiveTrolley = CreateObject(269934519, -2954.09, 482.6, 14.68, 1, 0, 0)

    SetEntityHeading(FleecaFiveTrolley, 358.15)
    
    CreateThread(function()
        exports['qb-target']:AddCircleZone('fleecatrolley5', vector3(-2954.09, 482.6, 14.68), 0.65, {
            name = 'fleecatrolley5',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startFleeca5CashGrab',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
    end)
end

local function spawnFleecaSixObj()
    local TrolleyModel = 'hei_prop_hei_cash_trolly_01'
    RequestModel(TrolleyModel)
    Citizen.Wait(100)
    FleecaSixTrolley = CreateObject(269934519, 1171.79, 2716.24, 37.07, 1, 0, 0)

    SetEntityHeading(FleecaSixTrolley, 269.14)

    CreateThread(function()
        exports['qb-target']:AddCircleZone('fleecatrolley6', vector3(1171.79, 2716.24, 37.07), 0.65, {
            name = 'fleecatrolley6',
            debugPoly = false,
        }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:startFleeca6CashGrab',
                    icon = 'fas fa-dollar-sign',
                    label = 'Võta Raha',
                }
            },
            distance = 1.5,
        })
    end)
end



local function grabCash(cartLocation)
    local animDict = "anim@heists@ornate_bank@grab_cash"
    local emptyObj = 769923921
    local ped = PlayerPedId()
    if cartLocation == 1 then
        trolley = FleecaOneTrolley
        trolleyPos = vector3(311.47, -288.25, 53.65)
        trolleyRot = GetEntityRotation(FleecaOneTrolley)
        trolleyHeading = 338.86
        RequestAnimDict(animDict)
        RequestModel("hei_p_m_bag_var22_arm_s")
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, "cart_cash_dissapear", 4.0, -8.0, 1)

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
        trolley = FleecaTwoTrolley
        trolleyPos = vector3(147.64, -1047.77, 28.85)
        trolleyRot = GetEntityRotation(FleecaTwoTrolley)
        trolleyHeading = 249.41
        RequestAnimDict(animDict)
        RequestModel("hei_p_m_bag_var22_arm_s")
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, "cart_cash_dissapear", 4.0, -8.0, 1)

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
        trolley = FleecaThreeTrolley
        trolleyPos = vector3(-351.09, -59.92, 48.51)
        trolleyRot = GetEntityRotation(FleecaThreeTrolley)
        trolleyHeading = 15.06
        RequestAnimDict(animDict)
        RequestModel("hei_p_m_bag_var22_arm_s")
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, "cart_cash_dissapear", 4.0, -8.0, 1)

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
        trolley = FleecaFourTrolley
        trolleyPos = vector3(-1206.08, -335.83, 37.26)
        trolleyRot = GetEntityRotation(FleecaFourTrolley)
        trolleyHeading = 114.78
        RequestAnimDict(animDict)
        RequestModel("hei_p_m_bag_var22_arm_s")
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, "cart_cash_dissapear", 4.0, -8.0, 1)

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
    elseif cartLocation == 5 then
        trolley = FleecaFiveTrolley
        trolleyPos = vector3(-2954.09, 482.6, 15.18)
        trolleyRot = GetEntityRotation(FleecaFiveTrolley)
        trolleyHeading = 358.15
        RequestAnimDict(animDict)
        RequestModel("hei_p_m_bag_var22_arm_s")
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, "cart_cash_dissapear", 4.0, -8.0, 1)

        NetworkStartSynchronisedScene(netScene)
        Wait(36900)
        NetworkStopSynchronisedScene(netScene)

        EmptyTrolley5 = CreateObject(emptyObj, GetEntityCoords(trolley), true, false, false)
        SetEntityHeading(EmptyTrolley5, trolleyHeading)
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end
        DeleteObject(trolley)
        while DoesEntityExist(trolley) do
            Wait(1)
            DeleteObject(trolley)
        end
        PlaceObjectOnGroundProperly(EmptyTrolley5)
        DeleteObject(bag)
        FreezeEntityPosition(ped, false)
    elseif cartLocation == 6 then
        trolley = FleecaSixTrolley
        trolleyPos = vector3(1171.79, 2716.24, 37.57)
        trolleyRot = GetEntityRotation(FleecaSixTrolley)
        trolleyHeading = 269.14
        RequestAnimDict(animDict)
        RequestModel("hei_p_m_bag_var22_arm_s")
        while not HasAnimDictLoaded(animDict) or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
            Citizen.Wait(100)
        end
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end

        FreezeEntityPosition(ped, true)
        local netScene = NetworkCreateSynchronisedScene(trolleyPos, trolleyRot, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), trolleyPos, 1, 1, 0)
        NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(trolley, netScene, animDict, "cart_cash_dissapear", 4.0, -8.0, 1)

        NetworkStartSynchronisedScene(netScene)
        Wait(36900)
        NetworkStopSynchronisedScene(netScene)

        EmptyTrolley6 = CreateObject(emptyObj, GetEntityCoords(trolley), true, false, false)
        SetEntityHeading(EmptyTrolley6, trolleyHeading)
        while not NetworkHasControlOfEntity(trolley) do
            Wait(1)
            NetworkRequestControlOfEntity(trolley)
        end
        DeleteObject(trolley)
        while DoesEntityExist(trolley) do
            Wait(1)
            DeleteObject(trolley)
        end
        PlaceObjectOnGroundProperly(EmptyTrolley6)
        DeleteObject(bag)
        FreezeEntityPosition(ped, false)
    end

    if cartLocation == 1 then
        removeFleecaTarget('fleecatrolley1')
    elseif cartLocation == 2 then
        removeFleecaTarget('fleecatrolley2')
    elseif cartLocation == 3 then
        removeFleecaTarget('fleecatrolley3')
    elseif cartLocation == 4 then
        removeFleecaTarget('fleecatrolley4')
    elseif cartLocation == 5 then
        removeFleecaTarget('fleecatrolley5')
    elseif cartLocation == 6 then
        removeFleecaTarget('fleecatrolley6')
    end

    TriggerServerEvent('qb-bankrobbery:server:recieveItem', 'fleeca')
end

-- Events

RegisterNetEvent('qb-bankrobbery:client:startFleeca1CashGrab', function()
    grabCash(1)
end)

RegisterNetEvent('qb-bankrobbery:client:startFleeca2CashGrab', function()
    grabCash(2)
end)

RegisterNetEvent('qb-bankrobbery:client:startFleeca3CashGrab', function()
    grabCash(3)
end)

RegisterNetEvent('qb-bankrobbery:client:startFleeca4CashGrab', function()
    grabCash(4)
end)

RegisterNetEvent('qb-bankrobbery:client:startFleeca5CashGrab', function()
    grabCash(5)
end)

RegisterNetEvent('qb-bankrobbery:client:startFleeca6CashGrab', function()
    grabCash(6)
end)

RegisterNetEvent('qb-bankrobbery:client:setBankState', function(bankId, state)
    if bankId == 'pacific' then
        Config.BigBanks['pacific']['isOpened'] = state
        if state then
            OpenPacificDoor()
        end
    elseif bankId == 'paleto' then
        Config.BigBanks['paleto']['isOpened'] = state
        if state then
            OpenPaletoDoor()
        end
    else
        Config.SmallBanks[bankId]['isOpened'] = state
        if state then
            OpenBankDoor(bankId)
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:client:useFleecaLaptop', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if closestBank ~= nil then
        QBCore.Functions.TriggerCallback('qb-bankrobbery:server:isRobberyActive', function(isBusy)
            if not isBusy then
                if closestBank ~= nil then
                    local dist = #(pos - Config.SmallBanks[closestBank]['coords'])
                    if dist < 1.5 then
                        if CurrentCops >= Config.MinimumFleecaPolice then
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                if result then
                                    if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
                                        TriggerServerEvent('evidence:server:CreateFingerDrop', pos)
                                    end
                                    TriggerServerEvent('QBCore:Server:RemoveItem', 'electronickit', 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['electronickit'], 'remove')
                                    TriggerServerEvent('qb-durability:server:RemoveItemQuality', 34, 'laptop_fleeca')
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
                                                TriggerServerEvent('qb-bankrobbery:server:setBankState', closestBank, true)
                                                TriggerServerEvent('qb-bankrobbery:server:spawnFleecaCarts', closestBank)
                                                -- TriggerEvent('qb-bankrobbery:client:callCops', closestBank)
                                                exports['qb-dispatch']:FleecaBankRobbery()
                                                TriggerServerEvent('qb-bankrobbery:server:laptopAlert', closestBank)
                                            else
                                                QBCore.Functions.Notify('Hack Ebaõnnestus', 'error')
                                                -- TriggerEvent('qb-bankrobbery:client:callCops', closestBank)
                                                exports['qb-dispatch']:FleecaBankRobbery()
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
                            QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke. Vaja ('..Config.MinimumFleecaPolice..')', 'error')
                        end
                    end
                end
            else
                QBCore.Functions.Notify('Turvalukk on aktiivne, hetkel ei saa ust avada', 'error')
            end
        end, closestBank)
    end
end)

-- RegisterNetEvent('qb-bankrobbery:client:callCops', function(bank)
--     if bank == 'fleeca1' then
--         if not blackoutIsActive then
--             if not copsCalled1 then
--                 local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Fleeca Pank'}
--                 local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(311.15, -284.49, 54.16)}
--                 TriggerServerEvent('wf-alerts:svNotify', dispatchData)
--                 copsCalled1 = true
--             end
--         end
--     elseif bank == 'fleeca2' then
--         if not blackoutIsActive then
--             if not copsCalled2 then
--                 local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Fleeca Pank'}
--                 local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(146.92, -1046.11, 29.36)}
--                 TriggerServerEvent('wf-alerts:svNotify', dispatchData)
--                 copsCalled2 = true
--             end
--         end
--     elseif bank == 'fleeca3' then
--         if not blackoutIsActive then
--             if not copsCalled3 then
--                 local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Fleeca Pank'}
--                 local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(-353.82, -55.37, 49.03)}
--                 TriggerServerEvent('wf-alerts:svNotify', dispatchData)
--                 copsCalled3 = true
--             end
--         end
--     elseif bank == 'fleeca4' then
--         if not blackoutIsActive then
--             if not copsCalled4 then
--                 local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Fleeca Pank'}
--                 local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(-1210.77, -336.57, 37.78)}
--                 TriggerServerEvent('wf-alerts:svNotify', dispatchData)
--                 copsCalled4 = true
--             end
--         end
--     elseif bank == 'fleeca5' then
--         if not blackoutIsActive then
--             if not copsCalled5 then
--                 local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Fleeca Pank'}
--                 local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(-2956.55, 481.74, 15.69)}
--                 TriggerServerEvent('wf-alerts:svNotify', dispatchData)
--                 copsCalled5 = true
--             end
--         end
--     elseif bank == 'fleeca6' then
--         if not blackoutIsActive then
--             if not copsCalled6 then
--                 local data = {displayCode = '10-72', description = 'Pangarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Fleeca Pank'}
--                 local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(1175.96, 2712.87, 38.09)}
--                 TriggerServerEvent('wf-alerts:svNotify', dispatchData)
--                 copsCalled6 = true
--             end
--         end
--     end
-- end)

RegisterNetEvent('qb-bankrobbery:client:spawnFleecaCarts', function(bank)
    if bank == 'fleeca1' then
        spawnFleecaOneObj()
    elseif bank == 'fleeca2' then
        spawnFleecaTwoObj()
    elseif bank == 'fleeca3' then
        spawnFleecaThreeObj()
    elseif bank == 'fleeca4' then
        spawnFleecaFourObj()
    elseif bank == 'fleeca5' then
        spawnFleecaFiveObj()
    elseif bank == 'fleeca6' then
        spawnFleecaSixObj()
    end
end)

RegisterNetEvent('qb-bankrobbery:client:deleteFleeca1Trolleys', function()
    DeleteObject(EmptyTrolley1)
    DeleteObject(FleecaOneTrolley)
    removeFleecaTarget('fleecatrolley1')
    copsCalled1 = false
end)

RegisterNetEvent('qb-bankrobbery:client:deleteFleeca2Trolleys', function()
    DeleteObject(EmptyTrolley2)
    DeleteObject(FleecaTwoTrolley)
    removeFleecaTarget('fleecatrolley2')
    copsCalled2 = false
end)

RegisterNetEvent('qb-bankrobbery:client:deleteFleeca3Trolleys', function()
    DeleteObject(EmptyTrolley3)
    DeleteObject(FleecaThreeTrolley)
    removeFleecaTarget('fleecatrolley3')
    copsCalled3 = false
end)

RegisterNetEvent('qb-bankrobbery:client:deleteFleeca4Trolleys', function()
    DeleteObject(EmptyTrolley4)
    DeleteObject(FleecaFourTrolley)
    removeFleecaTarget('fleecatrolley4')
    copsCalled4 = false
end)

RegisterNetEvent('qb-bankrobbery:client:deleteFleeca5Trolleys', function()
    DeleteObject(EmptyTrolley5)
    DeleteObject(FleecaFiveTrolley)
    removeFleecaTarget('fleecatrolley5')
    copsCalled5 = false
end)

RegisterNetEvent('qb-bankrobbery:client:deleteFleeca6Trolleys', function()
    DeleteObject(EmptyTrolley6)
    DeleteObject(FleecaSixTrolley)
    removeFleecaTarget('fleecatrolley6')
    copsCalled6 = false
end)



RegisterNetEvent('qb-bankrobbery:client:useTestLaptop', function()
    TriggerServerEvent('qb-durability:server:RemoveItemQuality', 10, 'laptop_test')
    exports['hacking']:OpenHackingGame(function(success)
        if success then
            QBCore.Functions.Notify('Hack Edukas', 'success')
        else
            QBCore.Functions.Notify('Hack Ebaõnnestus', 'error')
        end
    end)
end)

-- Threads

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist

        if QBCore ~= nil then
            inRange = false

            for k,v in pairs(Config.SmallBanks) do
                dist = #(pos - Config.SmallBanks[k]['coords'])
                if dist < 15 then
                    closestBank = k
                    inRange = true
                end
            end

            if not inRange then
                Wait(2000)
                closestBank = nil
            end
        end
        Wait(3)
    end
end)