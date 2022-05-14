Config = Config or {}

Config.UseBlips = true                                 -- True / false option for toggling farm blips

Config.PedModel = "a_m_m_farmer_01"                    -- Ped model  https://wiki.rage.mp/index.php?title=Peds
Config.PedHash = 0x94562DD7                            -- Hash numbers for ped model

-- Blips
FoodProcessor = {
    targetZone = vector3(1677.93, 4881.78, 41.04),      -- qb-target vector
    targetHeading = 42.46,                                  -- qb-target box zone
    coords = vector4(1677.93, 4881.78, 41.04, 42.46),   -- Move Location (Ped and blip)
    SetBlipSprite = 568,                                -- Blip Icon (https://docs.fivem.net/docs/game-references/blips/)
    SetBlipDisplay = 6,                                 -- Blip Behavior (https://docs.fivem.net/natives/?_0x9029B2F3DA924928)
    SetBlipScale = 0.7,                                -- Blip Size
    SetBlipColour = 35,                                 -- Blip Color
    BlipLabel = "Toidu Protsessimine",                       -- Blip Label
    minZ = 41.04,                                       -- qb-target Min
    maxZ = 43.04,                                       -- qb-target Max
}
DairyProcessor = {
    targetZone = vector3(2567.92, 4684.44, 33.05),
    targetHeading = 330,
    coords = vector4(2567.92, 4684.44, 33.05, 47.10),
    SetBlipSprite = 568,
    SetBlipDisplay = 6,
    SetBlipScale = 0.7,
    SetBlipColour = 32,
    BlipLabel = "Piimatoodete Protsessimine",
    minZ = 32.05,
    maxZ = 35.00,
}
Seller = {
    targetZone = vector3(760.4, -3194.97, 6.07),
    targetHeading = 265.82,
    coords = vector4(760.4, -3194.97, 6.07 - 1.00, 265.82),
    SetBlipSprite = 642,
    SetBlipDisplay = 6,
    SetBlipScale = 0.8,
    SetBlipColour = 81,
    BlipLabel = "Toorainete Kokkuost",
    minZ = 4,
    maxZ = 7,
}
MeatSeller = {
    targetZone = vector3(-1199.3, -905.43, 13.43),
    targetHeading = 124.71,
    coords = vector4(-1199.3, -905.43, 12.43, 124.71),
    SetBlipSprite = 642,
    SetBlipDisplay = 6,
    SetBlipScale = 0.8,
    SetBlipColour = 81,
    BlipLabel = "Liha Kokkuost",
    minZ = 12.43,
    maxZ = 15.43,
}

-- Pig Farm (Food)

Config.PigFood = 5                                      -- Food Amount (Pig Food)
Config.FoodPrice = 5                                    --  Pig Farm Food Price
PigFarmer = vector4(2166.11, 5003.84, 40.39, 312.56)    -- Ped Location
PigFarmerTargetZone = vector3(2166.11, 5003.84, 40.39)  -- QB-Target location
PigFarmerTzHeading = 305                                -- QB-Target Heading
PigFarmerMinZ = 40				                    	-- QB-Target MinZ
PigFarmerMaxZ = 42				                    	-- QB-Target MaxZ

-- Processing Items
Config.AppleProcessing = 3                              -- Trading Amount
Config.BeefProcessing = 2
Config.BaconProcesing = 3
Config.HamProcessing = 2
Config.PorkProcessing = 1
Config.SausageProcessing = 2
Config.MilkProcessing = 2
Config.PumpkinProcessing = 1
Config.CornProcessing = 2
Config.GrapeProcessing = 3
Config.ChillyProcessing = 3
Config.TomatoesProcessing = 4

-- Processed Items
Config.AppleJuice = 1                                   -- Received Amount
Config.BaconProcessed = 3
Config.HamProcessed = 2
Config.PorkProcessed = 1
Config.SausageProcessed = 2
Config.CowMeat = 2
Config.Milk = 4
Config.PumpkinBoxes = 3
Config.CornProcessed = 1
Config.GrapeProcessed = 1
Config.ChillyProcessed = 1
Config.TomatoesProcessed = 1

-- Processing time
Config.ProcessingTime = {
    ["apple_processingtime"] = 5000,                    -- MS = Seconds (5000 ms = 5 seconds)
    ["beef_processingtime"] = 10000,
    ["bacon_processingtime"] = 10000,
    ["ham_processingtime"] = 10000,
    ["pork_processingtime"] = 10000,
    ["sausage_processingtime"] = 10000,
    ["milk_tradingtime"] = 7500,
    ["pumpkin_smashingtime"] = 7500,
    ["grape_processingtime"] = 7500,
    ["chillypepper_processingtime"] = 7500,
    ["tomatoes_processingtime"] = 7500,
}


-- Sell Items
Config.Sell = {
    ["apple"] = {
        ["price"] = math.random(1, 5)                  -- Seller Price
    },
    ["apple_juice"] = {
        ["price"] = math.random(5, 10)
    },
    ["milkbucket"] = {
        ["price"] = math.random(3, 8)
    },
    ["milk"] = {
        ["price"] = math.random(3, 9)
    },
    ["rawpumpkin"] = {
        ["price"] = math.random(4, 9)
    },
    ["pumpkinpiebox"] = {
        ["price"] = math.random(5, 10)
    },
    ["slicedpie"] = {
        ["price"] = math.random(4, 8)
    },
    ["corncob"] = {
        ["price"] = math.random(1, 5)
    },
    ["canofcorn"] = {
        ["price"] = math.random(5, 10)
    },
    ["grapes"] = {
        ["price"] = math.random(1, 5)
    },
    ["grapejuice"] = {
        ["price"] = math.random(5, 10)
    },
    ["greenpepper"] = {
        ["price"] = math.random(1, 5)
    },
    ["chillypepper"] = {
        ["price"] = math.random(1, 5)
    },
    ["hotsauce"] = {
        ["price"] = math.random(5, 15)
    },
    ["tomato"] = {
        ["price"] = math.random(1, 5)
    },
    ["tomatoepaste"] = {
        ["price"] = math.random(5, 10)
    },
    ["pig_leather"] = {
        ["price"] = math.random(10, 18)
    },
    ["cow_leather"] = {
        ["price"] = math.random(10, 20)
    }
}

Config.SellMeat = {
    ["raw_bacon"] = {
        ["price"] = math.random(5, 10)
    },
    ["raw_sausage"] = {
        ["price"] = math.random(5, 10)
    },
    ["raw_pork"] = {
        ["price"] = math.random(5, 10)
    },
    ["raw_ham"] = {
        ["price"] = math.random(5, 10)
    },
    ["cooked_bacon"] = {
        ["price"] = math.random(5, 10)
    },
    ["cooked_sausage"] = {
        ["price"] = math.random(5, 10)
    },
    ["cooked_pork"] = {
        ["price"] = math.random(5, 10)
    },
    ["cooked_ham"] = {
        ["price"] = math.random(5, 10)
    },
    ["raw_beef"] = {
        ["price"] = math.random(5, 10)
    },
    ["beef"] = {
        ["price"] = math.random(5, 10)
    },
}

-- Alert Notification
Config.Alerts = {
    ['cancel'] = 'Katkestatud',
    ['weapon'] = 'Sul ei ole nuga selleks',
    ['itemamount'] = 'Sul ei ole selleks piisavalt toorainet',

    ['apple_pickingbar'] = 'Korjab õunu...',
    ['apple_progressbar'] = 'Teeb mahla...',
	['apple_pickingfront'] = 'Korjasid ',
    ['apple_pickingend'] = ' õuna puu otsast',
    ['apple_processing'] = 'Sa töötled ' ..Config.AppleProcessing.. ' õuna',
    ['apple_trader'] = 'Said ' ..Config.AppleJuice.. ' õunamahla',
    ['error_appleprocessor'] = 'Sul ei ole piisavalt õunasid',

    ['cow_milking'] = 'Lüpsib lehma...',
    ['emptybucket'] = 'Sul ei ole tühja ämbrit',
    ['killing_cow'] = 'Hukkab lehma...',
    ['error_rawmeat'] = 'Sul ei ole piisavalt toorest liha',
    ['cow_processbar'] = 'Praeb veiseliha...',
    ['cow_processing'] = 'Sa praadisid ' ..Config.BeefProcessing.. ' veiseliha',
    ['cow_diaryprocessorbar'] = 'Töötleb piima...',
    ['milk_processing'] = 'Sa töötled ' ..Config.MilkProcessing.. ' ämbrit piima',
    ['milk_trader'] = 'Said ' ..Config.Milk.. ' pudelit piima',
    ['error_milkprocessor'] = 'Sul ei ole piimaämbreid',
    ['error_milklocation'] = 'Lüpsi laudas lehmi ja tule tagasi',

    ['picking_pumpkins'] = 'Korjab kõrvitsat...',
    ['pumpkin_processingbar'] = 'Lõhub kõrvitsat...',
    ['pumpkin_processing'] = 'Lõhkusid ' ..Config.PumpkinProcessing.. ' kõrvitsat',
    ['pumpkin_trader'] = 'Tegid ' ..Config.PumpkinBoxes.. ' kõrvitsapirukat',
    ['error_pumpkinsmashing'] = 'Sul ei ole kõrvitsat',

    ['corn_picking'] = 'Korjab maisi...',
    ['corn_progressbar'] = 'Töötleb maisi...',
    ['corn_processing'] = 'Eemaldasid ' ..Config.CornProcessing.. ' maisi',
    ['corn_processed'] = 'Tegid ' ..Config.CornProcessed.. ' purki maisi',
    ['error_corncob'] = 'Sul ei ole piisavalt maisi',

    ['grape_picking'] = 'Korjab viinamarju...',
    ['grape_progressbar'] = 'Kurnab viinamarju...',
    ['grape_processing'] = 'Kurnasid ' ..Config.GrapeProcessing.. ' viinamarja',
    ['grape_processed'] = 'Tegid ' ..Config.GrapeProcessed.. ' pudelit viinamarjamahla',
    ['error_grape'] = 'Sul ei ole piisavalt viinamarju',

    ['greenpepper_picking'] = "Korjab paprikat...",

    ['chillypepper_picking'] = 'Korjab tšillipipraid...',
    ['chilly_hotsauce'] = 'Teeb tšillikastet...',
    ['chilly_processing'] = 'Töötlesid ' ..Config.ChillyProcessing.. ' tšillipipart',
    ['chilly_processed'] = 'Tegid ' ..Config.ChillyProcessed.. ' pudelit tšillikastet',
    ['error_chilly'] = 'Sul ei ole piisavalt tšillipipraid',

    ['tomatoes_picking'] = 'Korjab tomateid...',
    ['tomatoes_progressbar'] = 'Töötleb tomateid...',
    ['tomatoes_processing'] = 'Töötlesid ' ..Config.TomatoesProcessing.. ' tomatit',
    ['tomatoes_processed'] = 'Tegid ' ..Config.TomatoesProcessed.. ' purki tomatikastet',
    ['error_tomatoes'] = 'Sul ei ole piisavalt tomateid',


    ['bacon_progressbar'] = 'Praeb peekonit...',
    ['bacon_processing'] = 'Praadisid ' ..Config.BaconProcessed.. 'tk peekonit',
    ['error_bacon'] = 'Sul ei ole peekonit',

    ['ham_progressbar'] = 'Praeb sinki...',
    ['ham_processing'] = 'Praadisid ' ..Config.HamProcessed.. ' viilu sinki',
    ['error_ham'] = 'Sul ei ole sinki',

    ['pork_progressbar'] = 'Praeb sealiha...',
    ['pork_cooking'] = 'Praadisid ' ..Config.PorkProcessed.. 'tk sealiha',
    ['error_pork'] = 'Sul ei ole sealiha',

    ['sausage_progressbar'] = 'Praeb vorsti...',
    ['sausage_processing'] = 'Praadisid ' ..Config.SausageProcessed.. ' vorsti',
    ['error_sausage'] = 'Sul ei ole vorsti',

    ['killing_pig'] = 'Hukkab siga...',
    ['pig_reward'] = 'Said tooraineid sea hukkamisest',

    ['error.soybean'] = 'Sul ei ole seatoitu',
    ['stress'] = 'Leevendasid stressi',
}