Config = {}

Config.Jobs = {
    ["electrician"] = "Elektrik",
}

Config.Locations = {
    jobs = {
        ["electrician"] = {
            [1] = {
                coords = vector4(1761.46, 2540.41, 45.56, 272.249),
            },
            [2] = {
                coords = vector4(1718.54, 2527.802, 45.56, 272.249),
            },
            [3] = {
                coords = vector4(1700.199, 2474.811, 45.56, 272.249),
            },
            [4] = {
                coords = vector4(1664.827, 2501.58, 45.56, 272.249),
            },
            [5] = {
                coords = vector4(1621.622, 2509.302, 45.56, 272.249),
            },
            [6] = {
                coords = vector4(1627.936, 2538.393, 45.56, 272.249),
            },
            [7] = {
                coords = vector4(1625.1, 2575.988, 45.56, 272.249),
            },
        },
    },
    ["freedom"] = {
        coords = vector4(1775.59, 2476.91, 45.85, 212.31),
    },
    ["outside"] = {
        coords = vector4(1848.04, 2586.06, 45.67, 269.39),
    },
    ["yard"] = {
        coords = vector4(1757.86, 2488.68, 45.84, 260.24),
    },
    ["middle"] = {
        coords = vector4(1689.0, 2596.51, 45.56, 35.18),
    },
    ["shop"] = {
        coords = vector4(1763.01, 2474.71, 45.85, 17.72),
    },
    spawns = {
        [1] = {
            animation = "pushup",
            coords = vector4(1764.01, 2496.28, 45.85, 193.35),
        },
        [2] = {
            animation = "situp",
            coords = vector4(1769.85, 2488.11, 49.24, 29.53),
        },      
    }
}

Config.CanteenItems = {
    [1] = {
        name = "sandwich",
        price = 15,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "water_bottle",
        price = 20,
        amount = 50,
        info = {},
        type = "item",
        slot = 2,
    },
}
