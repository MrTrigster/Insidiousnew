Config = {}

Config.AttachedVehicle = nil

Config.Job = 'mechanic'

Config.AuthorizedIds = {
    "insertcitizenidhere",
}

Config.MaxStatusValues = {
    ["engine"] = 1000.0,
    ["body"] = 1000.0,
    ["radiator"] = 100,
    ["axle"] = 100,
    ["brakes"] = 100,
    ["clutch"] = 100,
    ["fuel"] = 100,
}

Config.ValuesLabels = {
    ["engine"] = "Mootor",
    ["body"] = "Kere",
    ["radiator"] = "Radiaator",
    ["axle"] = "Veovõll",
    ["brakes"] = "Pidurid",
    ["clutch"] = "Sidur",
    ["fuel"] = "Kütusepaak",
}

Config.RepairCost = {
    ["body"] = "plastic",
    ["radiator"] = "plastic",
    ["axle"] = "steel",
    ["brakes"] = "iron",
    ["clutch"] = "aluminum",
    ["fuel"] = "plastic",
}

Config.RepairCostAmount = {
    ["engine"] = {
        item = "metalscrap",
        costs = 20,
    },
    ["body"] = {
        item = "plastic",
        costs = 10,
    },
    ["radiator"] = {
        item = "steel",
        costs = 20,
    },
    ["axle"] = {
        item = "aluminum",
        costs = 15,
    },
    ["brakes"] = {
        item = "copper",
        costs = 20,
    },
    ["clutch"] = {
        item = "copper",
        costs = 20,
    },
    ["fuel"] = {
        item = "plastic",
        costs = 30,
    },
}

Config.Businesses = {
    "Mehaanik",
}

Config.Plates = {
    [1] = {
        coords = vector4(147.27, -3045.83, 6.42, 311.5),
        AttachedVehicle = nil,
    },
    [2] = {
        coords = vector4(124.68, -3035.1, 6.42, 270.21),
        AttachedVehicle = nil,
    },
}

Config.Locations = {
    ["exit"] = vector3(140.68, -3029.61, 7.04),
    ["stash"] = vector3(121.92, -3028.53, 7.04),
    ["duty"] = vector3(126.06, -3007.92, 7.04),
    ["vehicle"] = vector4(162.06, -3014.05, 5.96, 269.11),
}

Config.Vehicles = {
    ["flatbed"] = "Flatbed",
    ["towtruck"] = "Towtruck",
}

Config.MinimalMetersForDamage = {
    [1] = {
        min = 8000,
        max = 12000,
        multiplier = {
            min = 1,
            max = 8,
        }
    },
    [2] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 8,
            max = 16,
        }
    },
    [3] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 16,
            max = 24,
        }
    },
}

Config.Damages = {
    ["radiator"] = "Radiaator",
    ["axle"] = "Veovõll",
    ["brakes"] = "Pidurid",
    ["clutch"] = "Sidur",
    ["fuel"] = "Kütusepaak",
}
