local QBCore = exports['qb-core']:GetCoreObject()

local meterIsOpen = false
local meterActive = false
local currentTaxi = nil
local lastLocation = nil

local meterData = {
    fareAmount = 6,
    currentFare = 0,
    distanceTraveled = 0,
}

local NpcData = {
    Active = false,
    CurrentNpc = nil,
    LastNpc = nil,
    CurrentDeliver = nil,
    LastDeliver = nil,
    Npc = nil,
    NpcBlip = nil,
    DeliveryBlip = nil,
    NpcTaken = false,
    NpcDelivered = false,
    CountDown = 180
}

function TimeoutNpc()
    Citizen.CreateThread(function()
        while NpcData.CountDown ~= 0 do
            NpcData.CountDown = NpcData.CountDown - 1
            Citizen.Wait(1000)
        end
        NpcData.CountDown = 180
    end)
end

RegisterNetEvent('i13-taxi:client:DoTaxiNpc')
AddEventHandler('i13-taxi:client:DoTaxiNpc', function()
    if whitelistedVehicle() then
       -- if NpcData.CountDown == 180 then
            if not NpcData.Active then
                NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
                if NpcData.LastNpc ~= nil then
                    while NpcData.LastNpc ~= NpcData.CurrentNpc do
                        NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
                    end
                end

                local Gender = math.random(1, #Config.NpcSkins)
                local PedSkin = math.random(1, #Config.NpcSkins[Gender])
                local model = GetHashKey(Config.NpcSkins[Gender][PedSkin])
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(0)
                end
                NpcData.Npc = CreatePed(3, model, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z - 0.98, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].w, false, true)
                PlaceObjectOnGroundProperly(NpcData.Npc)
                FreezeEntityPosition(NpcData.Npc, true)
                if NpcData.NpcBlip ~= nil then
                    RemoveBlip(NpcData.NpcBlip)
                end
                QBCore.Functions.Notify('NPC asukoht märgitud GPS\'il', 'success')
                NpcData.NpcBlip = AddBlipForCoord(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z)
                SetBlipColour(NpcData.NpcBlip, 3)
                SetBlipRoute(NpcData.NpcBlip, true)
                SetBlipRouteColour(NpcData.NpcBlip, 3)
                NpcData.LastNpc = NpcData.CurrentNpc
                NpcData.Active = true

                Citizen.CreateThread(function()
                    while not NpcData.NpcTaken do

                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local dist = #(pos - vector3(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z))

                        if dist < 20 then
                            DrawMarker(2, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                        
                            if dist < 5 then
                                local npccoords = GetEntityCoords(NpcData.Npc)
                                DrawText3D(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z, '[E] Kutsu NPC')
                                if IsControlJustPressed(0, 38) then
                                    local veh = GetVehiclePedIsIn(ped, 0)
                                    local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(veh)

                                    for i=maxSeats - 1, 0, -1 do
                                        if IsVehicleSeatFree(veh, i) then
                                            freeSeat = i
                                            break
                                        end
                                    end

                                    meterIsOpen = true
                                    meterActive = true
                                    lastLocation = GetEntityCoords(PlayerPedId())
                                    SendNUIMessage({
                                        action = "openMeter",
                                        toggle = true,
                                        meterData = Config.Meter
                                    })
                                    SendNUIMessage({
                                        action = "toggleMeter"
                                    })
                                    ClearPedTasksImmediately(NpcData.Npc)
                                    FreezeEntityPosition(NpcData.Npc, false)
                                    TaskEnterVehicle(NpcData.Npc, veh, -1, freeSeat, 1.0, 0)
                                    QBCore.Functions.Notify('Vii NPC määratud asukohta')
                                    if NpcData.NpcBlip ~= nil then
                                        RemoveBlip(NpcData.NpcBlip)
                                    end
                                    GetDeliveryLocation()
                                    NpcData.NpcTaken = true
                                end
                            end
                        end

                        Citizen.Wait(1)
                    end
                end)
            else
                QBCore.Functions.Notify('Sa juba teed NPC sõitu')
            end
      --  else
         --   QBCore.Functions.Notify('No NPCs Are Available')
       -- end
    else
        QBCore.Functions.Notify('Sa ei ole taksos')
    end
end)

function GetDeliveryLocation()
    NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
    if NpcData.LastDeliver ~= nil then
        while NpcData.LastDeliver ~= NpcData.CurrentDeliver do
            NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
        end
    end

    if NpcData.DeliveryBlip ~= nil then
        RemoveBlip(NpcData.DeliveryBlip)
    end
    NpcData.DeliveryBlip = AddBlipForCoord(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z)
    SetBlipColour(NpcData.DeliveryBlip, 3)
    SetBlipRoute(NpcData.DeliveryBlip, true)
    SetBlipRouteColour(NpcData.DeliveryBlip, 3)
    NpcData.LastDeliver = NpcData.CurrentDeliver

    Citizen.CreateThread(function()
        while true do

            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dist = #(pos - vector3(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z))

            if dist < 20 then
                DrawMarker(2, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            
                if dist < 5 then
                    local npccoords = GetEntityCoords(NpcData.Npc)
                    DrawText3D(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z, '[E] Lõpeta NPC Sõit')
                    if IsControlJustPressed(0, 38) then
                        local veh = GetVehiclePedIsIn(ped, 0)
                        TaskLeaveVehicle(NpcData.Npc, veh, 0)
                        SetEntityAsMissionEntity(NpcData.Npc, false, true)
                        SetEntityAsNoLongerNeeded(NpcData.Npc)
                        local targetCoords = Config.NPCLocations.TakeLocations[NpcData.LastNpc]
                        TaskGoStraightToCoord(NpcData.Npc, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, -1, 0.0, 0.0)
                        SendNUIMessage({
                            action = "toggleMeter"
                        })
                        TriggerServerEvent('i13-taxi:server:NpcPay', meterData.currentFare)
                        meterActive = false
                        SendNUIMessage({
                            action = "resetMeter"
                        })
                        QBCore.Functions.Notify('Isik jõudis kohale', 'success')
                        if NpcData.DeliveryBlip ~= nil then
                            RemoveBlip(NpcData.DeliveryBlip)
                        end
                        local RemovePed = function(ped)
                            SetTimeout(60000, function()
                                DeletePed(ped)
                            end)
                        end
                       -- TimeoutNpc()
                        RemovePed(NpcData.Npc)
                        ResetNpcTask()
                        break
                    end
                end
            end

            Citizen.Wait(1)
        end
    end)
end

function ResetNpcTask()
    NpcData = {
        Active = false,
        CurrentNpc = nil,
        LastNpc = nil,
        CurrentDeliver = nil,
        LastDeliver = nil,
        Npc = nil,
        NpcBlip = nil,
        DeliveryBlip = nil,
        NpcTaken = false,
        NpcDelivered = false,
    }
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        calculateFareAmount()
    end
end)

function calculateFareAmount()
    if meterIsOpen and meterActive then
        start = lastLocation
  
        if start then
            current = GetEntityCoords(PlayerPedId())
            distance = #(start - current) --Not the best result but work
            meterData['distanceTraveled'] = distance
    
            fareAmount = (meterData['distanceTraveled'] / 200.00) * meterData['fareAmount']
    
            meterData['currentFare'] = math.ceil(fareAmount)

            SendNUIMessage({
                action = "updateMeter",
                meterData = meterData
            })
        end
    end
end

-- Citizen.CreateThread(function()
--     while true do
--         inRange = false
--         if LocalPlayer.state.isLoggedIn then
--             local Player = QBCore.Functions.GetPlayerData()
--             if Player.job.name == "taxi" then
--                 local ped = PlayerPedId()
--                 local pos = GetEntityCoords(ped)

--                 local vehDist = #(pos - vector3(Config.Location.x, Config.Location.y, Config.Location.z))

--                 if vehDist < 30 then
--                     inRange = true

--                     DrawMarker(2, Config.Location.x, Config.Location.y, Config.Location.z, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.3, 0.5, 0.2, 200, 0, 0, 222, false, false, false, true, false, false, false)

--                     if vehDist < 1.5 then
--                         if whitelistedVehicle() then
--                             DrawText3D(Config.Location.x, Config.Location.y, Config.Location.z + 0.3, '[E] Pane Garaazi')
--                             if IsControlJustReleased(0, 38) then
--                                 if IsPedInAnyVehicle(PlayerPedId(), false) then
--                                     DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
--                                 end
--                             end
--                         else
--                             DrawText3D(Config.Location.x, Config.Location.y, Config.Location.z + 0.3, '[E] Sõidukid')
--                             if IsControlJustReleased(0, 38) then
--                                 TaxiGarage()
--                             end
--                         end
--                     end
--                 end
--             end
--         end

--         if not inRange then
--             Citizen.Wait(3000)
--         end

--         Citizen.Wait(3)
--     end
-- end)

RegisterNetEvent('i13-taxi:client:toggleMeter')
AddEventHandler('i13-taxi:client:toggleMeter', function()
    local ped = PlayerPedId()
    
    if IsPedInAnyVehicle(ped, false) then
        if whitelistedVehicle() then 
            if not meterIsOpen and IsDriver() then
                SendNUIMessage({
                    action = "openMeter",
                    toggle = true,
                    meterData = Config.Meter
                })
                meterIsOpen = true
            else
                SendNUIMessage({
                    action = "openMeter",
                    toggle = false
                })
                meterIsOpen = false
            end
        else
            QBCore.Functions.Notify('Sellel sõidukil ei ole seda aparaati', 'error')
        end
    else
        QBCore.Functions.Notify('Sa ei ole sõidukis', 'error')
    end
end)

RegisterNetEvent('i13-taxi:client:enableMeter')
AddEventHandler('i13-taxi:client:enableMeter', function()
    if meterIsOpen then
        SendNUIMessage({
            action = "toggleMeter"
        })
    else
        QBCore.Functions.Notify('Mõõtja ei ole aktiivne', 'error')
    end
end)

RegisterNUICallback('enableMeter', function(data)
    meterActive = data.enabled

    if not data.enabled then
        SendNUIMessage({
            action = "resetMeter"
        })
    end
    lastLocation = GetEntityCoords(PlayerPedId())
end)

RegisterNetEvent('i13-taxi:client:toggleMuis')
AddEventHandler('i13-taxi:client:toggleMuis', function()
    Citizen.Wait(400)
    if meterIsOpen then
        if not mouseActive then
            SetNuiFocus(true, true)
            mouseActive = true
        end
    else
        QBCore.Functions.Notify('Mõõtjat ei ole', 'error')
    end
end)

RegisterNUICallback('hideMouse', function()
    SetNuiFocus(false, false)
    mouseActive = false
end)

function whitelistedVehicle()
    local ped = PlayerPedId()
    local veh = GetEntityModel(GetVehiclePedIsIn(ped))
    local retval = false

    for i = 1, #Config.AllowedVehicles, 1 do
        if veh == GetHashKey(Config.AllowedVehicles[i].model) then
            retval = true
        end
    end

    if veh == GetHashKey("dynasty") then
        retval = true
    end
    
    return retval
end

function IsDriver()
    return GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
end

function TaxiGarage()
    local vehicleMenu = {
        {
            header = "Takso Sõidukid",
            isMenuHeader = true
        }
    }
    for veh, v in pairs(Config.AllowedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.label,
            params = {
                event = "i13-taxi:client:TakeVehicle",
                args = {
                    model = v.model
                }
            }
        }
    end     
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Sulge Menu",
        txt = "",
        params = {
            event = "i13-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

RegisterNetEvent("i13-taxi:client:TakeVehicle", function(data)
    local coords = Config.Location
    QBCore.Functions.SpawnVehicle(data.model, function(veh)
        SetVehicleNumberPlateText(veh, "TAXI"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

function DrawText3D(x, y, z, text)
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

RegisterNetEvent('i13-taxijob:client:ToggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent('QBCore:ToggleDuty')
end)

RegisterNetEvent('i13-taxijob:client:OpenStash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "taxistash", {
        maxweight = 4000000,
        slots = 500,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "taxistash")
end)

CreateThread(function()
    TaxiBlip = AddBlipForCoord(Config.Location)

    SetBlipSprite (TaxiBlip, 198)
    SetBlipDisplay(TaxiBlip, 4)
    SetBlipScale  (TaxiBlip, 0.6)
    SetBlipAsShortRange(TaxiBlip, true)
    SetBlipColour(TaxiBlip, 5)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Taksopark")
    EndTextCommandSetBlipName(TaxiBlip)
end)

CreateThread(function()
    local pedModel = `s_m_y_grip_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector4(904.97, -149.65, 74.17, 165.88)

    taxiPed = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, loc.w, false, true)
    FreezeEntityPosition(taxiPed, true)
    SetEntityInvincible(taxiPed, true)
    SetBlockingOfNonTemporaryEvents(taxiPed, true)

    exports['qb-target']:AddTargetEntity(taxiPed, {
        options = {
            {
                type = 'server',
                event = 'i13-taxijob:server:getTaxiJob',
                label = 'Asu Taksojuhina Tööle',
                icon = 'fas fa-briefcase',
            },
            {
                type = 'client',
                event = 'i13-taxijob:client:ToggleDuty',
                label = 'On Duty / Off Duty',
                icon = 'fas fa-clipboard-list',
                job = 'taxi'
            }
        },
        distance = 1.7,
    })
end)

-- CreateThread(function()
--     exports['qb-target']:AddBoxZone('taxiduty', vector3(907.23, -150.19, 74.17), 1.2, 3.4, {
--         name = 'taxiduty',
--         heading = 58,
--         debugPoly = false,
--         minZ = 75.9,
--         maxZ = 77.95
--     }, {
--         options = {
--             {
--                 type = 'client',
--                 event = 'i13-taxijob:client:ToggleDuty',
--                 label = 'On Duty / Off Duty',
--                 icon = 'fas fa-clipboard-list',
--                 job = 'taxi'
--             }
--         },
--         distance = 1.5,
--     })

--     exports['qb-target']:AddBoxZone('taxistash', vector3(894.04, -163.19, 76.9), 0.75, 2.4, {
--         name = 'taxistash',
--         heading = 58,
--         debugPoly = false,
--         minZ = 75.9,
--         maxZ = 77.95
--     }, {
--         options = {
--             {
--                 type = 'client',
--                 event = 'i13-taxijob:client:OpenStash',
--                 label = 'Ava Kapp',
--                 icon = 'fas fa-box',
--                 job = 'taxi'
--             }
--         },
--         distance = 1.5,
--     })
-- end)