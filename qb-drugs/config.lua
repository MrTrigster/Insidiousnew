Config = Config or {}
Config.MinimumDrugSalePolice = 1

Config.Products = {
    [1] = {
        name = "weed_white-widow",
        price = 175,
        amount = 300,
        info = {},
        type = "item",
        slot = 1,
        minrep = 0,
    },
    [2] = {
        name = "weed_skunk",
        price = 175,
        amount = 300,
        info = {},
        type = "item",
        slot = 2,
        minrep = 8,
    },
    [3] = {
        name = "weed_purple-haze",
        price = 175,
        amount = 300,
        info = {},
        type = "item",
        slot = 3,
        minrep = 16,
    },
    [4] = {
        name = "weed_og-kush",
        price = 175,
        amount = 300,
        info = {},
        type = "item",
        slot = 4,
        minrep = 24,
    },
    [5] = {
        name = "weed_amnesia",
        price = 175,
        amount = 300,
        info = {},
        type = "item",
        slot = 5,
        minrep = 32,
    },
    [6] = {
        name = "weed_white-widow_seed",
        price = 5000,
        amount = 5,
        info = {},
        type = "item",
        slot = 6,
        minrep = 70,
    },
    [7] = {
        name = "weed_skunk_seed",
        price = 5000,
        amount = 5,
        info = {},
        type = "item",
        slot = 7,
        minrep = 75,
    },
    [8] = {
        name = "weed_purple-haze_seed",
        price = 5000,
        amount = 5,
        info = {},
        type = "item",
        slot = 8,
        minrep = 80,
    },
    [9] = {
        name = "weed_og-kush_seed",
        price = 5000,
        amount = 5,
        info = {},
        type = "item",
        slot = 9,
        minrep = 85,
    },
    [10] = {
        name = "weed_amnesia_seed",
        price = 5000,
        amount = 5,
        info = {},
        type = "item",
        slot = 10,
        minrep = 90,
    },
}

Config.Dealers = {}

Config.CornerSellingDrugsList = {
    "weed_white-widow",
    "weed_skunk",
    "weed_purple-haze",
    "weed_og-kush",
    "weed_amnesia",
    "weed_ak47",
    "cokebaggy",
    "cokebaggy_10g",
    "meth",
    "puremeth"
}

Config.DrugsPrice = {
    ["weed_white-widow"] = {
        min = 15,
        max = 25,
    },
    ["weed_og-kush"] = {
        min = 12,
        max = 23,
    },
    ["weed_skunk"] = {
        min = 5,
        max = 12,
    },
    ["weed_amnesia"] = {
        min = 17,
        max = 28,
    },
    ["weed_purple-haze"] = {
        min = 20,
        max = 30,
    },
    ["weed_ak47"] = {
        min = 10,
        max = 20,
    },
    ["cokebaggy"] = {
        min = 20,
        max = 50,
    },
    ["cokebaggy_10g"] = {
        min = 200,
        max = 500,
    },
    ["meth"] = {
        min = 25,
        max = 40,
    },
    ["puremeth"] = {
        min = 35,
        max = 55,
    },
}

Config.DeliveryLocations = {
    [1] = {
        ["label"] = "Stripclub",
        ["coords"] = vector3(106.24, -1280.32, 29.24),
    },
    [2] = {
        ["label"] = "Vinewood Video",
	    ["coords"] = vector3(223.98, 121.53, 102.76),
    },
    [3] = {
        ["label"] = "Taxi",
	    ["coords"] = vector3(882.67, -160.26, 77.11),
    },
    [4] = {
        ["label"] = "Resort",
	    ["coords"] = vector3(-1245.63, 376.21, 75.34),
    },
    [5] = {
        ["label"] = "Bahama Mamas",
	    ["coords"] = vector3(-1383.1, -639.99, 28.67),
    },
    [6] = {
        ["label"] = "Casey's Diner",
	    ["coords"] = vector3(802.12, -756.47, 26.81),
    },
    [7] = {
        ["label"] = "Cabinets & Carpets",
	    ["coords"] = vector3(224.42, -1872.0, 26.87),
    },
    [8] = {
        ["label"] = "Liquor Apartment",
	    ["coords"] = vector3(-1585.79, -464.51, 37.27),
    },
}

Config.CornerSellingZones = {
    [1] = {
	["coords"] = vector3(-1415.53, -1041.51, 4.62),
        ["time"] = {
            ["min"] = 12,
            ["max"] = 18,
        },
    },
}

Config.DeliveryItems = {
    [1] = {
        ["item"] = "weed_brick",
        ["minrep"] = 0,
    },
    [2] = {
        ["item"] = "coke_small_brick",
        ["minrep"] = 10,
    },
    [3] = {
        ["item"] = "coke_brick",
        ["minrep"] = 30,
    },
}
