QBCore = exports['qb-core']:GetCoreObject()

--local sellItemsSet = false
local sellPrice = 0
local sellHardwareItemsSet = false
local sellHardwarePrice = 0

isLoggedIn = false

RegisterNetEvent('i13-pawnshop:client:itemsMenu', function()
	exports['qb-menu']:openMenu({
		{
			header = 'Müü Esemeid',
			txt = 'Müü maha enda ehted',
			params = {
				event = 'i13-pawnshop:client:sellItems',
				args = 1,
			}
		},
		{
			header = 'Müü Elektroonikat',
			txt = 'Müü maha enda elektroonikat',
			params = {
				event = 'i13-pawnshop:client:sellItems',
				args = 2,
			}
		},
		{
			header = 'Müü Kulda',
			txt = 'Müü maha enda kullakangid',
			params = {
				event = 'i13-pawnshop:client:sellItems',
				args = 3,
			}
		},
		{
			header = '',
			txt = '✘ Sulge',
			params = {
				event = 'i13-pawnshop:client:sellItems',
				args = -1,
			}
		},
	})
end)

RegisterNetEvent('i13-pawnshop:client:openPawnMenu', function()
	exports['qb-menu']:openMenu({
		{
			isMenuHeader = true,
			header = '',
			txt = 'Osta Pandimaja Esemeid',
		},
		{
			header = 'Telefon | $200',
			txt = 'Ettemakstud nuppudega telefon',
			params = {
				event = 'i13-pawnshop:client:buyItem',
				args = 'emptydropphone',
			}
		},
		{
			header = '',
			txt = '✘ Sulge',
			params = {
				event = 'i13-pawnshop:client:closeMenu',
			}
		},
	})
end)

RegisterNetEvent('i13-pawnshop:client:buyItem', function(item)
	TriggerServerEvent('i13-pawnshop:server:buyItem', item)
end)

RegisterNetEvent('i13-pawnshop:client:closeMenu', function()
	exports['qb-menu']:closeMenu()
end)

RegisterNetEvent('i13-pawnshop:client:sellItems', function(data)
	if data == -1 then
		exports['qb-menu']:closeMenu()
		return
	end
	if data == 1 then
		QBCore.Functions.TriggerCallback('i13-pawnshop:server:getSellPrice', function(result)
			local sellPrice = result
			if sellPrice ~= 0 then
				TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
				QBCore.Functions.Progressbar("sell_pawn_items", "Müüb esemeid...", math.random(15000, 25000), false, true, {}, {}, {}, {}, function() -- Done
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent("i13-pawnshop:server:sellPawnItems")
					sellPrice = 0
				end, function() -- Cancel
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.Notify("Tühistatud", "error")
				end)
			else
				QBCore.Functions.Notify('Sul ei ole midagi müüa', 'error')
			end
		end)
	elseif data == 2 then
		QBCore.Functions.TriggerCallback('i13-pawnshop:server:getSellHardwarePrice', function(result)
			local sellHardwarePrice = result
			if sellHardwarePrice ~= 0 then
				TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
				QBCore.Functions.Progressbar("sell_pawn_items", "Müüb elektroonikat...", math.random(15000, 25000), false, true, {}, {}, {}, {}, function() -- Done
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent("i13-pawnshop:server:sellHardwarePawnItems")
					sellHardwarePrice = 0
				end, function() -- Cancel
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.Notify("Tühistatud", "error")
				end)
			else
				QBCore.Functions.Notify('Sul ei ole midagi müüa', 'error')
			end
		end)
	elseif data == 3 then
		QBCore.Functions.TriggerCallback('i13-pawnshop:server:hasGold', function(result)
			if result then
				TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
				QBCore.Functions.Progressbar("sell_gold", "Müüb kulda...", math.random(15000, 25000), false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent('i13-pawnshop:server:sellGold')
				end, function() -- Cancel
					ClearPedTasks(PlayerPedId())
					QBCore.Functions.Notify("Tühistatud", "error")
				end)
			else
				QBCore.Functions.Notify('Sul ei ole kulda', 'error')
			end
		end)
	end
end)

CreateThread(function()
	local blip = AddBlipForCoord(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z)
	SetBlipSprite(blip, 431)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Pandimaja")
	EndTextCommandSetBlipName(blip)
end)

--[[Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z)
	SetBlipSprite(blip, 431)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Pandimaja")
	EndTextCommandSetBlipName(blip)
	while true do 
		Citizen.Wait(1)
		local inRange = false
		local pos = GetEntityCoords(PlayerPedId())
		if #(pos - Config.PawnLocation) < 5.0 then
			inRange = true
			if #(pos - Config.PawnLocation) < 1.5 then
				if GetClockHours() >= 7 and GetClockHours() <= 17 then
					if not sellItemsSet then 
						sellPrice = GetSellingPrice()
						sellItemsSet = true
					elseif sellItemsSet and sellPrice ~= 0 then
						DrawText3D(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, "~g~E~w~ - Müü Kellad/ Kaelakeed / Sõrmused ($"..sellPrice..")")
						if IsControlJustReleased(0, 38) then
							TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
                            QBCore.Functions.Progressbar("sell_pawn_items", "Müüb esemeid", math.random(15000, 25000), false, true, {}, {}, {}, {}, function() -- Done
                                ClearPedTasks(PlayerPedId())
								TriggerServerEvent("i13-pawnshop:server:sellPawnItems")
								sellItemsSet = false
								sellPrice = 0
                            end, function() -- Cancel
								ClearPedTasks(PlayerPedId())
								QBCore.Functions.Notify("Tühistatud", "error")
							end)
						end
					else
						DrawText3D(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, "Pandimaja: Sul ei ole midagi müüa")
					end
				else
					DrawText3D(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, "Pandimaja on suletud, avaneb kell ~r~7:00")
				end
			end
		end
		if not inRange then
			sellPrice = 0
			sellItemsSet = false
			Citizen.Wait(2500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local inRange = false
		local pos = GetEntityCoords(PlayerPedId())
		if #(pos - Config.PawnHardwareLocation) < 5.0 then
			inRange = true
			if #(pos - Config.PawnHardwareLocation) < 1.5 then
				if GetClockHours() >= 9 and GetClockHours() <= 16 then
					if not sellHardwareItemsSet then 
						sellHardwarePrice = GetSellingHardwarePrice()
						sellHardwareItemsSet = true
					elseif sellHardwareItemsSet and sellHardwarePrice ~= 0 then
						DrawText3D(Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, "~g~E~w~ - Müü iPhone / Samsung S10 / Tabletid / Laptopid ($"..sellHardwarePrice..")")
						if IsControlJustReleased(0, 38) then
							TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
                            QBCore.Functions.Progressbar("sell_pawn_items", "Müüb esemeid", math.random(15000, 25000), false, true, {}, {}, {}, {}, function() -- Done
                                ClearPedTasks(PlayerPedId())
								TriggerServerEvent("i13-pawnshop:server:sellHardwarePawnItems")
								sellHardwareItemsSet = false
								sellHardwarePrice = 0
                            end, function() -- Cancel
								ClearPedTasks(PlayerPedId())
								QBCore.Functions.Notify("Tühistatud", "error")
							end)
						end
					else
						DrawText3D(Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, "Elektroonika Pood: Sul ei ole midagi müüa")
					end
				else
					DrawText3D(Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, "Pood suletud, avaneb kell ~r~9:00")
				end
			end
		end
		if not inRange then
			sellHardwarePrice = 0
			sellHardwareItemsSet = false
			Citizen.Wait(2500)
		end
	end
end) ]]

CreateThread(function()
    local pedModel = `mp_m_weapexp_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector3(173.02, -1317.31, 29.35)
    local pedHeading = 239.19

    pawnPed = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, pedHeading, false, true)
    FreezeEntityPosition(pawnPed, true)
    SetEntityInvincible(pawnPed, true)
    SetBlockingOfNonTemporaryEvents(pawnPed, true)

		exports['qb-target']:AddTargetEntity(pawnPed, {
			options = {
				{
					type = 'client',
					event = 'i13-pawnshop:client:itemsMenu',
					icon = 'fas fa-comment-dollar',
					label = 'Pandimaja',
				}
			},
			distance = 2.5,
		})
end)

CreateThread(function()
	exports['qb-target']:AddBoxZone('pawnshoppe', vector3(172.8, -1319.38, 29.35), 0.9, 1.2, {
		name = 'pawnshoppe',
		heading = 63,
		debugPoly = false,
		minZ = 29.05,
		maxZ = 29.55
	}, {
		options = {
			{
				type = 'client',
				event = 'i13-pawnshop:client:openPawnMenu',
				label = 'Osta Asju',
				icon = 'fas fa-clipboard-list',
			}
		},
		distance = 1.5,
	})
end)