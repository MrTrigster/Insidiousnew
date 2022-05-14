QBCore = exports['qb-core']:GetCoreObject()
local inRadialMenu = false
local PlayerData = QBCore.Functions.GetPlayerData()

RegisterCommand('radialmenu', function()
    if not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() and not inRadialMenu then --not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and 
        openRadial(true)
        SetCursorLocation(0.5, 0.5)
    end
end)

RegisterKeyMapping('radialmenu', 'Open Radial Menu', 'keyboard', 'F1')

-- Sets the metadata when the player spawns
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
	TriggerEvent('qb-garages:client:updateRadialmenu')
end)

-- Sets the playerdata to an empty table when the player has quit or did /logout
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
	TriggerEvent('qb-garages:client:updateRadialmenu')
end)

-- This will update all the PlayerData that doesn't get updated with a specific event other than this like the metadata
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
	TriggerEvent('qb-garages:client:updateRadialmenu')
end)

local function CheckHasID(id1, id2)
	local has = false
	for k, v in pairs(Config.MenuItems[id1].items) do
		if v.id == id2 then
			has = true
		end
	end
	return has
end

local function CheckHasID1(id1, id2)
	local has = false
	for k, v in pairs(Config.JobInteractions[id1]) do
		if v.id == id2 then
			has = true
		end
	end
	return has
end

local function setupGarageItems()
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local ped = PlayerPedId()
		local veh = QBCore.Functions.GetClosestVehicle(pos)
		if IsPedInAnyVehicle(ped) then
			veh = GetVehiclePedIsIn(ped)
		end
		local plate = QBCore.Functions.GetPlate(veh)
		local isingarage, canStoreVehicle = exports['qb-garages']:IsInGarage()
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and isingarage and not IsPedInAnyVehicle(ped, false) then 
			if not CheckHasID(3, 'opengarage') then
				Config.MenuItems[3].items[#Config.MenuItems[3].items + 1] = {
					id = 'opengarage',
					title = 'Sõidukite List',
					icon = 'warehouse',
					type = 'client',
					event = 'qb-garages:client:openGarage',
					shouldClose = true
				}
			end
			
		else
			for k, v in pairs(Config.MenuItems[3].items) do
				if v.id == 'opengarage' then
					Config.MenuItems[3].items[k] = nil
				end
			end
		end
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and isingarage and canStoreVehicle and exports["qb-vehiclekeys"]:HasKeys(plate) then 
			if not CheckHasID(3, 'storeVehicle') then
				Config.MenuItems[3].items[#Config.MenuItems[3].items + 1] = {
					id = 'storeVehicle',
					title = 'Pargi Sõiduk',
					icon = 'parking',
					type = 'client',
					event = 'qb-garages:client:storeVehicle',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.MenuItems[3].items) do
				if v.id == 'storeVehicle' then
					Config.MenuItems[3].items[k] = nil
				end
			end
		end

        --Mechanic
		local isInJobGarageMechanic, lastJobVehicleMechanic = exports['qb-garages']:isInJobStation('mechanic')
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'mechanic' and PlayerData.job.onduty and isInJobGarageMechanic and lastJobVehicleMechanic == nil and not IsPedInAnyVehicle(ped) then  
			if not CheckHasID1('mechanic', 'openmechanicjobveh') then
				Config.JobInteractions['mechanic'][#Config.JobInteractions['mechanic'] +1 ] = {
					id = 'openmechanicjobveh',
					title = 'Mehaanikute Garaaz',
					icon = 'warehouse',
					type = 'client',
					event = 'qb-garages:client:openJobVehList',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['mechanic']) do
				if v.id == 'openmechanicjobveh' then
					Config.JobInteractions['mechanic'][k] = nil
				end
			end
		end
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'mechanic' and PlayerData.job.onduty and isInJobGarageMechanic and lastJobVehicleMechanic ~= nil and exports["qb-vehiclekeys"]:HasKeys(plate) and veh == lastJobVehicleMechanic then  
			if not CheckHasID1('mechanic', 'storemechanicjobveh') then
				Config.JobInteractions['mechanic'][#Config.JobInteractions['mechanic'] +1 ] = {
					id = 'storemechanicjobveh',
					title = 'Pane Mehaanikute Garaazi',
					icon = 'parking',
					type = 'client',
					event = 'qb-garages:client:HideJobVeh',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['mechanic']) do
				if v.id == 'storemechanicjobveh' then
					Config.JobInteractions['mechanic'][k] = nil
				end
			end
		end

        --Reporter
		local isInJobGarageReporter, lastJobVehicleReporter = exports['qb-garages']:isInJobStation('news')
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'news' and PlayerData.job.onduty and isInJobGarageReporter and lastJobVehicleReporter == nil and not IsPedInAnyVehicle(ped) then  
			if not CheckHasID1('news', 'openreporterjobveh') then
				Config.JobInteractions['news'][#Config.JobInteractions['news'] +1 ] = {
					id = 'openreporterjobveh',
					title = 'Weazel News Garaaz',
					icon = 'warehouse',
					type = 'client',
					event = 'qb-garages:client:openJobVehList',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['news']) do
				if v.id == 'openreporterjobveh' then
					Config.JobInteractions['news'][k] = nil
				end
			end
		end
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'news' and PlayerData.job.onduty and isInJobGarageReporter and lastJobVehicleReporter ~= nil and exports["qb-vehiclekeys"]:HasKeys(plate) and veh == lastJobVehicleReporter then  
			if not CheckHasID1('news', 'storereporterjobveh') then
				Config.JobInteractions['news'][#Config.JobInteractions['news'] +1 ] = {
					id = 'storereporterjobveh',
					title = 'Pane Weazel News Garaazi',
					icon = 'parking',
					type = 'client',
					event = 'qb-garages:client:HideJobVeh',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['news']) do
				if v.id == 'storereporterjobveh' then
					Config.JobInteractions['news'][k] = nil
				end
			end
		end

        --Taxi
		local isInJobGarageTaxi, lastJobVehicleTaxi = exports['qb-garages']:isInJobStation('taxi')
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'taxi' and PlayerData.job.onduty and isInJobGarageTaxi and lastJobVehicleTaxi == nil and not IsPedInAnyVehicle(ped) then
			if not CheckHasID1('taxi', 'opentaxijobveh') then
				Config.JobInteractions['taxi'][#Config.JobInteractions['taxi'] +1 ] = {
					id = 'opentaxijobveh',
					title = 'Takso Garaaz',
					icon = 'warehouse',
					type = 'client',
					event = 'qb-garages:client:openJobVehList',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['taxi']) do
				if v.id == 'opentaxijobveh' then
					Config.JobInteractions['taxi'][k] = nil
				end
			end
		end
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'taxi' and PlayerData.job.onduty and isInJobGarageTaxi and lastJobVehicleTaxi ~= nil and exports["qb-vehiclekeys"]:HasKeys(plate) and veh == lastJobVehicleTaxi then  
			if not CheckHasID1('taxi', 'storetaxijobveh') then
				Config.JobInteractions['taxi'][#Config.JobInteractions['taxi'] +1 ] = {
					id = 'storetaxijobveh',
					title = 'Pane Takso Garaazi',
					icon = 'parking',
					type = 'client',
					event = 'qb-garages:client:HideJobVeh',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['taxi']) do
				if v.id == 'storetaxijobveh' then
					Config.JobInteractions['taxi'][k] = nil
				end
			end
		end
        
        --Police
		local isInJobGaragePolice, lastJobVehiclePolice = exports['qb-garages']:isInJobStation('police')
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'police' and PlayerData.job.onduty and isInJobGaragePolice and lastJobVehiclePolice == nil and not IsPedInAnyVehicle(ped) then  
			if not CheckHasID1('police', 'openpolicejobveh') then
				Config.JobInteractions['police'][#Config.JobInteractions['police'] +1 ] = {
					id = 'openpolicejobveh',
					title = 'Politsei Garaaz',
					icon = 'warehouse',
					type = 'client',
					event = 'qb-garages:client:openJobVehList',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['police']) do
				if v.id == 'openpolicejobveh' then
					Config.JobInteractions['police'][k] = nil
				end
			end
		end
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'police' and PlayerData.job.onduty and isInJobGaragePolice and lastJobVehiclePolice ~= nil and exports["qb-vehiclekeys"]:HasKeys(plate) and veh == lastJobVehiclePolice then  
			if not CheckHasID1('police', 'storepolicejobveh') then
				Config.JobInteractions['police'][#Config.JobInteractions['police'] +1 ] = {
					id = 'storepolicejobveh',
					title = 'Pane Politsei Garaazi',
					icon = 'parking',
					type = 'client',
					event = 'qb-garages:client:HideJobVeh',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['police']) do
				if v.id == 'storepolicejobveh' then
					Config.JobInteractions['police'][k] = nil
				end
			end
		end

        --Ambulance
        local isInJobGarageAmbulance, lastJobVehicleAmbulance = exports['qb-garages']:isInJobStation('ambulance')
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'ambulance' and PlayerData.job.onduty and isInJobGarageAmbulance and lastJobVehicleAmbulance == nil and not IsPedInAnyVehicle(ped) then  
			if not CheckHasID1('ambulance', 'openambulancejobveh') then
				Config.JobInteractions['ambulance'][#Config.JobInteractions['ambulance'] +1 ] = {
					id = 'openambulancejobveh',
					title = 'Kiirabi Garaaz',
					icon = 'warehouse',
					type = 'client',
					event = 'qb-garages:client:openJobVehList',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['ambulance']) do
				if v.id == 'openambulancejobveh' then
					Config.JobInteractions['ambulance'][k] = nil
				end
			end
		end
		if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() and PlayerData.job.name == 'ambulance' and PlayerData.job.onduty and isInJobGarageAmbulance and lastJobVehicleAmbulance ~= nil and exports["qb-vehiclekeys"]:HasKeys(plate) and veh == lastJobVehicleAmbulance then  
			if not CheckHasID1('ambulance', 'storeambulancejobveh') then
				Config.JobInteractions['ambulance'][#Config.JobInteractions['ambulance'] +1 ] = {
					id = 'storeambulancejobveh',
					title = 'Pane Kiirabi Garaazi',
					icon = 'parking',
					type = 'client',
					event = 'qb-garages:client:HideJobVeh',
					shouldClose = true
				}
			end
		else
			for k, v in pairs(Config.JobInteractions['ambulance']) do
				if v.id == 'storeambulancejobveh' then
					Config.JobInteractions['ambulance'][k] = nil
				end
			end
		end
end

function setupSubItems()
    if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] then
        if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" then
            if not Config.MenuItems[4] then
                Config.MenuItems[4] = {
                    id = 'jobinteractions',
                    title = 'Töö Tegevused',
                    icon = 'briefcase',
                    items = {}
                }
            end
            Config.MenuItems[4].items = {
                [1] = {
                    id = 'emergencybutton2',
                    title = 'Häirenupp',
                    icon = '#general',
                    type = 'client',
                    event = 'police:client:SendPoliceEmergencyAlert',
                    shouldClose = true,
                },
            }
        else
            if Config.JobInteractions[PlayerData.job.name] and next(Config.JobInteractions[PlayerData.job.name]) then
                if not Config.MenuItems[4] then
                    Config.MenuItems[4] = {
                        id = 'jobinteractions',
                        title = 'Töö Tegevused',
                        icon = 'briefcase',
                        items = {}
                    }
                end
                Config.MenuItems[4].items = Config.JobInteractions[PlayerData.job.name]
            else
                Config.MenuItems[4] = nil
            end
        end
    else
        if Config.JobInteractions[PlayerData.job.name] and next(Config.JobInteractions[PlayerData.job.name]) then
            if not Config.MenuItems[4] then
                Config.MenuItems[4] = {
                    id = 'jobinteractions',
                    title = 'Töö Tegevused',
                    icon = 'briefcase',
                    items = {}
                }
            end
            Config.MenuItems[4].items = Config.JobInteractions[PlayerData.job.name]
        else
            Config.MenuItems[4] = nil
        end
    end

    --[[local Vehicle = GetVehiclePedIsIn(PlayerPedId())

    if Vehicle ~= nil or Vehicle ~= 0 then
        local AmountOfSeats = GetVehicleModelNumberOfSeats(GetEntityModel(Vehicle))

        if AmountOfSeats == 2 then
            Config.MenuItems[3].items[3].items = {
                [1] = {
                    id    = -1,
                    title = 'Driver',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [2] = {
                    id    = 0,
                    title = 'Passenger',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        elseif AmountOfSeats == 3 then
            Config.MenuItems[3].items[3].items = {
                [4] = {
                    id    = -1,
                    title = 'Driver',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [1] = {
                    id    = 0,
                    title = 'Passenger',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [3] = {
                    id    = 1,
                    title = 'Other',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        elseif AmountOfSeats == 4 then
            Config.MenuItems[3].items[3].items = {
                [4] = {
                    id    = -1,
                    title = 'Driver',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [1] = {
                    id    = 0,
                    title = 'Passenger',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [3] = {
                    id    = 1,
                    title = 'Rear Left',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [2] = {
                    id    = 2,
                    title = 'Rear Right',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        end
    end]]
end

local function deepcopy(orig) -- modified the deep copy function from http://lua-users.org/wiki/CopyTable
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if not orig.canOpen or orig.canOpen() then
            local toRemove = {}
            copy = {}
            for orig_key, orig_value in next, orig, nil do
                if type(orig_value) == 'table' then
                    if not orig_value.canOpen or orig_value.canOpen() then
                        copy[deepcopy(orig_key)] = deepcopy(orig_value)
                    else
                        toRemove[orig_key] = true
                    end
                else
                    copy[deepcopy(orig_key)] = deepcopy(orig_value)
                end
            end
            for i=1, #toRemove do table.remove(copy, i) --[[ Using this to make sure all indexes get re-indexed and no empty spaces are in the radialmenu ]] end
            if copy and next(copy) then setmetatable(copy, deepcopy(getmetatable(orig))) end
        end
    elseif orig_type ~= 'function' then
        copy = orig
    end
    return copy
end

local function IsPoliceOrEMS()
    return (PlayerData.job.name == "police" or PlayerData.job.name == "ambulance")
end

local function IsDowned()
    return (PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"])
end

function openRadial(bool)
    FinalMenuItems = {}
    if (IsDowned() and IsPoliceOrEMS()) then
        FinalMenuItems = {
            [1] = {
                id = 'emergencybutton1',
                title = '10-13',
                icon = 'sad-tear',
                type = 'server',
                event = 'police:server:policeRadialAlert',
                shouldClose = true,
            },
        }
    elseif (IsDowned() and not IsPoliceOrEMS()) then
        FinalMenuItems = {
            [1] = {
                id = 'emergencybutton2',
                title = 'Kutsu Kiirabi',
                icon = 'sad-tear',
                type = 'server',
                event = 'police:server:civRadialAlert',
                shouldClose = true,
            },
        }
    else
        setupSubItems()
        setupGarageItems()
        FinalMenuItems = deepcopy(Config.MenuItems)
    end

    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        radial = bool,
        items = FinalMenuItems
    })
    inRadialMenu = bool
end

function closeRadial(bool)    
    SetNuiFocus(false, false)
    inRadialMenu = bool
end

function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

-- local function checkOption(t, t2)
--     for k, v in pairs(t) do
--         if v.items then
--             if checkOption(v.items, t2) then return true end
--         else
--             if v.event == t2.event then
--                 return true
--             end
--         end
--     end
--     return false
-- end

local function selectOption(t, t2)
    for k, v in pairs(t) do
        if v.items then
            local found, hasAction, val = selectOption(v.items, t2)
            if found then return true, hasAction, val end
        else
            if v.id == t2.id and ((v.event and v.event == t2.event) or v.action) and (not v.canOpen or v.canOpen()) then
                return true, v.action, v
            end
        end
    end
    return false
end

RegisterNUICallback('closeRadial', function()
    closeRadial(false)
end)

RegisterNUICallback('selectItem', function(data)
    local itemData = data.itemData
    local found, action, data = selectOption(FinalMenuItems, itemData)

    if data and found then
        if action then
            action(data)
        elseif data.type == 'client' then
            TriggerEvent(data.event, data)
        elseif data.type == 'server' then
            TriggerServerEvent(data.event, data)
        elseif data.type == 'command' then
            ExecuteCommand(data.event)
        elseif data.type == 'qbcommand' then
            TriggerServerEvent('QBCore:CallCommand', data.event, data)
        end
    end
end)

-- RegisterNUICallback('selectItem', function(data)
--     local itemData = data.itemData

--     if itemData and checkOption(Config.MenuItems, itemData) then
--         if itemData.type == 'client' then
--             TriggerEvent(itemData.event, itemData)
--         elseif itemData.type == 'server' then
--             TriggerServerEvent(itemData.event, itemData)
--         elseif itemData.type == 'command' then
--             ExecuteCommand(itemData.event)
--         elseif itemData.type == 'qbcommand' then
--             TriggerServerEvent('QBCore:CallCommand', itemData.event, itemData)
--         end
--     end
-- end)

RegisterNetEvent('qb-radialmenu:client:noPlayers')
AddEventHandler('qb-radialmenu:client:noPlayers', function()
    QBCore.Functions.Notify('There arrent any people close', 'error', 2500)
end)

RegisterNetEvent('qb-radialmenu:client:giveidkaart')
AddEventHandler('qb-radialmenu:client:giveidkaart', function(data)
    -- ??
end)

RegisterNetEvent('qb-radialmenu:client:openDoor')
AddEventHandler('qb-radialmenu:client:openDoor', function(data)
    local string = data.id
    local replace = string:gsub("door", "")
    local door = tonumber(replace)
    local ped = PlayerPedId()
    local closestVehicle = nil

    if IsPedInAnyVehicle(ped, false) then
        closestVehicle = GetVehiclePedIsIn(ped)
    else
        closestVehicle = getNearestVeh()
    end

    if closestVehicle ~= 0 then
        if closestVehicle ~= GetVehiclePedIsIn(ped) then
            local plate = GetVehicleNumberPlateText(closestVehicle)
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', false, plate, door)
                else
                    SetVehicleDoorShut(closestVehicle, door, false)
                end
            else
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', true, plate, door)
                else
                    SetVehicleDoorOpen(closestVehicle, door, false, false)
                end
            end
        else
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                SetVehicleDoorShut(closestVehicle, door, false)
            else
                SetVehicleDoorOpen(closestVehicle, door, false, false)
            end
        end
    else
        QBCore.Functions.Notify('There is no vehicle in sight...', 'error', 2500)
    end
end)

RegisterNetEvent('qb-radialmenu:client:setExtra', function(data)
    local string = data.id
    local replace = string:gsub("extra", "")
    local extra = tonumber(replace)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= nil then
        if GetPedInVehicleSeat(veh, -1) == ped then
            SetVehicleAutoRepairDisabled(veh, true) -- Forces Auto Repair off when Toggling Extra [GTA 5 Niche Issue]
            if DoesExtraExist(veh, extra) then
                if IsVehicleExtraTurnedOn(veh, extra) then
                    SetVehicleExtra(veh, extra, 1)
                    QBCore.Functions.Notify('Extra eemaldatud', 'error', 2500)
                else
                    SetVehicleExtra(veh, extra, 0)
                    QBCore.Functions.Notify('Extra lisatud', 'success', 2500)
                end
            else
                QBCore.Functions.Notify('Seda extrat ei ole sellele sõidukile', 'error', 2500)
            end
        else
            QBCore.Functions.Notify('Pead juhiistmel olema', 'error', 2500)
        end
    end
end)

RegisterNetEvent('qb-radialmenu:trunk:client:Door')
AddEventHandler('qb-radialmenu:trunk:client:Door', function(plate, door, open)
    local veh = GetVehiclePedIsIn(PlayerPedId())

    if veh ~= 0 then
        local pl = GetVehicleNumberPlateText(veh)

        if pl == plate then
            if open then
                SetVehicleDoorOpen(veh, door, false, false)
            else
                SetVehicleDoorShut(veh, door, false)
            end
        end
    end
end)

local Seats = {
    ["-1"] = "Driver's Seat",
    ["0"] = "Passenger's Seat",
    ["1"] = "Rear Left Seat",
    ["2"] = "Rear Right Seat",
}

RegisterNetEvent('qb-radialmenu:client:ChangeSeat')
AddEventHandler('qb-radialmenu:client:ChangeSeat', function(data)
    local Veh = GetVehiclePedIsIn(PlayerPedId())
    local IsSeatFree = IsVehicleSeatFree(Veh, data.id)
    local speed = GetEntitySpeed(Veh)
    local HasHarnass = exports['qb-smallresources']:HasHarness()
    if not HasHarnass then
        local kmh = (speed * 3.6);  

        if IsSeatFree then
            if kmh <= 100.0 then
                SetPedIntoVehicle(PlayerPedId(), Veh, data.id)
                QBCore.Functions.Notify('Your now on the  '..data.title..'!')
            else
                QBCore.Functions.Notify('The vehicle goes too fast..')
            end
        else
            QBCore.Functions.Notify('This seat is occupied..')
        end
    else
        QBCore.Functions.Notify('You have a race harness on u cant switch..', 'error')
    end
end)

RegisterNetEvent('qb-radialmenu:client:flipvehicle', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    if DoesEntityExist(vehicle) then
        exports['progressbar']:Progress({
            name = "flipping_vehicle",
            duration = 5000,
            label = "Kallutab autot",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "random@mugging4",
                anim = "struggle_loop_b_thief",
                flags = 49,
            }
        }, function(status)
            SetVehicleOnGroundProperly(vehicle)
        end)
    else
        QBCore.Functions.Notify('Pole ühtegi sõidukit lähedal', 'error') 
    end
end)

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
