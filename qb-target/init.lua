function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

local BackEngineVehicles = {
	[`ninef`] = true,
	[`adder`] = true,
	[`vagner`] = true,
	[`t20`] = true,
	[`infernus`] = true,
	[`zentorno`] = true,
	[`reaper`] = true,
	[`comet2`] = true,
	[`comet3`] = true,
	[`jester`] = true,
	[`jester2`] = true,
	[`cheetah`] = true,
	[`cheetah2`] = true,
	[`prototipo`] = true,
	[`turismor`] = true,
	[`pfister811`] = true,
	[`ardent`] = true,
	[`nero`] = true,
	[`nero2`] = true,
	[`tempesta`] = true,
	[`vacca`] = true,
	[`bullet`] = true,
	[`osiris`] = true,
	[`entityxf`] = true,
	[`turismo2`] = true,
	[`fmj`] = true,
	[`re7b`] = true,
	[`tyrus`] = true,
	[`italigtb`] = true,
	[`penetrator`] = true,
	[`monroe`] = true,
	[`ninef2`] = true,
	[`stingergt`] = true,
	[`surfer`] = true,
	[`surfer2`] = true,
	[`gp1`] = true,
	[`autarch`] = true,
	[`tyrant`] = true,
	[`xa21`] = true
}

local function ToggleDoor(vehicle, door)
	if GetVehicleDoorLockStatus(vehicle) ~= 2 then
			if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
					SetVehicleDoorShut(vehicle, door, false)
			else
					SetVehicleDoorOpen(vehicle, door, false)
			end
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 3.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- Draw a Sprite on the center of a PolyZone to hint where it's located
Config.DrawSprite = false

-- The default distance to draw the Sprite
Config.DrawDistance = 10.0

-- The color of the sprite in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.DrawColor = {255, 255, 255, 255}

-- The color of the sprite in rgb when the PolyZone is targeted, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.SuccessDrawColor = {30, 144, 255, 255}

-- The color of the outline in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = {255, 255, 255, 255}

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = false

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = true

-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'LMENU' -- Left Alt

-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
Config.MenuControlKey = 237

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {

}

Config.PolyZones = {

}

Config.TargetBones = {
	["wheel_lr"] = {
		bones = {
				'wheel_lr',
		},
		options = {
			{
				type = "client",
				event = "lj-fuel:client:SendMenuToServer",
				icon = "fas fa-gas-pump",
				label = "Tangi Sõidukit",
		 },
		},
		distance = 1.0
	},
	["boot"] = {
		bones = {
				'boot',
		},
		options = {
			{
				type = "client",
				event = "i13-trunk:client:GetIn",
				icon = "fas fa-caret-down",
				label = "Roni Pagasiruumi",
			},
			{
				icon = "fas fa-truck-ramp-box",
        label = "Ava/Sulge Pagasiruum",
        action = function(entity)
          ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 4 or 5)
        end,
			},
		},
		distance = 1.0
	},
	["bonnet"] = {
		bones = {
				'bonnet',
		},
		options = {
			{
				icon = "fas fa-caret-up",
				label = "Ava/Sulge Kapott",
				action = function(entity)
					ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 5 or 4)
				end,
			},
		},
		distance = 1.0
	},
}

Config.TargetModels = {

}

Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {
	options = {
		{
			type = "client",
			event = "i13-vehiclekeys:client:GiveKeysTarget",
			icon = "fas fa-key",
			label = "Anna Võtmed",
		},
		{
			type = "client",
			event = "police:client:PutPlayerInVehicle",
			icon = "fas fa-circle-arrow-right",
			label = "Pane Sõidukisse",
		},
		{
			type = "client",
			event = "police:client:SetPlayerOutVehicle",
			icon = "fas fa-circle-arrow-left",
			label = "Võta Sõidukist",
		},
		{
			type = 'client',
			event = 'i13-methcar:cook',
			icon = 'fas fa-blender',
			label = 'Küpseta',
			canInteract = function(entity)
				if GetVehicleEngineHealth(entity) <= 0 then return false end
				local model = GetEntityModel(entity)
				local modelName = GetDisplayNameFromVehicleModel(model)
				if modelName == 'JOURNEY' then
					return true
				end
					return false
			end
		},
	},
	distance = 1.4,
}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {
	options = {
		{
			type = 'client',
			event = 'i13-phone:client:GiveContactDetails',
			icon = 'fas fa-address-book',
			label = 'Anna Kontaktandmed',
		}
	}
}

Config.Peds = {

}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local function JobCheck() return true end
local function GangCheck() return true end
local function ItemCount() return true end
local function CitizenCheck() return true end

CreateThread(function()
	local state = GetResourceState('i13-core')
	if state ~= 'missing' then
		if state ~= 'started' then
			local timeout = 0
			repeat
				timeout += 1
				Wait(0)
			until GetResourceState('i13-core') == 'started' or timeout > 100
		end
		Config.Standalone = false
	end
	if Config.Standalone then
		local firstSpawn = false
		local event = AddEventHandler('playerSpawned', function()
			SpawnPeds()
			firstSpawn = true
		end)
		-- Remove event after it has been triggered
		while true do
			if firstSpawn then
				RemoveEventHandler(event)
				break
			end
			Wait(1000)
		end
	else
		local QBCore = exports['qb-core']:GetCoreObject()
		local PlayerData = QBCore.Functions.GetPlayerData()

		ItemCount = function(item)
			for _, v in pairs(PlayerData.items) do
				if v.name == item then
					return true
				end
			end
			return false
		end

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			PlayerData = QBCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	end
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.job and not JobCheck(data.job) then return false end
	if data.gang and not GangCheck(data.gang) then return false end
	if data.item and not ItemCount(data.item) then return false end
	if data.citizenid and not CitizenCheck(data.citizenid) then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	return true
end