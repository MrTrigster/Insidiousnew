local QBCore = exports['qb-core']:GetCoreObject()
local vehicleClassWhitelist = {0, 1, 2, 3, 4, 5, 6, 7, 9}
local driftMode = false

local handleMods = {
	{"fInitialDragCoeff", 90.22},
	{"fDriveInertia", .31},
	{"fSteeringLock", 22},
	{"fTractionCurveMax", -1.1},
	{"fTractionCurveMin", -.4},
	{"fTractionCurveLateral", 2.5},
	{"fLowSpeedTractionLossMult", -.57}
}

RegisterNetEvent('qbdriftmode:DriftMode', function()
	ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") < 90 then
		SetVehicleEnginePowerMultiplier(vehicle, 0.0)
	else
		if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront") == 0.0 then
			SetVehicleEnginePowerMultiplier(vehicle, 190.0)
		else
			SetVehicleEnginePowerMultiplier(vehicle, 100.0)
		end
	end
	if (GetPedInVehicleSeat(vehicle, -1) == ped) then
		if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront") ~= 1 and IsVehicleOnAllWheels(vehicle) and IsVehicleClassWhitelisted(GetVehicleClass(vehicle)) then
			local modifier = 1
			if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") > 90 then
				driftMode = true
			else
				driftMode = false
			end
			if driftMode then
				modifier = -1
			end
			for index, value in ipairs(handleMods) do
				SetVehicleHandlingFloat(vehicle, "CHandlingData", value[1], GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1]) + value[2] * modifier)
			end
			if driftMode then
				QBCore.Functions.Notify("Drift mode | Off")
			else
				QBCore.Functions.Notify("Drift mode | ON!")
			end
		end
		if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") < 90 then
			SetVehicleEnginePowerMultiplier(vehicle, 0.0)
		else
			if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront") == 0.0 then
				SetVehicleEnginePowerMultiplier(vehicle, 190.0)
			else
				SetVehicleEnginePowerMultiplier(vehicle, 100.0)
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(1000)
		if IsPedInAnyVehicle((PlayerPedId())) then
		else
			if driftMode == true then
			else
				LastVehicle = QBCore.Functions.GetClosestVehicle()
				modifier = -1
				for index, value in ipairs(handleMods) do
					SetVehicleHandlingFloat(LastVehicle, "CHandlingData", value[1], GetVehicleHandlingFloat(LastVehicle, "CHandlingData", value[1]) + value[2] * modifier)
				end
				if GetVehicleHandlingFloat(LastVehicle, "CHandlingData", "fInitialDragCoeff") < 90 then
					SetVehicleEnginePowerMultiplier(LastVehicle, 0.0)
				else
					if GetVehicleHandlingFloat(LastVehicle, "CHandlingData", "fDriveBiasFront") == 0.0 then
						SetVehicleEnginePowerMultiplier(LastVehicle, 190.0)
					else
						SetVehicleEnginePowerMultiplier(LastVehicle, 100.0)
					end
				end
				driftMode = true
			end
		end
	end
end)

function IsVehicleClassWhitelisted(vehicleClass)
	for index, value in ipairs(vehicleClassWhitelist) do
		if value == vehicleClass then
			return true
		end
	end
	return false
end