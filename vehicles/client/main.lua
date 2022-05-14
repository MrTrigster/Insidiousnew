local QBCore = exports['qb-core']:GetCoreObject()
local wheelchair = nil

RegisterNetEvent('tnj-vehicles:wheelchair', function()
    if QBCore.Functions.HasItem('wheelchair') then
        if not DoesEntityExist(wheelchair) then
            local wheelchairModel = 'wheelchair'
            RequestModel(wheelchairModel)
            while not HasModelLoaded(wheelchairModel) do
                Wait(0)
            end
            wheelchair = CreateVehicle(wheelchairModel, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, false)
            SetVehicleOnGroundProperly(wheelchair)
            SetVehicleNumberPlateText(wheelchair, "WHEEL".. math.random(999))
            SetPedIntoVehicle(PlayerPedId(), wheelchair, -1)
            SetModelAsNoLongerNeeded(wheelchairModel)
            local wheelchairPlate = GetVehicleNumberPlateText(wheelchair)
            TriggerServerEvent("qb-vehiclekeys:server:AcquireVehicleKeys", wheelchairPlate)
            SetVehicleEngineOn(wheelchair, true, true)
        elseif DoesEntityExist(wheelchair) and #(GetEntityCoords(wheelchair) - GetEntityCoords(PlayerPedId())) < 3.0 and GetPedInVehicleSeat(wheelchair,-1) == 0 then
            DeleteVehicle(wheelchair)
            wheelchair = nil
        else
            QBCore.Functions.Notify("You already have a wheelchair out!")
        end
    end
end)
local hoverboard = nil

RegisterNetEvent('tnj-vehicles:hoverboard', function()
    if QBCore.Functions.HasItem('hoverboard') then
        if not DoesEntityExist(hoverboard) then
            local hoverboardModel = 'hoverboard'
            RequestModel(hoverboardModel)
            while not HasModelLoaded(hoverboardModel) do
                Wait(0)
            end
            hoverboard = CreateVehicle(hoverboardModel, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, false)
            SetVehicleOnGroundProperly(hoverboard)
            SetVehicleNumberPlateText(hoverboard, "BOARD".. math.random(999))
            SetPedIntoVehicle(PlayerPedId(), hoverboard, -1)
            SetModelAsNoLongerNeeded(hoverboardModel)
            local hoverboardPlate = GetVehicleNumberPlateText(hoverboard)
            TriggerServerEvent("qb-vehiclekeys:server:AcquireVehicleKeys", hoverboardPlate)
            SetVehicleEngineOn(hoverboard, true, true)
        elseif DoesEntityExist(hoverboard) and #(GetEntityCoords(hoverboard) - GetEntityCoords(PlayerPedId())) < 3.0 and GetPedInVehicleSeat(hoverboard,-1) == 0 then
            DeleteVehicle(hoverboard)
            hoverboard = nil
        else
            QBCore.Functions.Notify("You already have a hoverboard out!")
        end
    end
end)
