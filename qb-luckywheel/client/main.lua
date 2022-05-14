local QBCore = exports['qb-core']:GetCoreObject()
local _wheel = nil
local _lambo = nil
local _isShowCar = false
local _wheelPos = vector3(949.65, 45.00, 70.86) --vector3(925.13, 54.47, 71.26) | vector3(948.42, 44.67, 70.86)
local _baseWheelPos = vector3(949.65, 45.00, 70.6) --vector3(925.13, 54.47, 71.0) | vector3(948.42, 44.67, 70.6)
local _podiumModel = vector3(935.105, 42.56564, 71.2737) --Change to your coords for your casino MLO
local playerUpdate = false
local casinoprops = {}

local showCar = 't20'
local _isRolling = false

Citizen.CreateThread(function()
    if playerUpdate == false then
        PlayerData = QBCore.Functions.GetPlayerData()
		playerUpdate = true
    end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _,wheel in pairs(casinoprops) do
            DeleteEntity(_wheel)
            DeleteEntity(_basewheel)
            DeleteEntity(_lambo)
        end
	end
end)

local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function spawnveh()
    Zones = {
        VehicleSpawnPoint = {
            Pos   = {x = 935.01, y = 42.80, z = 71.43},
            Heading = 182.73
        }
    }
	local vehicle = nil
    local carmodel = GetHashKey(showCar)
    RequestModel(carmodel)
    while not HasModelLoaded(carmodel) do
        Citizen.Wait(0)
    end

	vehicle = CreateVehicle(carmodel, Zones.VehicleSpawnPoint.Pos.x, Zones.VehicleSpawnPoint.Pos.y, Zones.VehicleSpawnPoint.Pos.z, Zones.VehicleSpawnPoint.Heading, false, false)
	SetModelAsNoLongerNeeded(carmodel)
	Citizen.Wait(10)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleOnGroundProperly(vehicle)
    Citizen.Wait(10)
    FreezeEntityPosition(vehicle, true)
    SetEntityInvincible(vehicle, true)
    SetVehicleDoorsLocked(vehicle, 2)
    _lambo = vehicle
    table.insert(casinoprops, _lambo)
end

CreateThread(function()
    if playerUpdate then
        local model = GetHashKey('vw_prop_vw_luckywheel_02a')
        local baseWheelModel = GetHashKey('vw_prop_vw_luckywheel_01a')
        local podiumModel = GetHashKey('vw_prop_vw_casino_podium_01a')

        CreateThread(function()
            RequestModel(baseWheelModel)
            while not HasModelLoaded(baseWheelModel) do
                Wait(0)
            end

            _basewheel = CreateObject(baseWheelModel, _baseWheelPos.x, _baseWheelPos.y, _baseWheelPos.z, false, false, true)
            SetEntityHeading(_basewheel, 328.0)
            SetModelAsNoLongerNeeded(baseWheelModel)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end

            RequestModel(podiumModel)
            while not HasModelLoaded(podiumModel) do
                Citizen.Wait(0)
            end
            _podiumModel = CreateObject(podiumModel, _podiumModel.x, _podiumModel.y, _podiumModel.z, false, false, true)
            SetEntityHeading(_podiumModel, 0.0)
            SetModelAsNoLongerNeeded(podiumModel)

            _wheel = CreateObject(model, _wheelPos.x, _wheelPos.y, _wheelPos.z, false, false, true)
            SetEntityHeading(_wheel, 328.0)
            SetModelAsNoLongerNeeded(model)
            spawnveh()
            table.insert(casinoprops, _wheel)
            table.insert(casinoprops, _basewheel)
        end)
    end
end)

CreateThread(function()
    Casino = AddBlipForCoord(vector3(923.45, 47.36, 81.11))

    SetBlipSprite (Casino, 679)
    SetBlipDisplay(Casino, 4)
    SetBlipScale  (Casino, 1.0)
    SetBlipAsShortRange(Casino, true)
    SetBlipColour(Casino, 11)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Diamond Casino")
    EndTextCommandSetBlipName(Casino)
end)

CreateThread(function()
    while true do
        if _lambo ~= nil then
            local _heading = GetEntityHeading(_lambo)
            local _z = _heading - 0.1
            SetEntityHeading(_lambo, _z)
        end
        Wait(5)
    end
end)

CreateThread(function() 
    while true do
        if _podiumModel ~= nil then
            local _heading = GetEntityHeading(_podiumModel)
            local _z = _heading - 0.1
            SetEntityHeading(_podiumModel, _z)
        end
        Wait(5)
    end
end)

RegisterNetEvent("luckywheel:doRoll")
AddEventHandler("luckywheel:doRoll", function(_priceIndex)
    _isRolling = true
	SetEntityHeading(_wheel, 328.0) ---30.9754
    CreateThread(function()
        local speedIntCnt = 1
        local rollspeed = 1.0
        local _winAngle = (_priceIndex - 1) * 18
        local _rollAngle = _winAngle + (360 * 8)
        local _midLength = (_rollAngle / 2)
        local intCnt = 0
        while speedIntCnt > 0 do
            local retval = GetEntityRotation(_wheel, 1)
            if _rollAngle > _midLength then
                speedIntCnt = speedIntCnt + 1
            else
                speedIntCnt = speedIntCnt - 1
                if speedIntCnt < 0 then
                    speedIntCnt = 0
                    
                end
            end
            intCnt = intCnt + 1
            rollspeed = speedIntCnt / 10
            local _y = retval.y - rollspeed - _priceIndex
            _rollAngle = _rollAngle - rollspeed
			SetEntityHeading(_wheel, 328.0)
            SetEntityRotation(_wheel, 0.0, _y, 328.0, 2, true)
            Wait(5)
        end
    end)
end)

RegisterNetEvent("luckywheel:rollFinished")
AddEventHandler("luckywheel:rollFinished", function()
    _isRolling = false
end)

RegisterNetEvent('luckywheel:client:winCar', function(carName, plate)
    QBCore.Functions.SpawnVehicle(carName, function(veh)
        exports['LegacyFuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, plate)
        SetEntityHeading(veh, 147.78)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
        TriggerServerEvent('luckywheel:server:winCar', QBCore.Functions.GetVehicleProperties(veh), plate, carName)
    end, vector4(937.36, 34.63, 80.74, 147.78), true)

    DeleteEntity(vehicle)
end)

-- function doRoll()
--     if not _isRolling then
--         _isRolling = true
--         local playerPed = PlayerPedId()
--         local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
--         if IsPedMale(playerPed) then
--             _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
--         end
--         local lib, anim = _lib, 'enter_right_to_baseidle'
		
		
-- 		if not HasAnimDictLoaded(lib) then
-- 			RequestAnimDict(lib)
-- 		repeat Wait(0) until HasAnimDictLoaded(lib)
-- 		end
		
--         if HasAnimDictLoaded(lib) then
--             local _movePos = vector3(948.06, 44.83, 71.64)
--             TaskGoStraightToCoord(playerPed, _movePos.x, _movePos.y, _movePos.z, 1.0, -1, 328.0, 0.0)
--             local _isMoved = false
--             while not _isMoved do
--                 local coords = GetEntityCoords(PlayerPedId())
--                 if coords.x >= (_movePos.x - 0.01) and coords.x <= (_movePos.x + 0.01) and coords.y >= (_movePos.y - 0.01) and coords.y <= (_movePos.y + 0.01) then
--                     _isMoved = true
--                 end
--                 Citizen.Wait(400)
--             end
--             TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
--             while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
--                 Citizen.Wait(0)
--                 DisableAllControlActions(0)
--             end
--             TaskPlayAnim(playerPed, lib, 'enter_to_armraisedidle', 8.0, -8.0, -1, 0, 0, false, false, false)
--             while IsEntityPlayingAnim(playerPed, lib, 'enter_to_armraisedidle', 3) do
--                 Citizen.Wait(0)
--                 DisableAllControlActions(0)
--             end
--             TriggerServerEvent("luckywheel:getLucky", showCar)
--             TaskPlayAnim(playerPed, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
--         end
--     end
-- end

local function doRoll()
    if not _isRolling then
        _isRolling = true
        TriggerServerEvent("luckywheel:getLucky", showCar)
    else
        QBCore.Functions.Notify('Sa ei saa seda hetkel teha', 'error')
    end
end

RegisterNetEvent('luckywheel:do1Kroll', function()
    doRoll()
end)

RegisterNetEvent('casino:client:buyChips', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Osta Zetoone',
        submitText = 'Kinnita',
        inputs = {
            {
                text = 'Zetoonide Arv',
                name = 'chipsNum',
                type = 'number',
                isRequired = true
            }
        }
    })
    if dialog then
        if not dialog.chipsNum then
            return
        end
        TriggerServerEvent('casino:server:buyChips', tonumber(dialog.chipsNum))
    end
end)

-- Menu Controls
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1)
--         local coords = GetEntityCoords(PlayerPedId())
--         if(GetDistanceBetweenCoords(coords, _wheelPos.x, _wheelPos.y, _wheelPos.z, true) < 1.5) and not _isRolling then
-- 			DrawText3Ds(_wheelPos.x, _wheelPos.y, _wheelPos.z + 0.5, 'Press ~g~E~w~ to spin the wheel for $5000')
--             if IsControlJustReleased(0, Keys['E']) then
--                 doRoll()
--             end
--         end
--     end
-- end)

CreateThread(function()
    local pedModel = `u_f_m_casinocash_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector4(947.95, 45.12, 71.64, 178.7)

    wheelPed = CreatePed(5, pedModel, loc.x, loc.y, loc.z - 1, loc.w, false, true)
    TaskPlayAnim(wheelPed, 'missclothing', 'idle_storeclerk', 8.0, 8.0, -1, 1, 0, 0)
    FreezeEntityPosition(wheelPed, true)
    SetEntityInvincible(wheelPed, true)
    SetBlockingOfNonTemporaryEvents(wheelPed, true)

    exports['qb-target']:AddTargetEntity(wheelPed, {
        options = {
            {
                num = 1,
                type = 'client',
                event = 'luckywheel:do1Kroll',
                label = '$2,500 Keeruta Ratast',
                icon = 'fas fa-coins',
            }
        },
        distance = 1.7,
    })
end)

CreateThread(function()
    local pedModel = `u_f_m_casinocash_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector4(950.19, 33.21, 71.84, 58.13)

    chipsPed = CreatePed(5, pedModel, loc.x, loc.y, loc.z - 1, loc.w, false, true)
    TaskPlayAnim(chipsPed, 'missclothing', 'idle_storeclerk', 8.0, 8.0, -1, 1, 0, 0)
    FreezeEntityPosition(chipsPed, true)
    SetEntityInvincible(chipsPed, true)
    SetBlockingOfNonTemporaryEvents(chipsPed, true)
    
    exports['qb-target']:AddBoxZone('chipsExchange', vector3(949.25, 33.81, 71.84), 0.6, 2.0, {
        name = 'chipsExchange',
        heading = 57,
        debugPoly = false,
        minZ = 71.69,
        maxZ = 73.69
    }, {
        options = {
            {
                num = 1,
                type = 'client',
                event = 'casino:client:buyChips',
                label = 'Osta Zetoone',
                icon = 'fas fa-coins'
            },
            {
                num = 2,
                type = 'server',
                event = 'casino:server:cashOutCash',
                label = 'Cashout (Sularaha)',
                icon = 'fas fa-coins'
            },
            {
                num = 3,
                type = 'server',
                event = 'casino:server:cashOutBank',
                label = 'Cashout (Pank)',
                icon = 'fas fa-coins'
            }
        },
        distance = 2.0,
    })
end)

CreateThread(function()
    local pedModel = `u_f_m_casinocash_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector4(920.72, 46.35, 72.07, 283.57)

    cardsPed = CreatePed(5, pedModel, loc.x, loc.y, loc.z - 1, loc.w, false, true)
    TaskPlayAnim(cardsPed, 'missclothing', 'idle_storeclerk', 8.0, 8.0, -1, 1, 0, 0)
    FreezeEntityPosition(cardsPed, true)
    SetEntityInvincible(cardsPed, true)
    SetBlockingOfNonTemporaryEvents(cardsPed, true)
    
    exports['qb-target']:AddTargetEntity(cardsPed, {
        options = {
            {
                num = 1,
                type = 'server',
                event = 'casino:server:buyRegularCard',
                label = '$1,500 Osta Liikmekaart',
                icon = 'fas fa-dollar-sign'
            },
            {
                num = 2,
                type = 'server',
                event = 'casino:server:buyPremiumCard',
                label = '$15,000 Osta Premium Liikmekaart',
                icon = 'fas fa-dollar-sign'
            },
            {
                num = 3,
                type = 'server',
                event = 'casino:server:buyVipCard',
                label = 'Osta VIP Liikmekaart',
                icon = 'fas fa-dollar-sign',
                job = {['casino'] = 2}
            }
        },
        distance = 2.2,
    })
end)