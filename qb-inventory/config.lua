Config = {}

Config.VendingObjects = {
    "prop_vend_soda_01",
    "prop_vend_soda_02",
    "prop_vend_water_01"
}

Config.BinObjects = {
    "prop_bin_05a",
}

Config.CraftingObject = `prop_toolchest_05`

Config.VendingItem = {
    [1] = {
        name = "kurkakola",
        price = 40,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "water_bottle",
        price = 50,
        amount = 50,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "twerks_candy",
        price = 35,
        amount = 50,
        info = {},
        type = "item",
        slot = 3,
    },
    [4] = {
        name = "snikkel_candy",
        price = 35,
        amount = 50,
        info = {},
        type = "item",
        slot = 4,
    },
}

Config.CraftingItems = {
    ['location'] = vector3(-165.46, 295.38, 93.76),
    ["items"] = {
        [1] = {
            name = "armor",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 50,
                ["steel"] = 36,
                ["plastic"] = 36,
                ["aluminum"] = 30,
            },
            type = "item",
            slot = 1,
            threshold = 0,
            points = 5,
        },
        [2] = {
            name = "handcuffs",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 40,
                ["steel"] = 40,
                ["aluminum"] = 15,
            },
            type = "item",
            slot = 2,
            threshold = 0,
            points = 5,
        },
        [3] = {
            name = "screwdriver",
            amount = 50,
            info = {},
            costs = {
                ["steel"] = 60,
                ["plastic"] = 40,
            },
            type = "item",
            slot = 3,
            threshold = 50,
            points = 5,
        },
        [4] = {
            name = "gunpowder",
            amount = 50,
            info = {},
            costs = {
                ["pistol_ammo"] = 5,
                ["rifle_ammo"] = 5,
            },
            type = "item",
            slot = 4,
            threshold = 150,
            points = 5,
        },
        [5] = {
            name = "c4",
            amount = 50,
            info = {},
            costs = {
                ["metalscrap"] = 100,
                ["plastic"] = 60,
                ["gunpowder"] = 10,
            },
            type = "item",
            slot = 5,
            threshold = 200,
            points = 0,
        },
    }
}

-- Config.AttachmentCrafting = {
--     ['location'] = vector3(905.99, -3230.79, -98.29),
--     ["items"] = {
--         [1] = {
--             name = "pistol_extendedclip",
--             amount = 50,
--             info = {},
--             costs = {
--                 ["metalscrap"] = 10,
--                 ["steel"] = 12,
--                 ["rubber"] = 3,
--             },
--             type = "item",
--             slot = 1,
--             threshold = 0,
--             points = 2,
--         },
--         [2] = {
--             name = "pistol_suppressor",
--             amount = 50,
--             info = {},
--             costs = {
--                 ["metalscrap"] = 16,
--                 ["steel"] = 18,
--                 ["rubber"] = 4,
--             },
--             type = "item",
--             slot = 2,
--             threshold = 14,
--             points = 4,
--         },
--         [3] = {
--             name = "smg_extendedclip",
--             amount = 50,
--             info = {},
--             costs = {
--                 ["metalscrap"] = 18,
--                 ["steel"] = 20,
--                 ["rubber"] = 8,
--             },
--             type = "item",
--             slot = 3,
--             threshold = 32,
--             points = 8,
--         },
--         [4] = {
--             name = "assaultrifle_extendedclip",
--             amount = 50,
--             info = {},
--             costs = {
--                 ["metalscrap"] = 20,
--                 ["steel"] = 22,
--                 ["rubber"] = 8,
--                 ["smg_extendedclip"] = 1,
--             },
--             type = "item",
--             slot = 4,
--             threshold = 64,
--             points = 10,
--         },
--     }
-- }

Config.GangStashes = {
    -- ["yakuza"] = {
    --     gang = 'yakuza',
    --     location = vector3(-163.75, 306.52, 93.76),
    -- },
    -- ["triad"] = {
    --     gang = 'triad',
    --     location = vector3(494.03, -1534.03, 25.87),
    -- },
    -- ["mafia"] = {
    --     gang = 'mafia',
    --     location = vector3(-85.69, 997.39, 230.61),
    -- },
    -- ["racing"] = {
    --     gang = 'racing',
    --     location = vector3(-1824.94, 4526.98, 5.33),
    -- },
    -- ["racing2"] = {
    --     gang = 'racing',
    --     location = vector3(1402.89, 1136.41, 109.75),
    -- },
    -- ["vagos"] = {
    --     gang = 'vagos',
    --     location = vector3(433.69, -1886.12, 31.74),
    -- },
}

Config.JobStashes = {
    -- ["lawyer"] = {
    --     job = 'lawyer',
    --     location = vector3(-82.28, -801.27, 243.39),
    -- },
}

Config.PersonalStashes = {
    -- ["ruslan"] = {
    --     cid = 'IOW11924',
    --     location = vector3(9.74, 528.56, 170.62),
    -- },
}

MaxInventorySlots = 41

BackEngineVehicles = {
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
    [`comet3`] = true,
    [`gp1`] = true,
    [`autarch`] = true,
    [`tyrant`] = true,
    [`xa21`] = true,
}

Config.MaximumAmmoValues = {
    ["pistol"] = 250,
    ["smg"] = 250,
    ["shotgun"] = 200,
    ["rifle"] = 250,
}

Config.Interval = 5 --how often durability will be removed in minutes

Config.DurabilityAmount = { --how much durability will be removed after the interval
    ["default"]             = 0,    --this is for any item that hasn't been added to this list

    ["sandwich"]            = 6,
    ["tosti"]               = 6,
    ["coffee"]              = 5,
    ["water_bottle"]        = 1,
    ["twerks_candy"]        = 3,
    ["snikkel_candy"]       = 3,
    ["kurkakola"]           = 4,

    ['burger-softdrink']    = 7,
    ['burger-fries']        = 7,
    ['burger-moneyshot']    = 8,
    ['burger-mshake']       = 8,
    ['burger-bleeder']      = 8,
    ['burger-heartstopper'] = 9,
    ['burger-torpedo']      = 8,
    ['burger-meatfree']     = 8,
    ['burger-donut']        = 7,
    ['burger-icecream']     = 7,

	["apple"]               = 10,
	["apple_juice"]         = 3,
	["milkbucket"]          = 6,
	["raw_beef"]            = 9,
	["beef"]                = 2,
	["milk"]                = 5,
	["rawpumpkin"]          = 10,
	["pumpkinpiebox"]       = 3,
	["slicedpie"]           = 7,
	["corncob"]             = 8,
	["canofcorn"]           = 1,
	["grapes"]              = 10,
	["grapejuice"]          = 4,
	["greenpepper"]         = 8,
	["chillypepper"]        = 8,
	["hotsauce"]            = 1,
	["tomato"]              = 9,
	["tomatopaste"]         = 3,
	["soybeans"]            = 5,
	["raw_bacon"]           = 9,
	["raw_sausage"]         = 9,
	["raw_pork"]            = 9,
	["raw_ham"]             = 9,
	["cooked_bacon"]        = 2,
	["cooked_sausage"]      = 2,
	["cooked_pork"]         = 2,
	["cooked_ham"]          = 2,
}