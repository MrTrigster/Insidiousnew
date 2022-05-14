local notified = false
local lastNotified = 0

local banks = {
	{name="Pank", id=108, x=150.266, y=-1040.203, z=29.374},
	{name="Pank", id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="Pank", id=108, x=-2962.582, y=482.627, z=15.703},
	{name="Pank", id=108, x=-112.202, y=6469.295, z=31.626},
	{name="Pank", id=108, x=314.187, y=-278.621, z=54.170},
	{name="Pank", id=108, x=-351.534, y=-49.529, z=49.042}, 
	{name="Pank", id=108, x=247.13, y=222.4, z=106.29}, -- pacific
	{name="Pank", id=108, x=1175.064, y=2706.643, z=38.094}
}

RegisterNetEvent("qb-banking:client:ExtNotify")
AddEventHandler("qb-banking:client:ExtNotify", function(msg)
	if (not msg or msg == "") then return end

	QBCore.Functions.Notify(msg)
end)

--[[ Show Things ]]--
Citizen.CreateThread(function()
	for k,v in ipairs(banks) do
	  local blip = AddBlipForCoord(v.x, v.y, v.z)
	  SetBlipSprite(blip, v.id)
	  SetBlipDisplay(blip, 4)
	  SetBlipScale  (blip, 1.0)
	  SetBlipColour (blip, 0)
	  SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString(tostring(v.name))
	  EndTextCommandSetBlipName(blip)
	end
end)


RegisterNetEvent('qb-banking:client:bank:openUI')
AddEventHandler('qb-banking:client:bank:openUI', function() -- this one bank from target models
	if not bMenuOpen then
		--TriggerEvent('animations:client:EmoteCommandStart', {"ATM"})

		QBCore.Functions.Progressbar("atm", "Siseneb Panka...", 2500, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
			ToggleUI()
		end, function()
			QBCore.Functions.Notify('Katkestatud', 'error')
			--TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		end)
	end
end)
RegisterNetEvent('qb-banking:client:atm:openUI')
AddEventHandler('qb-banking:client:atm:openUI', function() -- this opens ATM
	if not bMenuOpen then
		TriggerEvent('animations:client:EmoteCommandStart', {"ATM"})

		QBCore.Functions.Progressbar("atm", "Siseneb ATM\'i...", 4500, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
			ToggleUI()
		end, function()
			QBCore.Functions.Notify('Katkestatud', 'error')
			TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		end)
	end
end)

--[[
CreateThread(function()
	exports['qb-target']:AddBoxZone('pacificbank', vector3(247.63, 223.76, 106.29), 0.4, 3.5, {
		name = 'pacificbank',
		heading = 340.00,
		debugPoly = false,
		minZ = 106.09,
		maxZ = 107.89
	}, {
		options = {
			{
				type = 'client',
				event = 'qb-banking:client:bank:openUI',
				icon = 'fas fa-university',
				label = 'Pank',
			},
		},
		distance = 1.5,
	})

	exports['qb-target']:AddBoxZone('motelbank', vector3(313.39, -279.37, 54.16), 0.4, 6.0, {
		name = 'motelbank',
		heading = 340.00,
		debugPoly = false,
		minZ = 54.36,
		maxZ = 55.56
	}, {
		options = {
			{
				type = 'client',
				event = 'qb-banking:client:bank:openUI',
				icon = 'fas fa-university',
				label = 'Pank',
			},
		},
		distance = 1.5,
	})

	exports['qb-target']:AddBoxZone('customsbank', vector3(-351.75, -50.2, 49.04), 0.4, 6.0, {
		name = 'customsbank',
		heading = 340.00,
		debugPoly = false,
		minZ = 49.24,
		maxZ = 50.44
	}, {
		options = {
			{
				type = 'client',
				event = 'qb-banking:client:bank:openUI',
				icon = 'fas fa-university',
				label = 'Pank',
			},
		},
		distance = 1.5,
	})

	exports['qb-target']:AddBoxZone('linvaderbank', vector3(-1213.12, -331.52, 37.78), 0.4, 5.8, {
		name = 'linvaderbank',
		heading = 27.00,
		debugPoly = false,
		minZ = 37.98,
		maxZ = 39.18
	}, {
		options = {
			{
				type = 'client',
				event = 'qb-banking:client:bank:openUI',
				icon = 'fas fa-university',
				label = 'Pank',
			},
		},
		distance = 1.5,
	})

	exports['qb-target']:AddBoxZone('legionbank', vector3(149.05, -1040.98, 29.38), 0.4, 6.0, {
		name = 'legionbank',
		heading = 340.00,
		debugPoly = false,
		minZ = 29.58,
		maxZ = 30.78
	}, {
		options = {
			{
				type = 'client',
				event = 'qb-banking:client:bank:openUI',
				icon = 'fas fa-university',
				label = 'Pank',
			},
		},
		distance = 1.5,
	})

	exports['qb-target']:AddBoxZone('westbank', vector3(-2962.05, 482.22, 15.71), 0.4, 6.0, {
		name = 'westbank',
		heading = 267.00,
		debugPoly = false,
		minZ = 15.91,
		maxZ = 17.11
	}, {
		options = {
			{
				type = 'client',
				event = 'qb-banking:client:bank:openUI',
				icon = 'fas fa-university',
				label = 'Pank',
			},
		},
		distance = 1.5,
	})

	exports['qb-target']:AddBoxZone('sandybank', vector3(1175.74, 2707.33, 38.1), 0.4, 6.0, {
		name = 'sandybank',
		heading = 0.00,
		debugPoly = false,
		minZ = 38.3,
		maxZ = 39.5
	}, {
		options = {
			{
				type = 'client',
				event = 'qb-banking:client:bank:openUI',
				icon = 'fas fa-university',
				label = 'Pank',
			},
		},
		distance = 1.5,
	})

	exports['qb-target']:AddBoxZone('paletobank', vector3(-112.18, 6470.03, 31.63), 0.4, 6.0, {
		name = 'paletobank',
		heading = 315.00,
		debugPoly = false,
		minZ = 31.83,
		maxZ = 33.03
	}, {
		options = {
			{
				type = 'client',
				event = 'qb-banking:client:bank:openUI',
				icon = 'fas fa-university',
				label = 'Pank',
			},
		},
		distance = 1.5,
	})
end) ]]

-- ATMS

CreateThread(function()
    local atms = SimpleBanking.ATMModels

    exports['qb-target']:AddTargetModel(atms, {
        options = {
            {
                type = 'client',
                event = 'qb-banking:client:atm:openUI',
                icon = 'fas fa-credit-card',
                label = 'ATM',
            }
        },
        distance = 1.5,
    })
end)