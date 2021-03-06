local QBCore = exports['qb-core']:GetCoreObject()
function CreateBlips()
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].blipTrue then
			local blip = AddBlipForCoord(v.location)
			SetBlipAsShortRange(blip, true)
			SetBlipSprite(blip, 527)
			SetBlipColour(blip, 81)
			SetBlipScale(blip, 0.9)
			SetBlipDisplay(blip, 6)

			BeginTextCommandSetBlipName('STRING')
			if Config.BlipNamer then
				AddTextComponentString(Config.Locations[k].name)
			else
				AddTextComponentString("Mining")
			end
			EndTextCommandSetBlipName(blip)
		end
	end
end

Citizen.CreateThread(function()
    if Config.Blips == true then
		CreateBlips()
	end
end)
Citizen.CreateThread(function()
	if Config.PropSpawn == true then
		CreateProps()
	end
end)
Citizen.CreateThread(function()
	if Config.Pedspawn == true then
		CreatePeds()
	end
end)
-----------------------------------------------------------

local peds = {}
local shopPeds = {}
function CreatePeds()
	while true do
		Citizen.Wait(500)
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)
			if dist < Config.Distance and not peds[k] then
				local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				peds[k] = {ped = ped}
			end
			if dist >= Config.Distance and peds[k] then
				if Config.Fade then
					for i = 255, 0, -51 do
						Citizen.Wait(50)
						SetEntityAlpha(peds[k].ped, i, false)
					end
				end
				DeletePed(peds[k].ped)
				peds[k] = nil
			end
		end
	end
end

function nearPed(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(1)
	end
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
		print("No gender provided! Check your configuration!")
	end
	if Config.MinusOne then 
		local x, y, z = table.unpack(coords)
		ped = CreatePed(genderNum, GetHashKey(model), x, y, z - 1, heading, false, true)
		table.insert(shopPeds, ped)
	else
		ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
		table.insert(shopPeds, ped)
	end
	SetEntityAlpha(ped, 0, false)
	if Config.Frozen then
		FreezeEntityPosition(ped, true) --Don't let the ped move.
	end
	if Config.Invincible then
		SetEntityInvincible(ped, true) --Don't let the ped die.
	end
	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(ped, true) --Don't let the ped react to his surroundings.
	end
	--Add an animation to the ped, if one exists.
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) -- begins peds animation
	end
	if Config.Fade then
		for i = 0, 255, 51 do
			Citizen.Wait(50)
			SetEntityAlpha(ped, i, false)
		end
	end
	return ped
end

-----------------------------------------------------------

function CreateProps()
	local prop = 0
	for k,v in pairs(Config.OrePositions) do
		prop = prop+1
		local prop = CreateObject(GetHashKey("cs_x_rubweec"),v.coords.x, v.coords.y, v.coords.z+1.03,false,false,false)
		SetEntityHeading(prop,GetEntityHeading(prop)-90)
		FreezeEntityPosition(prop, true)           
    end
	for k,v in pairs(Config.MineLights) do
		prop = prop+1
		local prop = CreateObject(GetHashKey("xs_prop_arena_lights_ceiling_l_c"),v.coords.x, v.coords.y, v.coords.z+1.03,false,false,false)
		--SetEntityHeading(prop,GetEntityHeading(prop)-90)
		FreezeEntityPosition(prop, true)           
    end
	--Jewel Cutting Bench
	local bench = CreateObject(GetHashKey("gr_prop_gr_bench_04b"),Config.Locations['JewelCut'].location,false,false,false)
	SetEntityHeading(bench,GetEntityHeading(bench)-Config.Locations['JewelCut'].heading)
	FreezeEntityPosition(bench, true)

	--Stone Cracking Bench
	local bench2 = CreateObject(GetHashKey("prop_tool_bench02"),Config.Locations['Cracking'].location,false,false,false)
	SetEntityHeading(bench2,GetEntityHeading(bench2)-Config.Locations['Cracking'].heading)
	FreezeEntityPosition(bench2, true)
	--Stone Prop for bench
	local bench2prop = CreateObject(GetHashKey("cs_x_rubweec"),Config.Locations['Cracking'].location.x, Config.Locations['Cracking'].location.y, Config.Locations['Cracking'].location.z+0.83,false,false,false)
	SetEntityHeading(bench2prop,GetEntityHeading(bench2prop)-Config.Locations['Cracking'].heading+90)
	FreezeEntityPosition(bench2prop, true)
	local bench2prop2 = CreateObject(GetHashKey("prop_worklight_03a"),Config.Locations['Cracking'].location.x-1.4, Config.Locations['Cracking'].location.y+1.08, Config.Locations['Cracking'].location.z,false,false,false)
	SetEntityHeading(bench2prop2,GetEntityHeading(bench2prop2)-Config.Locations['Cracking'].heading+180)
	FreezeEntityPosition(bench2prop2, true)
end

-----------------------------------------------------------

Citizen.CreateThread(function()
	exports['qb-target']:AddCircleZone("MineShaft", Config.Locations['Mine'].location, 2.0, { name="MineShaft", debugPoly=false, useZ=true, }, 
	{ options = { { event = "jim-mining:openShop", icon = "fas fa-certificate", label = "Osta Vahendeid", }, },
		distance = 2.0
	})
	exports['qb-target']:AddCircleZone("Quarry", Config.Locations['Quarry'].location, 2.0, { name="Quarry", debugPoly=false, useZ=true, }, 
	{ options = { { event = "jim-mining:openShop", icon = "fas fa-certificate", label = "Osta Vahendeid", }, },
		distance = 2.0
	})
	--Smelter to turn stone into ore
	exports['qb-target']:AddCircleZone("Smelter", Config.Locations['Smelter'].location, 3.0, { name="Smelter", debugPoly=false, useZ=true, }, 
	{ options = { { event = "jim-mining:SmeltMenu", icon = "fas fa-certificate", label = "Kasuta Sulatuskoda", }, },
		distance = 10.0
	})
	--Ore Buyer
	exports['qb-target']:AddCircleZone("Buyer", Config.Locations['Buyer'].location, 2.0, { name="Buyer", debugPoly=false, useZ=true, }, 
	{ options = { { event = "jim-mining:SellOre", icon = "fas fa-certificate", label = "M???? Maaki", },	},
		distance = 2.0
	})
	--Jewel Cutting Bench
	exports['qb-target']:AddCircleZone("JewelCut", Config.Locations['JewelCut'].location, 2.0, { name="JewelCut", debugPoly=false, useZ=true, }, 
	{ options = { { event = "jim-mining:JewelCut", icon = "fas fa-certificate", label = "Kasuta Kalliskivi L??ikelauda", },	},
		distance = 2.0
	})
	--Jewel Buyer
	exports['qb-target']:AddCircleZone("JewelBuyer", Config.Locations['Buyer2'].location, 2.0, { name="JewelBuyer", debugPoly=false, useZ=true, }, 
	{ options = { { event = "jim-mining:JewelSell", icon = "fas fa-certificate", label = "M???? Juveele", },	},
		distance = 2.0
	})
	--Cracking Bench
	exports['qb-target']:AddCircleZone("CrackingBench", Config.Locations['Cracking'].location, 2.0, { name="CrackingBench", debugPoly=false, useZ=true, }, 
	{ options = { { event = "jim-mining:CrackStart", icon = "fas fa-certificate", label = "Murra Kivi", },	},
		distance = 2.0
	})
	local ore = 0
	for k,v in pairs(Config.OrePositions) do
		ore = ore+1
		exports['qb-target']:AddCircleZone(ore, v.coords, 2.0, { name=ore, debugPoly=false, useZ=true, }, 
		{ options = { { event = "jim-mining:MineOre", icon = "fas fa-certificate", label = "Kaevanda", },	},
			distance = 2.5
		})
	end
end)

-----------------------------------------------------------
--Mining Store Opening
RegisterNetEvent('jim-mining:openShop')
AddEventHandler('jim-mining:openShop', function ()
	TriggerServerEvent("inventory:server:OpenInventory", "shop", "mine", Config.Items)
end)
------------------------------------------------------------
-- Mine Ore Command / Animations

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('jim-mining:MineOre')
AddEventHandler('jim-mining:MineOre', function ()
QBCore.Functions.TriggerCallback("QBCore:HasItem", function(item) 
		if item then 
			local pos = GetEntityCoords(GetPlayerPed(-1))
			loadAnimDict("anim@heists@fleeca_bank@drilling")
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			local DrillObject = CreateObject(GetHashKey("hei_prop_heist_drill"), pos.x, pos.y, pos.z, true, true, true)
			AttachEntityToEntity(DrillObject, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
			QBCore.Functions.Progressbar("open_locker_drill", "Puurib kivi...", math.random(10000,15000), false, true, {
				disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
				StopAnimTask(GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
				DetachEntity(DrillObject, true, true)
				DeleteObject(DrillObject)
					TriggerServerEvent('jim-mining:MineReward')
					IsDrilling = false
			end, function() -- Cancel
				StopAnimTask(GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
				DetachEntity(DrillObject, true, true)
				DeleteObject(DrillObject)
				IsDrilling = false
			end)
		else
			TriggerEvent('QBCore:Notify', "Sul ei ole puuri", 'error')
		end 
	end, "drill")
end)

------------------------------------------------------------

-- Cracking Command / Animations
-- Command Starts here where it calls to being the stone inv checking


RegisterNetEvent('jim-mining:CrackStart')
AddEventHandler('jim-mining:CrackStart', function ()
	QBCore.Functions.TriggerCallback("QBCore:HasItem", function(item) 
		if item then 
			local pos = GetEntityCoords(GetPlayerPed(-1))
			loadAnimDict('amb@prop_human_parking_meter@male@idle_a')
			TaskPlayAnim(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a' , 3.0, 3.0, -1, 1, 0, false, false, false)
			QBCore.Functions.Progressbar("open_locker_drill", "Murrab kivi...", math.random(10000,15000), false, true, {
				disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
				StopAnimTask(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
				TriggerServerEvent('jim-mining:CrackReward')
				IsDrilling = false
			end, function() -- Cancel
				StopAnimTask(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
				IsDrilling = false
			end)
		else 
			TriggerEvent('QBCore:Notify', "Sul ei ole kivi", 'error')
		end 
	end, "stone")
end)

-- Cut Command / Animations
-- Requires a drill
RegisterNetEvent('jim-mining:Cutting:Begin')
AddEventHandler('jim-mining:Cutting:Begin', function (data)
	QBCore.Functions.TriggerCallback("jim-mining:Cutting:Check:Tools",function(hasTools)
		if hasTools then
			QBCore.Functions.TriggerCallback("jim-mining:Cutting:Check:"..data,function(hasReq) 
				if hasReq then 
					local pos = GetEntityCoords(GetPlayerPed(-1))
					loadAnimDict('amb@prop_human_parking_meter@male@idle_a')
					TaskPlayAnim(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a' , 3.0, 3.0, -1, 1, 0, false, false, false)
					QBCore.Functions.Progressbar("open_locker_drill", "L??ikab...", math.random(10000,15000), false, true, {
						disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
						StopAnimTask(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
							TriggerServerEvent('jim-mining:Cutting:Reward', data)
							IsDrilling = false
							if data >= 1 and data <= 4 then TriggerEvent('jim-mining:JewelCut:Gem')
							elseif data >= 5 and data <= 9 then TriggerEvent('jim-mining:JewelCut:Ring')
							elseif data >= 10 and data <= 15 then TriggerEvent('jim-mining:JewelCut:Necklace') end
					end, function() -- Cancel
						StopAnimTask(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
						IsDrilling = false
						if data >= 1 and data <= 4 then TriggerEvent('jim-mining:JewelCut:Gem')
						elseif data >= 5 and data <= 9 then TriggerEvent('jim-mining:JewelCut:Ring')
						elseif data >= 10 and data <= 15 then TriggerEvent('jim-mining:JewelCut:Necklace') end
					end)
				else
					TriggerEvent('QBCore:Notify', "Sul ei ole k??iki koostisosi!", 'error')
					if data >= 1 and data <= 4 then TriggerEvent('jim-mining:JewelCut:Gem')
					elseif data >= 5 and data <= 9 then TriggerEvent('jim-mining:JewelCut:Ring')
					elseif data >= 10 and data <= 15 then TriggerEvent('jim-mining:JewelCut:Necklace') end
				end
			end)
		else
			TriggerEvent('QBCore:Notify', "Sul ei ole k??sipuuri v??i puuriotsikut", 'error')
			if data >= 1 and data <= 4 then TriggerEvent('jim-mining:JewelCut:Gem')
			elseif data >= 5 and data <= 9 then TriggerEvent('jim-mining:JewelCut:Ring')
			elseif data >= 10 and data <= 15 then TriggerEvent('jim-mining:JewelCut:Necklace') end
		end
	end)
end)

-- I'm proud of this whole trigger command here
-- I was worried I'd have to do loads of call backs, back and forths in the this command
-- I had a theory that (like with notifications) I'd be able to add in a dynamic variable with the trigger being called
-- IT WORKED, and here we have it calling a item check callback vite the ID it recieves from the menu buttons

-- Smelt Command / Animations
RegisterNetEvent('jim-mining:Smelting:Begin')
AddEventHandler('jim-mining:Smelting:Begin', function (data)
	QBCore.Functions.TriggerCallback("jim-mining:Smelting:Check:"..data,function(hasReq) 
		if hasReq then 
			local pos = GetEntityCoords(GetPlayerPed(-1))
			loadAnimDict('amb@prop_human_parking_meter@male@idle_a')
			TaskPlayAnim(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a' , 3.0, 3.0, -1, 1, 0, false, false, false)
			QBCore.Functions.Progressbar("open_locker_drill", "Sulatab...", math.random(5000,8000), false, true, {
				disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
				StopAnimTask(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
	
					TriggerServerEvent('jim-mining:Smelting:Reward', data) -- When animations finished this is called and does the correct reward command via the ID it received from the menu
					TriggerEvent('jim-mining:SmeltMenu')
					IsDrilling = false
			end, function() -- Cancel
				StopAnimTask(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
				IsDrilling = false
			end)
		else
			TriggerEvent('jim-mining:SmeltMenu')
			TriggerEvent('QBCore:Notify', "Sul ei ole k??iki koostisosi", 'error')
		end
	end)
end)


------------------------------------------------------------
--These also lead to the actual selling commands

--Selling animations are simply a pass item to seller animation
--Sell Ore Animation
--Sell Anim small Test
RegisterNetEvent('jim-mining:SellAnim')
AddEventHandler('jim-mining:SellAnim', function(data)
	if data == -2 then
		exports['qb-menu']:closeMenu()
		return
	end
	local pid = PlayerPedId()
	loadAnimDict("mp_common")
	TriggerServerEvent('jim-mining:Selling', data) -- Had to slip in the sell command during the animation command
	for k,v in pairs (shopPeds) do
        pCoords = GetEntityCoords(PlayerPedId())
        ppCoords = GetEntityCoords(v)
        dist = #(pCoords - ppCoords)
        if dist < 2 then 
			TaskPlayAnim(pid, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            TaskPlayAnim(v, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            Wait(1500)
            StopAnimTask(pid, "mp_common", "givetake2_a", 1.0)
            StopAnimTask(v, "mp_common", "givetake2_a", 1.0)
            RemoveAnimDict("mp_common")
			break
		end
	end
	TriggerEvent('jim-mining:SellOre')
end)


--Sell Anim small Test
RegisterNetEvent('jim-mining:SellAnim:Jewel')
AddEventHandler('jim-mining:SellAnim:Jewel', function(data)
	if data == -2 then
		exports['qb-menu']:closeMenu()
		return
	end	
	local pid = PlayerPedId()
	loadAnimDict("mp_common")
	TriggerServerEvent('jim-mining:SellJewel', data) -- Had to slip in the sell command during the animation command
	for k,v in pairs (shopPeds) do
        pCoords = GetEntityCoords(PlayerPedId())
        ppCoords = GetEntityCoords(v)
        dist = #(pCoords - ppCoords)
        if dist < 2 then 
			TaskPlayAnim(pid, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            TaskPlayAnim(v, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            Wait(1500)
            StopAnimTask(pid, "mp_common", "givetake2_a", 1.0)
            StopAnimTask(v, "mp_common", "givetake2_a", 1.0)
            RemoveAnimDict("mp_common")

			break
		end
	end	
	if string.find(data, "ring") then TriggerEvent('jim-mining:JewelSell:Rings')
	elseif string.find(data, "chain") or string.find(data, "necklace") then TriggerEvent('jim-mining:JewelSell:Necklace')
	elseif string.find(data, "emerald") then TriggerEvent('jim-mining:JewelSell:Emerald')
	elseif string.find(data, "ruby") then TriggerEvent('jim-mining:JewelSell:Ruby')
	elseif string.find(data, "diamond") then TriggerEvent('jim-mining:JewelSell:Diamond')
	elseif string.find(data, "sapphire") then TriggerEvent('jim-mining:JewelSell:Sapphire') end
end)


------------------------------------------------------------
--Context Menus
--Selling Ore
RegisterNetEvent('jim-mining:SellOre', function()
	exports['qb-menu']:openMenu({
		{ header = "Maagi M????mine", txt = "M???? ??leliigset maaki", isMenuHeader = true },
		{ header = "Vasemaak", txt = "M???? $"..Config.SellItems['copperore'].." t??kk", params = { event = "jim-mining:SellAnim", args = 'copperore' } },
		{ header = "Rauamaak", txt = "M???? $"..Config.SellItems['ironore'].." t??kk", params = { event = "jim-mining:SellAnim", args = 'ironore' } },
		{ header = "Kullamaak", txt = "M???? $"..Config.SellItems['goldore'].." t??kk", params = { event = "jim-mining:SellAnim", args = 'goldore' } },
		{ header = "S??sinik", txt = "M???? $"..Config.SellItems['carbon'].." t??kk", params = { event = "jim-mining:SellAnim", args = 'carbon' } }, 
		{ header = "", txt = "??? Sulge", params = { event = "jim-mining:SellAnim", args = -2 } },
	})
end)
------------------------
--Jewel Selling Main Menu
RegisterNetEvent('jim-mining:JewelSell', function()
    exports['qb-menu']:openMenu({
		{ header = "Juveeli M????gimees", txt = "M???? oma juveele siin", isMenuHeader = true }, 
		{ header = "Smaragdid", txt = "Smaragdi m????gi valikud", params = { event = "jim-mining:JewelSell:Emerald", } },
		{ header = "Rubiinid", txt = "Rubiini m????gi valikud", params = { event = "jim-mining:JewelSell:Ruby", } },
		{ header = "Teemantid", txt = "Teemanti m????gi valikud", params = { event = "jim-mining:JewelSell:Diamond", } },
		{ header = "Safiirid", txt = "Safiiri m????gi valikud", params = { event = "jim-mining:JewelSell:Sapphire", } },
		{ header = "S??rmused", txt = "S??rmuse m????gi valikud", params = { event = "jim-mining:JewelSell:Rings", } },
		{ header = "Kaelaehted", txt = "Kaelaehte m????gi valikud", params = { event = "jim-mining:JewelSell:Necklace", } },
		{ header = "", txt = "??? Sulge", params = { event = "jim-mining:SellAnim:Jewel", args = -2 } },
	})
end)
--Jewel Selling - Emerald Menu
RegisterNetEvent('jim-mining:JewelSell:Emerald', function()
    exports['qb-menu']:openMenu({
		{ header = "Juveeli M????gimees", txt = "M???? oma juveele siin", isMenuHeader = true }, 
		{ header = "Smaragd", txt = "M???? $"..Config.SellItems['emerald'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'emerald' } },
		{ header = "L??ikamata Smaragd", txt = "M???? $"..Config.SellItems['uncut_emerald'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'uncut_emerald' } }, 
		{ header = "", txt = "??? Tagasi", params = { event = "jim-mining:JewelSell", } },
	})
end)
--Jewel Selling - Ruby Menu
RegisterNetEvent('jim-mining:JewelSell:Ruby', function()
    exports['qb-menu']:openMenu({
		{ header = "Juveeli M????gimees", txt = "M???? oma juveele siin", isMenuHeader = true }, 
		{ header = "Rubiin", txt = "M???? $"..Config.SellItems['ruby'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'ruby' } },
		{ header = "L??ikamata Rubiin", txt = "M???? $"..Config.SellItems['uncut_ruby'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'uncut_ruby' } },
		{ header = "", txt = "??? Tagasi", params = { event = "jim-mining:JewelSell", } },
	})
end)
--Jewel Selling - Diamonds Menu
RegisterNetEvent('jim-mining:JewelSell:Diamond', function()
    exports['qb-menu']:openMenu({
		{ header = "Juveeli M????gimees", txt = "M???? oma juveele siin", isMenuHeader = true }, 
		{ header = "Teemant", txt = "M???? $"..Config.SellItems['diamond'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'diamond' } },
		{ header = "L??ikamata Teemant", txt = "M???? $"..Config.SellItems['uncut_diamond'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'uncut_diamond' } },
		{ header = "", txt = "??? Tagasi", params = { event = "jim-mining:JewelSell", } },
	})
end)
--Jewel Selling - Sapphire Menu
RegisterNetEvent('jim-mining:JewelSell:Sapphire', function()
    exports['qb-menu']:openMenu({
		{ header = "Juveeli M????gimees", txt = "M???? oma juveele siin", isMenuHeader = true }, 
		{ header = "Safiir", txt = "M???? $"..Config.SellItems['sapphire'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'sapphire' } },
		{ header = "L??ikamata Safiir", txt = "M???? $"..Config.SellItems['uncut_sapphire'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'uncut_sapphire' } },
		{ header = "", txt = "??? Tagasi", params = { event = "jim-mining:JewelSell", } },
	})
end)

--Jewel Selling - Jewellry Menu
RegisterNetEvent('jim-mining:JewelSell:Rings', function()
    exports['qb-menu']:openMenu({
		{ header = "Juveeli M????gimees", txt = "M???? oma juveele siin", isMenuHeader = true }, 
		{ header = "Kulds??rmus", txt = "M???? $"..Config.SellItems['gold_ring'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'gold_ring' } },
		{ header = "Teemants??rmus", txt = "M???? $"..Config.SellItems['diamond_ring'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'diamond_ring'} },
		{ header = "Smaragds??rmus", txt = "M???? $"..Config.SellItems['emerald_ring'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'emerald_ring' } },
		{ header = "Rubiins??rmus", txt = "M???? $"..Config.SellItems['ruby_ring'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'ruby_ring' } },	
		{ header = "Safiirs??rmus", txt = "M???? $"..Config.SellItems['sapphire_ring'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'sapphire_ring' } },
		{ header = "", txt = "??? Tagasi", params = { event = "jim-mining:JewelSell", } },
	})
end)
--Jewel Selling - Jewellery Menu
RegisterNetEvent('jim-mining:JewelSell:Necklace', function()
    exports['qb-menu']:openMenu({
		{ header = "Juveeli M????gimees", txt = "M???? oma juveele siin", isMenuHeader = true }, 
		{ header = "Gold Chains",	txt = "M???? $"..Config.SellItems['goldchain'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'goldchain' } },
		{ header = "Gold Chains", txt = "M???? $"..Config.SellItems['10kgoldchain'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = '10kgoldchain' } },
		{ header = "Diamond Necklace", txt = "M???? $"..Config.SellItems['diamond_necklace'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'diamond_necklace' } },
		{ header = "Emerald Necklace", txt = "M???? $"..Config.SellItems['emerald_necklace'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'emerald_necklace' } },
		{ header = "Ruby Necklace", txt = "M???? $"..Config.SellItems['ruby_necklace'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'ruby_necklace' } },	
		{ header = "Sapphire Necklace", txt = "M???? $"..Config.SellItems['sapphire_necklace'].." t??kk", params = { event = "jim-mining:SellAnim:Jewel", args = 'sapphire_necklace' } },
		{ header = "", txt = "??? Return", params = { event = "jim-mining:JewelSell", } },
	})
end)
------------------------

--Smelting
RegisterNetEvent('jim-mining:SmeltMenu', function()
    exports['qb-menu']:openMenu({
	{ header = "Sulatuskoda", txt = "Sulata maak materjaliks", isMenuHeader = true }, 
	{ header = "Sulata Vaske", txt = "Sulata vasemaak 10ks vaseks", params = { event = "jim-mining:Smelting:Begin", args = 1 } },
	{ header = "Sulata Kulda", txt = "Sulata 4 kullamaaki 1 kullakangiks", params = { event = "jim-mining:Smelting:Begin", args = 2 } },
	{ header = "Sulata Rauda", txt = "Sulata rauamaak 10ks rauaks", params = { event = "jim-mining:Smelting:Begin", args = 3 } },
	{ header = "Sulata Terast", txt = "Sulata rauamaaki ja s??siniku teraseks", params = { event = "jim-mining:Smelting:Begin", args = 4 } },
	{ header = "", txt = "??? Sulge", params = { event = "jim-mining:SellAnim", args = -2 } },
	--{ header = "Melt Bottle", txt = "Melt down a glass bottle", params = { event = "jim-mining:Smelting:Begin", args = 5 } },
	--{ header = "Melt Can", txt = "Melt down an empty can", params = { event = "jim-mining:Smelting:Begin", args = 6 } },
	})
end)


------------------------

--Cutting Jewels
RegisterNetEvent('jim-mining:JewelCut', function()
    exports['qb-menu']:openMenu({
	{ header = "Kalliskivi l??ikelaud", txt = "Vaja k??sipuuri ja puuriotsikut", isMenuHeader = true },
	{ header = "Kalliskivid",	txt = "Mine kalliskivi l??ikamise men????sse", params = { event = "jim-mining:JewelCut:Gem", } },
	{ header = "S??rmused", txt = "Mine s??rmuse l??ikamise men????sse", params = { event = "jim-mining:JewelCut:Ring", } },
	{ header = "Kaelaehted", txt = "Mine kaelaehte l??ikamise men????sse", params = { event = "jim-mining:JewelCut:Necklace", } },
	{ header = "", txt = "??? Sulge", params = { event = "jim-mining:SellAnim", args = -2 } },
	})
end)
--Gem Section
RegisterNetEvent('jim-mining:JewelCut:Gem', function()
    exports['qb-menu']:openMenu({
	{ header = "Kalliskivi l??ikelaud", txt = "Vaja k??sipuuri ja puuriotsikut", isMenuHeader = true },
	{ header = "Smaragd", txt = "L??ika, et t??sta hinda", params = { event = "jim-mining:Cutting:Begin", args = 1 } },
	{ header = "Rubiin", txt = "L??ika, et t??sta hinda", params = { event = "jim-mining:Cutting:Begin", args = 2 } },
	{ header = "Teemant", txt = "L??ika, et t??sta hinda", params = { event = "jim-mining:Cutting:Begin", args = 3 } },
	{ header = "Safiir", txt = "L??ika, et t??sta hinda", params = { event = "jim-mining:Cutting:Begin", args = 4 } },
	{ header = "", txt = "??? Tagasi", params = { event = "jim-mining:JewelCut", } },
	})
end)
-- Ring Section
RegisterNetEvent('jim-mining:JewelCut:Ring', function()
    exports['qb-menu']:openMenu({
	{ header = "Kalliskivi l??ikelaud", txt = "Vaja k??sipuuri ja puuriotsikut", isMenuHeader = true },
	{ header = "Kulds??rmus x3", txt = "Vaja 1 Kullakang", params = { event = "jim-mining:Cutting:Begin", args = 5 } },
	{ header = "Teemants??rmus", txt = "Vaja 1 Kulds??rmus & 1 Teemant", params = { event = "jim-mining:Cutting:Begin", args = 6 } },
	{ header = "Smaragds??rmus", txt = "Vaja 1 Kulds??rmus & 1 Smaragd", params = { event = "jim-mining:Cutting:Begin", args = 7 } },
	{ header = "Rubiins??rmus", txt = "Vaja 1 Kulds??rmus & 1 Rubiin", params = { event = "jim-mining:Cutting:Begin", args = 8 } },
	{ header = "Safiirs??rmus", txt = "Vaja 1 Kulds??rmus & 1 Safiir", params = { event = "jim-mining:Cutting:Begin", args = 9 } },
	{ header = "", txt = "??? Tagasi", params = { event = "jim-mining:JewelCut", } },
	})
end)
--Necklace Section
RegisterNetEvent('jim-mining:JewelCut:Necklace', function()
    exports['qb-menu']:openMenu({
	{ header = "Kalliskivi l??ikelaud", txt = "Vaja k??sipuuri ja puuriotsikut", isMenuHeader = true },
	{ header = "Kuldkett x3", txt = "Vaja 1 Kullakang", params = { event = "jim-mining:Cutting:Begin", args = 10 } },
	{ header = "10k Kuldkett x2", txt = "Vaja 1 Kullakang", params = { event = "jim-mining:Cutting:Begin", args = 11 } },
	{ header = "Teemant Kaelakett", txt = "Vaja 1 Kuldkett & 1 Teemant", params = { event = "jim-mining:Cutting:Begin", args = 12 } },
	{ header = "Smaragd Kaelakett", txt = "Vaja 1 Kuldkett & 1 Smaragd", params = { event = "jim-mining:Cutting:Begin", args = 13 } },
	{ header = "Rubiin Kaelakett", txt = "Vaja 1 Kuldkett & 1 Rubiin", params = { event = "jim-mining:Cutting:Begin", args = 14 } },
	{ header = "Safiir Kaelakett", txt = "Vaja 1 Kuldkett & 1 Safiir", params = { event = "jim-mining:Cutting:Begin", args = 15 } }, 
	{ header = "", txt = "??? Tagasi", params = { event = "jim-mining:JewelCut", } },
	})
end)
