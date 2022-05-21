Config = {}
Config.UsingTarget = true -- If you are using qb-target (uses entity zones to target vehicles)
Config.Commission = 0.10 -- Percent that goes to sales person from a full car sale 10%
Config.FinanceCommission = 0.05 -- Percent that goes to sales person from a finance sale 5%
Config.FinanceZone = vector3(-29.53, -1103.67, 26.42) -- Where the finance menu is located
Config.PaymentWarning = 10 -- time in minutes that player has to make payment before repo
Config.PaymentInterval = 24 -- time in hours between payment being due
Config.MinimumDown = 10 -- minimum percentage allowed down
Config.MaximumPayments = 24 -- maximum payments allowed
Config.Shops = {
    ['pdm'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-56.727394104004, -1086.2325439453),
                vector2(-60.612808227539, -1096.7795410156),
                vector2(-58.26834487915, -1100.572265625),
                vector2(-35.927803039551, -1109.0034179688),
                vector2(-34.427627563477, -1108.5111083984),
                vector2(-32.02657699585, -1101.5877685547),
                vector2(-33.342102050781, -1101.0377197266),
                vector2(-31.292987823486, -1095.3717041016)
            },
            ['minZ'] = 25.0,  -- min height of the shop zone
            ['maxZ'] = 28.0  -- max height of the shop zone
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Premium Deluxe Motorsport', -- Blip name
        ['showBlip'] = true,  --- true or false
        ['Categories'] = { -- Categories available to browse
            ['sportsclassics'] = 'Sports Classics',
            ['super'] = 'Super',
            ['sports'] = 'Sports',
            ['sedans'] = 'Sedans',
            ['coupes'] = 'Coupes',
            ['suvs'] = 'SUVs',
            ['offroad'] = 'Offroad',
            ['muscle'] = 'Muscle',
            ['compacts'] = 'Compacts',
            ['motorcycles'] = 'Motorcycles',
            ['vans'] = 'Vans',
            ['cycles'] = 'Bicycles'
        },
        ['TestDriveTimeLimit'] = 0.1, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-45.67, -1098.34, 26.42), -- Blip Location
        ['ReturnLocation'] = vector3(-44.74, -1082.58, 26.68), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-56.79, -1109.85, 26.43, 71.5), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-45.65, -1093.66, 25.44, 69.5), -- where the vehicle will spawn on display
                defaultVehicle = 'sultan', -- Default display vehicle
                chosenVehicle = 'sultan', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-48.27, -1101.86, 25.44, 294.5),
                defaultVehicle = 'schafter2',
                chosenVehicle = 'schafter2',
            },
            [3] = {
                coords = vector4(-39.6, -1096.01, 25.44, 66.5),
                defaultVehicle = 'comet2',
                chosenVehicle = 'comet2',
            },
            [4] = {
                coords = vector4(-51.21, -1096.77, 25.44, 254.5),
                defaultVehicle = 'vigero',
                chosenVehicle = 'vigero',
            },
            [5] = {
                coords = vector4(-40.18, -1104.13, 25.44, 338.5),
                defaultVehicle = 'bison',
                chosenVehicle = 'bison',
            },
            [6] = {
                coords = vector4(-43.31, -1099.02, 25.44, 52.5),
                defaultVehicle = 'bati',
                chosenVehicle = 'bati',
            },
            [7] = {
                coords = vector4(-50.66, -1093.05, 25.44, 222.5),
                defaultVehicle = 'bati',
                chosenVehicle = 'bati',
            },
            [8] = {
                coords = vector4(-44.28, -1102.47, 25.44, 298.5),
                defaultVehicle = 'bati',
                chosenVehicle = 'bati',
            }
        },
    },
    ['import'] = {
        ['Type'] = 'managed',
        ['Zone'] = {
            ['Shape'] = {
                vector2(-1266.04, -375.23),
                vector2(-1272.94, -362.49),
                vector2(-1273.51, -359.49),
                vector2(-1272.6, -356.69),
                vector2(-1270.31, -354.65),
                vector2(-1252.95, -345.84),
                vector2(-1244.37, -362.7)
            },
            ['minZ'] = 35.92,
            ['maxZ'] = 38.92
        },
        ['Job'] = 'import',
        ['ShopLabel'] = 'Import Autopood',
        ['showBlip'] = true,
        ['Categories'] = {
            ['super'] = 'Super',
            ['sports'] = 'Sports',
            ['sedans'] = 'Sedans',
            ['suvs'] = 'SUVs',
            ['offroad'] = 'Offroad',
            ['muscle'] = 'Muscle',
        },
        ['TestDriveTimeLimit'] = 0.1,
        ['Location'] = vector3(-1257.66, -360.6, 36.91),
        ['ReturnLocation'] = vector3(-1231.46, -349.86, 37.33),
        ['VehicleSpawn'] = vector4(-1240.12, -354.19, 37.33, 342.68),
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-1265.23, -354.63, 36.29 - 0.43, 206.63),
                defaultVehicle = 't20',
                chosenVehicle = 't20',
            },
            [2] = {
                coords = vector4(-1269.64, -358.72, 36.29 - 0.40, 248.96),
                defaultVehicle = 'nero',
                chosenVehicle = 'nero',
            },
            [3] = {
                coords = vector4(-1268.89, -364.81, 36.29 - 0.40, 297.74),
                defaultVehicle = 'seven70',
                chosenVehicle = 'seven70',
            },
            [4] = {
                coords = vector4(-1260.08, -362.65, 36.29 - 0.40, 346.29),
                defaultVehicle = 'penetrator',
                chosenVehicle = 'penetrator',
            },
        }
    },
    ['pdshop'] = {
        ['Type'] = 'free-use',
        ['Zone'] = {
            ['Shape'] = {
                vector2(951.59, -3002.2),
                vector2(981.21, -3002.18),
                vector2(981.24, -3013.45),
                vector2(951.74, -3013.4),
            },
            ['minZ'] = -48.55,
            ['maxZ'] = -46.55
        },
        ['Job'] = 'police',
        ['ShopLabel'] = 'Politsei HSU',
        ['showBlip'] = false,
        ['Categories'] = {
            ['super'] = 'Super',
            ['sports'] = 'Sports',
            ['muscle'] = 'Muscle',
        },
        ['TestDriveTimeLimit'] = 0.1,
        ['Location'] = vector4(855.13, -1280.63, 26.51, 3.87),
        ['ReturnLocation'] = vector4(855.13, -1280.63, 26.51, 3.87),
        ['VehicleSpawn'] = vector4(855.13, -1280.63, 26.51, 3.87),
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(954.71, -3006.44, -48.72, 0.7),
                defaultVehicle = '18mustangum',
                chosenVehicle = '18mustangum',
            },
            [2] = {
                coords = vector4(962.71, -3007.04, -48.82, 359.75),
                defaultVehicle = 'poldemonrb',
                chosenVehicle = 'poldemonrb',
            },
            [3] = {
                coords = vector4(970.36, -3006.57, -48.82, 0.13),
                defaultVehicle = 'mach1bb',
                chosenVehicle = 'mach1bb',
            },
            [4] = {
                coords = vector4(978.21, -3006.72, -48.72, 0.3),
                defaultVehicle = '18mustangum',
                chosenVehicle = '18mustangum',
            },
        }
    }
}
