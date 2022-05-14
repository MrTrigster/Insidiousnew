local QBCore = exports['qb-core']:GetCoreObject()

local sitting = false
local lastPos = nil
local currentSitObj = nil
local currentScenario = nil

function wakeup()
	ClearPedTasks(playerPed)
	sitting = false
	SetEntityCoords(playerPed, lastPos)
	FreezeEntityPosition(playerPed, false)
	FreezeEntityPosition(currentSitObj, false)
	currentSitObj = nil
	currentScenario = nil
end

function sit(object, modelName, data)
	local pos = GetEntityCoords(object)
	local id = pos.x .. pos.y .. pos.z
	local playerPed = GetPlayerPed(-1)
	lastPos = GetEntityCoords(playerPed)
	currentSitObj = id

    FreezeEntityPosition(object, true)

	currentScenario = data.scenario

	if GetEntityHeading(object) <= 181 then 
		if string.match(modelName, "chair") or string.match(modelName, "Chair") then
			TaskStartScenarioAtPosition(playerPed, currentScenario, pos.x, pos.y, pos.z - data.verticalOffset, GetEntityHeading(object)+180.0, 0, true, true)
		else
			TaskStartScenarioAtPosition(playerPed, currentScenario, lastPos.x, pos.y, pos.z - data.verticalOffset, GetEntityHeading(object)+180.0, 0, true, true)
		end
		
	elseif GetEntityHeading(object) >= 181 then 
		if string.match(modelName, "chair") or string.match(modelName, "Chair") then 
			TaskStartScenarioAtPosition(playerPed, currentScenario, pos.x, pos.y, pos.z - data.verticalOffset, GetEntityHeading(object)+180.0, 0, true, true)
		else
		 	TaskStartScenarioAtPosition(playerPed, currentScenario, pos.x, lastPos.y, pos.z - data.verticalOffset, GetEntityHeading(object)+180.0, 0, true, true)
		end	
	end
end

CreateThread(function()
    while true do
        local playerPed = GetPlayerPed(-1)

        if sitting and not IsPedUsingScenario(playerPed, currentScenario) then
            wakeup()
        end

        Wait(0)
    end
end)

CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.Interactables, {
        options = {
            {
                type = "client",
                event = "chair:event",
                icon = "fas fa-chair",
                label = "Istu",
                action = function(entity)
                    if sitting then
                        wakeup()
                    else
                        local hash = GetEntityModel(entity)
                        local data = nil
                        local modelName = nil
                        local found = false
                        
                        for k,v in pairs(Config.Sitable) do
                            if GetHashKey(k) == hash then
                                data = v
                                modelName = k
                                found = true
                                break
                            end
                        end

                        if found == true then
                            sit(entity, modelName, data)
                        end
                    end
                end,
            }
        },
        distance = 1.5,
    })
end)

--[[CreateThread(function()
	while true do
		Wait(0)
		local playerPed = GetPlayerPed(-1)

		if sitting and not IsPedUsingScenario(playerPed, currentScenario) then
			wakeup()
		end

		if (GetLastInputMethod(2) and IsControlJustPressed(0, 23)) and not IsPedInAnyVehicle(playerPed, true) then
			if sitting then
				wakeup()
			else
				local object, distance = QBCore.Functions.GetClosestObject(Config.Interactables)

				if distance < 1.5 then
					local hash = GetEntityModel(object)
					local data = nil
					local modelName = nil
					local found = false
					
					for k,v in pairs(Config.Sitable) do
						if GetHashKey(k) == hash then
							data = v
							modelName = k
							found = true
							break
						end
					end

					if found == true then
						sit(object, modelName, data)
					end
				end
			end
		end
	end
end)]]