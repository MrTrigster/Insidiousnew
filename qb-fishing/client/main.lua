QBCore = exports['qb-core']:GetCoreObject()

cachedData = {}
local JobBusy = false

function CreateBlips()
	for i, zone in ipairs(Config.FishingZones) do
		local coords = zone.secret and ((zone.coords / 1.5) - 133.37) or zone.coords
		local name = zone.name
		if not zone.secret then
			local x = AddBlipForCoord(coords)
			SetBlipSprite (x, 405)
			SetBlipDisplay(x, 4)
			SetBlipScale  (x, 0.5)
			SetBlipAsShortRange(x, true)
			SetBlipColour(x, 69)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(name)
			EndTextCommandSetBlipName(x)
			blips = x
		end
	end
end

function DeleteBlips()
	if DoesBlipExist(x) then
		RemoveBlip(x)
	end
end

-- function SellFish()


RegisterNetEvent("qb-fishing:tryToFish", function()
	TryToFish() 
end)

RegisterNetEvent("qb-fishing:calculatedistances", pos, function()

end)

RegisterNetEvent('qb-fishing:client:sellFish', function()
	SellFish()
end)

RegisterNetEvent('qb-fishing:client:startWorking', function()
	if not JobBusy then
		JobBusy = true
		-- CreateBlips()
		QBCore.Functions.Notify('Sa alustasid töötamist', 'success')
	else
		QBCore.Functions.Notify('Sa oled juba töötamist alustanud', 'error')
	end
end)

RegisterNetEvent('qb-fishing:client:stopWorking', function()
	if JobBusy then
		JobBusy = false
		-- DeleteBlips()
		QBCore.Functions.Notify('Sa lõpetasid töötamise', 'success')
	else
		QBCore.Functions.Notify('Sa ei ole töötamist alustanud', 'error')
	end
end)

-- CreateThread(function()
-- 	Wait(500)
-- 	HandleStore()
-- 	while true do
-- 		local sleepThread = 500
-- 		local ped = cachedData["ped"]
-- 		if DoesEntityExist(cachedData["storeOwner"]) then
-- 			local pedCoords = GetEntityCoords(ped)
-- 			local dstCheck = #(pedCoords - GetEntityCoords(cachedData["storeOwner"]))
-- 			if dstCheck < 3.0 then
-- 				if JobBusy == true then
-- 					sleepThread = 5
-- 					local displayText = not IsEntityDead(cachedData["storeOwner"]) and "Press ~INPUT_CONTEXT~ to sell your fish to the owner." or "The owner is dead, and therefore can not speak."
-- 					if IsControlJustPressed(0, 38) then
-- 						DeleteBlips()
-- 						SellFish()
-- 					end
-- 					ShowHelpNotification(displayText)
-- 				elseif JobBusy == false then
-- 					sleepThread = 5
-- 					local displayText = not IsEntityDead(cachedData["storeOwner"]) and "Press ~INPUT_CONTEXT~ to start working."
-- 					if IsControlJustPressed(0, 38) then
-- 						JobBusy = true
-- 						CreateBlips()
-- 						Wait(5000)
-- 					end
-- 					ShowHelpNotification(displayText)
-- 				end
-- 			end
-- 		end
-- 		Wait(sleepThread)
-- 	end
-- end)

CreateThread(function()
	HandleStore()
	CreateBlips()
	local models = {
		`s_m_m_linecook`
	}
	exports['qb-target']:AddTargetModel(models, {
		options = {
			{
				type = 'client',
				event = 'qb-fishing:client:sellFish',
				icon = 'fas fa-dollar-sign',
				label = 'Müü Kala',
			},
		},
		distance = 2.0,
	})
end)

CreateThread(function()
	while true do
		Wait(1500)

		local ped = PlayerPedId()

		if cachedData["ped"] ~= ped then
			cachedData["ped"] = ped
		end
	end
end)
