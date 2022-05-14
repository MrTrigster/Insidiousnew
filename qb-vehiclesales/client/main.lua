local QBCore = exports['qb-core']:GetCoreObject()

function DrawText3Ds(x, y, z, text)
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

local occasionVehicles = {}
local vehiclesSpawned = false
local isConfirming = false

CreateThread(function()
    local alreadyInRange = false
    local text = nil
    while true do
        local inRange = false
        local textInRange = false
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local price = nil
        if QBCore ~= nil then
            for _,slot in pairs(Config.OccasionSlots) do
                local dist = #(pos - slot.loc)

                if dist <= 40 then
                    inRange = true
                    if not vehiclesSpawned then
                        vehiclesSpawned = true

                        QBCore.Functions.TriggerCallback('qb-occasions:server:getVehicles', function(vehicles)
                            occasionVehicles = vehicles
                            despawnOccasionsVehicles()
                            spawnOccasionsVehicles(vehicles)
                        end)
                    end
                end
            end

            --[[local sellBackDist = #(pos - Config.SellVehicleBack)
            
            if sellBackDist <= 13.0 and IsPedInAnyVehicle(ped) then 
                DrawMarker(2, Config.SellVehicleBack.x, Config.SellVehicleBack.y, Config.SellVehicleBack.z + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.6, 255, 0, 0, 155, false, false, false, true, false, false, false)
                if sellBackDist <= 3.5 and IsPedInAnyVehicle(ped) then
                    local price 
                    local sellVehData = {}
                    sellVehData.plate = QBCore.Functions.GetPlate(GetVehiclePedIsIn(ped))
                    sellVehData.model = GetEntityModel(GetVehiclePedIsIn(ped))
                        for k, v in pairs(QBCore.Shared.Vehicles) do
                            if tonumber(v["hash"]) == sellVehData.model then
                                sellVehData.price = tonumber(v["price"])
                            end
                        end
                    DrawText3Ds(Config.SellVehicleBack.x, Config.SellVehicleBack.y, Config.SellVehicleBack.z, '[~g~E~w~] - Müü Sõiduk Otse Maha ~g~$'..math.floor(sellVehData.price / 2))
                    if IsControlJustPressed(0, 38) then
                        QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleOwner', function(owned, balance)
                            if balance < 1 then
                                if owned then
                                    SellToDealer(sellVehData, GetVehiclePedIsIn(ped))
                                else
                                    QBCore.Functions.Notify('See ei ole sinu sõiduk', 'error', 3500)
                                end                  
                            else
                                QBCore.Functions.Notify('Sul on veel maksmata makseid sellel sõidukil', 'error', 3500)
                            end
                        end, sellVehData.plate)
                    end
                end
            end]]
            
            if inRange then
                for i = 1, #Config.OccasionSlots, 1 do
                    local vehPos = GetEntityCoords(Config.OccasionSlots[i]["occasionid"])
                    local dstCheck = #(pos - vehPos)

                    if dstCheck <= 2 then
                        if not IsPedInAnyVehicle(ped) then
                            if not isConfirming then
                                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.45, '[~g~E~w~] - Vaata Lepingut')
                                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.25, QBCore.Shared.Vehicles[Config.OccasionSlots[i]["model"]]["name"]..', Hind: ~g~$'..Config.OccasionSlots[i]["price"])
                                if Config.OccasionSlots[i]["owner"] == QBCore.Functions.GetPlayerData().citizenid then
                                    DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.05, '[~r~G~w~] - Tühista Müük')
                                    if IsControlJustPressed(0, 47) then
                                        isConfirming = true
                                    end
                                end
                                if IsControlJustPressed(0, 38) then
                                    currentVehicle = i
                                    
                                    QBCore.Functions.TriggerCallback('qb-occasions:server:getSellerInformation', function(info)
                                        if info ~= nil then 
                                            info.charinfo = json.decode(info.charinfo)
                                        else
                                            info = {}
                                            info.charinfo = {
                                                firstname = "not",
                                                lastname = "known",
                                                account = "Account not known..",
                                                phone = "telephone number not known.."
                                            }
                                        end
                                        
                                        openBuyContract(info, Config.OccasionSlots[currentVehicle])
                                    end, Config.OccasionSlots[currentVehicle]["owner"])
                                end
                            else
                                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.45, 'Kindel et enam ei taha sõidukit müüa?')
                                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z + 1.25, '[~g~7~w~] - Jah | [~r~8~w~] - Ei')
                                if IsDisabledControlJustPressed(0, 161) then
                                    isConfirming = false
                                    currentVehicle = i
                                    TriggerServerEvent("qb-occasions:server:ReturnVehicle", Config.OccasionSlots[i])
                                end
                                if IsDisabledControlJustPressed(0, 162) then
                                    isConfirming = false
                                end
                            end
                        end
                    end
                end

                local sellDist = #(pos - Config.SellVehicle)

                if sellDist <= 13.0 and IsPedInAnyVehicle(ped) then 
                    -- DrawMarker(2, Config.SellVehicle.x, Config.SellVehicle.y, Config.SellVehicle.z + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.6, 255, 0, 0, 155, false, false, false, true, false, false, false)
                    if sellDist <= 3.5 and IsPedInAnyVehicle(ped) then
                        text = '[E] - Pane Sõiduk Müüki'
                        textInRange = true
                        -- DrawText3Ds(Config.SellVehicle.x, Config.SellVehicle.y, Config.SellVehicle.z, '[~g~E~w~] - Pane Sõiduk Müüki')
                        if IsControlJustPressed(0, 38) then
                            local VehiclePlate = QBCore.Functions.GetPlate(GetVehiclePedIsIn(ped))
                            QBCore.Functions.TriggerCallback('qb-garages:server:checkVehicleOwner', function(owned, balance)
                                if balance < 1 then
                                    if owned then
                                        openSellContract(true)
                                    else
                                        QBCore.Functions.Notify('See ei ole sinu sõiduk', 'error', 3500)
                                    end
                                else
                                    QBCore.Functions.Notify('Sul on veel maksmata makseid sellel sõidukil', 'error', 3500)
                                end
                            end, VehiclePlate)
                        end
                    end
                end
            end

            if textInRange and not alreadyInRange then
                exports['qb-drawtext']:DrawText(text, 'left')
                alreadyInRange = true
            end

            if not textInRange and alreadyInRange then
                exports['qb-drawtext']:HideText()
                alreadyInRange = false
            end

            if not inRange then
                if vehiclesSpawned then
                    vehiclesSpawned = false
                    despawnOccasionsVehicles()
                end
                Wait(1000)
            end
        end

        Wait(3)
    end
end)

--[[local function SellToDealer(sellVehData, vehicleHash)
    CreateThread(function()
        local keepGoing = true
        while keepGoing do
            local coords = GetEntityCoords(vehicleHash)
            DrawText3Ds(coords.x, coords.y, coords.z + 1.6, '~g~7~w~ - Confirm / ~r~8~w~ - Cancel ~g~')
            if IsDisabledControlJustPressed(0, 161) then
                TriggerServerEvent('qb-occasions:server:sellVehicleBack', sellVehData)
                local plate = QBCore.Functions.GetPlate(vehicleHash)
                TriggerServerEvent('qb-garages:server:removeOutsideVehicles', plate)
                QBCore.Functions.DeleteVehicle(vehicleHash)
                keepGoing = false
            end
            if IsDisabledControlJustPressed(0, 162) then
                keepGoing = false
            end
            if #(Config.SellVehicleBack - coords) > 3 then
                keepGoing = false
            end
            Wait(0)
        end
    end)
end]]

function spawnOccasionsVehicles(vehicles)
    local oSlot = Config.OccasionSlots

    if vehicles ~= nil then
        for i = 1, #vehicles, 1 do
            local model = GetHashKey(vehicles[i].model)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            
            oSlot[i]["occasionid"] = CreateVehicle(model, oSlot[i].loc.x, oSlot[i].loc.y, oSlot[i].loc.z, false, false)

            oSlot[i]["price"] = vehicles[i].price
            oSlot[i]["owner"] = vehicles[i].seller
            oSlot[i]["model"] = vehicles[i].model
            oSlot[i]["plate"] = vehicles[i].plate
            oSlot[i]["oid"]   = vehicles[i].occasionid
            oSlot[i]["desc"]  = vehicles[i].description
            oSlot[i]["mods"]  = vehicles[i].mods

            QBCore.Functions.SetVehicleProperties(oSlot[i]["occasionid"], json.decode(oSlot[i]["mods"]))

            SetModelAsNoLongerNeeded(model)
            SetVehicleOnGroundProperly(oSlot[i]["occasionid"])
            SetEntityInvincible(oSlot[i]["occasionid"],true)
            SetEntityHeading(oSlot[i]["occasionid"], oSlot[i].h)
            SetVehicleDoorsLocked(oSlot[i]["occasionid"], 3)

            SetVehicleNumberPlateText(oSlot[i]["occasionid"], vehicles[i].occasionid)
            FreezeEntityPosition(oSlot[i]["occasionid"],true)
        end
    end
end

function despawnOccasionsVehicles()
    local oSlot = Config.OccasionSlots
    for i = 1, #Config.OccasionSlots, 1 do
        local loc = Config.OccasionSlots[i].loc
        local oldVehicle = GetClosestVehicle(loc.x, loc.y, loc.z, 1.3, 0, 70)
        if oldVehicle ~= 0 then
            QBCore.Functions.DeleteVehicle(oldVehicle)
        end
    end
end

function openSellContract(bool)
    local pData = QBCore.Functions.GetPlayerData()

    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "sellVehicle",
        bizName = Config.BusinessName,
        sellerData = {
            firstname = pData.charinfo.firstname,
            lastname = pData.charinfo.lastname,
            account = pData.charinfo.account,
            phone = pData.charinfo.phone
        },
        plate = QBCore.Functions.GetPlate(GetVehiclePedIsUsing(PlayerPedId()))
    })
end

function openBuyContract(sellerData, vehicleData)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "buyVehicle",
        bizName = Config.BusinessName,
        sellerData = {
            firstname = sellerData.charinfo.firstname,
            lastname = sellerData.charinfo.lastname,
            account = sellerData.charinfo.account,
            phone = sellerData.charinfo.phone
        },
        vehicleData = {
            desc = vehicleData.desc,
            price = vehicleData.price
        },
        plate = vehicleData.plate
    })
end

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('buyVehicle', function(data, cb)
    local vehData = Config.OccasionSlots[currentVehicle]
    TriggerServerEvent('qb-occasions:server:buyVehicle', vehData)
    cb('ok')
end)

DoScreenFadeIn(250)

RegisterNetEvent('qb-occasions:client:BuyFinished')
AddEventHandler('qb-occasions:client:BuyFinished', function(vehdata)
    local vehmods = json.decode(vehdata.mods)

    DoScreenFadeOut(250)
    Wait(500)
    QBCore.Functions.SpawnVehicle(vehdata.model, function(veh)
        SetVehicleNumberPlateText(veh, vehdata.plate)
        SetEntityHeading(veh, Config.BuyVehicle.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetVehicleFuelLevel(veh, 100)
        QBCore.Functions.Notify("Sõiduk Ostetud", "success", 2500)
        TriggerEvent("vehiclekeys:client:SetOwner", vehdata.plate)
        SetVehicleEngineOn(veh, true, true)
        Wait(500)
        QBCore.Functions.SetVehicleProperties(veh, vehmods)
    end, Config.BuyVehicle, true)
    Wait(500)
    DoScreenFadeIn(250)
    currentVehicle = nil
end)

RegisterNetEvent('qb-occasions:client:ReturnOwnedVehicle')
AddEventHandler('qb-occasions:client:ReturnOwnedVehicle', function(vehdata)
    local vehmods = json.decode(vehdata.mods)
    DoScreenFadeOut(250)
    Wait(500)
    QBCore.Functions.SpawnVehicle(vehdata.model, function(veh)
        SetVehicleNumberPlateText(veh, vehdata.plate)
        SetEntityHeading(veh, Config.BuyVehicle.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetVehicleFuelLevel(veh, 100)
        QBCore.Functions.Notify("Said sõiduki tagasi")
        TriggerEvent("vehiclekeys:client:SetOwner", vehdata.plate)
        SetVehicleEngineOn(veh, true, true)
        Wait(500)
        QBCore.Functions.SetVehicleProperties(veh, vehmods)
    end, Config.BuyVehicle, true)
    Wait(500)
    DoScreenFadeIn(250)
    currentVehicle = nil
end)

RegisterNUICallback('sellVehicle', function(data, cb)
    local plate = QBCore.Functions.GetPlate(GetVehiclePedIsUsing(PlayerPedId())) --Getting the plate and sending to the function
    SellData(data,plate)
    cb('ok')
end)

local function sellVehicleWait(price)
    DoScreenFadeOut(250)
    Wait(250)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    local plate = QBCore.Functions.GetPlate(vehicle)
    TriggerServerEvent('qb-garages:server:removeOutsideVehicles', plate)
    QBCore.Functions.DeleteVehicle(vehicle)
    Wait(1500)
    DoScreenFadeIn(250)
    QBCore.Functions.Notify('Sinu sõiduk on müüki pandud! Hind - $'..price, 'success')
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end

function SellData(data,model)
    QBCore.Functions.TriggerCallback("qb-vehiclesales:server:CheckModelName",function(DataReturning) 
        local vehicleData = {}
        local PlayerData = QBCore.Functions.GetPlayerData()
        vehicleData.ent = GetVehiclePedIsUsing(PlayerPedId())
        vehicleData.model = DataReturning 
        vehicleData.plate = model
        vehicleData.mods = QBCore.Functions.GetVehicleProperties(vehicleData.ent)
        vehicleData.desc = data.desc
        TriggerServerEvent('qb-occasions:server:sellVehicle', data.price, vehicleData)
        sellVehicleWait(data.price)
    end,model) --the older function GetDisplayNameFromVehicleModel doest like long names like Washington or Buccanner2
end

RegisterNetEvent('qb-occasion:client:refreshVehicles')
AddEventHandler('qb-occasion:client:refreshVehicles', function()
    if inRange then
        QBCore.Functions.TriggerCallback('qb-occasions:server:getVehicles', function(vehicles)
            occasionVehicles = vehicles
            despawnOccasionsVehicles()
            spawnOccasionsVehicles(vehicles)
        end)
    end
end)

CreateThread(function()
    OccasionBlip = AddBlipForCoord(Config.SellVehicle.x, Config.SellVehicle.y, Config.SellVehicle.z)

    SetBlipSprite (OccasionBlip, 326)
    SetBlipDisplay(OccasionBlip, 4)
    SetBlipScale  (OccasionBlip, 0.75)
    SetBlipAsShortRange(OccasionBlip, true)
    SetBlipColour(OccasionBlip, 2)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Kasutatud Autod")
    EndTextCommandSetBlipName(OccasionBlip)
end)
