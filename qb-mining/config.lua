Config = {}

Config.Blips = true -- Enable Blips?
Config.BlipNamer = true -- Enable to Name Blips different things, disable if you already have too many blips as this will group them together
Config.PropSpawn = true -- Enable Ore Props
Config.Pedspawn = true -- Do you want to spawn peds for main locations?
Config.Invincible = true --Do you want the peds to be invincible?
Config.Frozen = true --Do you want the peds to be unable to move? It's probably a yes, so leave true in there.
Config.Stoic = true --Do you want the peds to react to what is happening in their surroundings?
Config.Fade = true -- Do you want the peds to fade into/out of existence? It looks better than just *POP* its there.
Config.Distance = 40.0 --The distance you want peds to spawn at

--Blips and Locations
-- Each one has individual blip enablers
-- Mine and Mine Leave have headings for the player locations
Config.Locations =  {
	['Mine'] = { name = "Kaevandus", location = vector3(-595.15,2091.23,131.46-1.03), heading = 61.59, blipTrue = true }, -- The location where you enter the mine 
	['Quarry'] = { name = "Kaevandus", location = vector3(2961.02, 2754.14, 43.71-1.03), heading = 200.0, blipTrue = true }, -- The location where you enter the mine 
	['Smelter'] = {	name = "Sulatuskoda", location = vector3(1112.29, -2009.9, 31.46), blipTrue = true }, -- The location of the smelter
	['Cracking'] = { name = "Kivi Lõhkumine", location = vector3(1109.27,-1992.68,30.99-1.03), heading = 305.0-180.0, blipTrue = true }, -- The location of the smelter
	['Buyer'] = { name = "Maagi Kokkuost", location = vector3(-97.99,-1013.31,27.28-1.0), heading = 178.15, blipTrue = true }, -- The Location of the ore buyer
	['JewelCut'] = { name = "Juveeli Lõikamine", location = vector3(1077.24, -1984.22, 31.0-0.97), heading = 300.0, blipTrue = true }, -- The Location of the jewel cutting bench. Couldn't decide so left in smeltery
	['Buyer2'] = { name = "Juveeli Kokkuost", location = vector3(177.63, -1316.45, 28.35), heading = 231.52, blipTrue = false }, -- The Location of the jewel buyer, I left this as Vangelico, others will proabably change to pawn shops
}

------------------------------------------------------------
--Ores and Props

Config.OrePositions = {
	---MineShaft Locations
	{ coords = vector3(-587.05, 2059.08, 129.75), },
	{ coords = vector3(-588.49, 2048.05, 129.95-1.0), },
	{ coords = vector3(-580.10, 2037.82, 128.8-1.0), },
	{ coords = vector3(-572.28, 2022.37, 127.93-1.0), },
	{ coords = vector3(-562.8, 2011.85, 127.55-1.0), },
	--Quarry Locations
	{ coords = vector3(2980.37, 2748.4, 43.4-1.5), },
	{ coords = vector3(2985.77, 2751.19, 43.46-1.5), },
	{ coords = vector3(2990.38, 2750.4, 43.46-1.5), },
	{ coords = vector3(3000.77, 2754.15, 43.5-1.5), },
	{ coords = vector3(2977.74, 2741.16, 44.54-1.5), },
}

-----------------------------------------------------------

Config.RewardPool = {
	'carbon', 'carbon', 'carbon', 'carbon', 'carbon', --4x
	'copperore', 'copperore', 'copperore', 'copperore', 'copperore', 'copperore', -- 6x
	'goldore', 'goldore', 'goldore', 'goldore', -- 3x
	'ironore', 'ironore', 'ironore', 'ironore', 'ironore', -- 5x
	'uncut_ruby', 'uncut_ruby',
	'uncut_emerald', 'uncut_emerald',
	'uncut_diamond',
	'uncut_sapphire', 'uncut_sapphire',
}

------------------------------------------------------------
Config.SellItems = { -- Selling Prices
	['copperore'] = 10,
	['goldore'] = 50,
	['ironore'] = 20,
	['carbon'] = 25,
	
	['goldbar'] = 60,
	
	['uncut_emerald'] = 60,
	['uncut_ruby'] = 65,
	['uncut_diamond'] = 80,
	['uncut_sapphire'] = 70,

	['emerald'] = 100,
	['ruby'] = 105,
	['diamond'] = 120,
	['sapphire'] = 110,

	['diamond_ring'] = 180,
	['emerald_ring'] = 160,
	['ruby_ring'] = 165,
	['sapphire_ring'] = 170,

	['diamond_necklace'] = 190,
	['emerald_necklace'] = 170,
	['ruby_necklace'] = 175,
	['sapphire_necklace'] = 180,

	['gold_ring'] = 80,
	['goldchain'] = 100,
	['10kgoldchain'] = 120,

}

------------------------------------------------------------

Config.PedList = { -- APPARENTLY You can call config locations IN the config, learn't that one today
	{ model = "S_M_Y_Construct_01", coords = Config.Locations['Mine'].location, heading = Config.Locations['Mine'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", }, -- Outside Mine
	{ model = "S_M_Y_Construct_01", coords = Config.Locations['Quarry'].location, heading = Config.Locations['Quarry'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", }, -- Outside Mine
	{ model = "S_M_Y_Construct_01", coords = Config.Locations['Buyer'].location, heading = Config.Locations['Buyer'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", }, -- Ore Buyer
	{ model = "S_M_M_HighSec_03", coords = Config.Locations['Buyer2'].location, heading = Config.Locations['Buyer2'].heading, gender = "male", scenario = "WORLD_HUMAN_CLIPBOARD", }, -- Jewel Buyer
}

------------------------------------------------------------
--Added mine lighting for my first world NVE problems
--Don't always light up...
Config.MineLights = {
	{ coords = vector3(-594.30, 2082.89, 131.40+1.53), },
	{ coords = vector3(-591.85, 2073.95, 131.35+1.53), },
	{ coords = vector3(-589.98, 2066.16, 131.02+1.53), },
	{ coords = vector3(-587.83, 2052.98, 130.21+1.53), },
	{ coords = vector3(-583.94, 2041.11, 129.11+1.53), },
	{ coords = vector3(-577.49, 2030.93, 128.24+1.53), },
	{ coords = vector3(-567.83, 2020.27, 127.58+1.53), },
}

------------------------------------------------------------
--Mining Store Items
Config.Items = {
    label = "Kaevanduspood",  slots = 4,
    items = {
	[1] = { name = "weapon_flashlight", price = 249, amount = 100, info = {}, type = "item", slot = 1, }, 
	[2] = { name = "drill",	price = 500, amount = 100, info = {}, type = "item", slot = 2, }, 
	[3] = { name = "handdrill",	price = 300, amount = 100, info = {}, type = "item",	slot = 3, },
	[4] = { name = "drillbit", price = 70, amount = 100,	info = {}, type = "item", slot = 4, }, }		
}