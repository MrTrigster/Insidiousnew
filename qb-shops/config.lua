Config = {}

Config.Products = {
    ['normal'] = {
        [1] = {
            name = 'water_bottle',
            price = 25,
            amount = 250,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'kurkakola',
            price = 20,
            amount = 250,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'twerks_candy',
            price = 20,
            amount = 250,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'snikkel_candy',
            price = 20,
            amount = 250,
            info = {},
            type = 'item',
            slot = 4,
        },
        [5] = {
            name = 'sandwich',
            price = 25,
            amount = 250,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = 'bandage',
            price = 80,
            amount = 250,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = 'lighter',
            price = 50,
            amount = 250,
            info = {},
            type = 'item',
            slot = 7,
        },
        [8] = {
            name = 'rolling_paper',
            price = 60,
            amount = 250,
            info = {},
            type = 'item',
            slot = 8,
        },
        [9] = {
            name = 'coffee',
            price = 20,
            amount = 250,
            info = {},
            type = 'item',
            slot = 9,
        },
        [10] = {
            name = 'phone',
            price = 499,
            amount = 50,
            info = {},
            type = 'item',
            slot = 10,
        },
        [11] = {
            name = 'fitbit',
            price = 799,
            amount = 150,
            info = {},
            type = 'item',
            slot = 11,
        },
    },
    ['alcohol'] = {
        [1] = {
            name = 'beer',
            price = 49,
            amount = 50,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'whiskey',
            price = 99,
            amount = 50,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'vodka',
            price = 69,
            amount = 50,
            info = {},
            type = 'item',
            slot = 3,
        },
    },
    ['hardware'] = {
        [1] = {
            name = 'lockpick',
            price = 299,
            amount = 500,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'weapon_wrench',
            price = 420,
            amount = 250,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'weapon_hammer',
            price = 420,
            amount = 250,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'repairkit',
            price = 299,
            amount = 50,
            info = {},
            type = 'item',
            slot = 4,
            requiredJob = { 'mechanic', 'police' }
        },
        [5] = {
            name = 'screwdriverset',
            price = 249,
            amount = 50,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = 'radio',
            price = 299,
            amount = 50,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = 'binoculars',
            price = 179,
            amount = 50,
            info = {},
            type = 'item',
            slot = 7,
        },
        [8] = {
            name = 'firework1',
            price = 499,
            amount = 50,
            info = {},
            type = 'item',
            slot = 8,
        },
        [9] = {
            name = 'firework2',
            price = 499,
            amount = 50,
            info = {},
            type = 'item',
            slot = 9,
        },
        [10] = {
            name = 'firework3',
            price = 499,
            amount = 50,
            info = {},
            type = 'item',
            slot = 10,
        },
        [11] = {
            name = 'firework4',
            price = 499,
            amount = 50,
            info = {},
            type = 'item',
            slot = 11,
        },
        [12] = {
            name = 'cleaningkit',
            price = 199,
            amount = 150,
            info = {},
            type = 'item',
            slot = 12,
        },
        [13] = {
            name = 'advancedrepairkit',
            price = 499,
            amount = 50,
            info = {},
            type = 'item',
            slot = 13,
            requiredJob = { 'mechanic' }
        },
        [14] = {
            name = 'parachute',
            price = 999,
            amount = 10,
            info = {},
            type = 'item',
            slot = 14,
        },
        [15] = {
            name = 'fishingrod',
            price = 169,
            amount = 10,
            info = {},
            type = 'item',
            slot = 15,
        },
        [16] = {
            name = 'fishingbait',
            price = 49,
            amount = 50,
            info = {},
            type = 'item',
            slot = 16,
        },
    },
    ['weapons'] = {
        [1] = {
            name = 'weapon_knife',
            price = 399,
            amount = 250,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'weapon_bat',
            price = 599,
            amount = 250,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'weapon_hatchet',
            price = 799,
            amount = 250,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'weapon_pistol',
            price = 1199,
            amount = 5,
            info = {},
            type = 'item',
            slot = 4,
            requiresLicense = true
        },
        [5] = {
            name = 'weapon_combatpistol',
            price = 1099,
            amount = 5,
            info = {},
            type = 'item',
            slot = 5,
            requiresLicense = true
        },
        [6] = {
            name = 'weapon_snspistol',
            price = 949,
            amount = 5,
            info = {},
            type = 'item',
            slot = 6,
            requiresLicense = true
        },
        [7] = {
            name = 'pistol_ammo',
            price = 249,
            amount = 250,
            info = {},
            type = 'item',
            slot = 7,
            requiresLicense = true
        },
    },
    ['casino'] = {
        [1] = {
            name = 'casinochips',
            price = 1,
            amount = 50000000,
            info = {},
            type = 'item',
            slot = 1,
        }
    },
    ['pharmacy'] = {
        [1] = {
            name = 'firstaid',
            price = 749,
            amount = 100,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'bandage',
            price = 80,
            amount = 100,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'painkillers',
            price = 99,
            amount = 100,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'ifak',
            price = 449,
            amount = 100,
            info = {},
            type = 'item',
            slot = 4,
        },
    },
    ['weed'] = {
        [1] = {
            name = 'fertilizer',
            price = 49,
            amount = 50,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'weed_white-widow_seed',
            price = 249,
            amount = 100,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'weed_skunk_seed',
            price = 99,
            amount = 100,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'weed_purple-haze_seed',
            price = 315,
            amount = 100,
            info = {},
            type = 'item',
            slot = 4,
        },
        [5] = {
            name = 'weed_og-kush_seed',
            price = 199,
            amount = 100,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = 'weed_amnesia_seed',
            price = 275,
            amount = 100,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = 'weed_ak47_seed',
            price = 179,
            amount = 100,
            info = {},
            type = 'item',
            slot = 7,
        },
    },
    ['meth'] = {
        [1] = {
            name = 'methlab',
            price = 750,
            amount = 50,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'acetone',
            price = 69,
            amount = 100,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'lithium',
            price = 125,
            amount = 100,
            info = {},
            type = 'item',
            slot = 3,
        },
    },
    ['weap'] = {
        [1] = {
            name = 'pistol_ammo',
            price = 299,
            amount = 50,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'smg_ammo',
            price = 349,
            amount = 100,
            info = {},
            type = 'item',
            slot = 2,
        },
        [3] = {
            name = 'rifle_ammo',
            price = 399,
            amount = 100,
            info = {},
            type = 'item',
            slot = 3,
        },
        [4] = {
            name = 'weapon_heavypistol',
            price = 1899,
            amount = 100,
            info = {},
            type = 'item',
            slot = 4,
        },
        [5] = {
            name = 'weapon_pistol50',
            price = 2099,
            amount = 100,
            info = {},
            type = 'item',
            slot = 5,
        },
        [6] = {
            name = 'weapon_microsmg',
            price = 3499,
            amount = 100,
            info = {},
            type = 'item',
            slot = 6,
        },
        [7] = {
            name = 'weapon_assaultrifle',
            price = 4999,
            amount = 100,
            info = {},
            type = 'item',
            slot = 7,
        },
        [8] = {
            name = 'weapon_specialcarbine',
            price = 5899,
            amount = 100,
            info = {},
            type = 'item',
            slot = 8,
        },
    },
    ['parts'] = {
        [1] = {
            name = 'cleaningkit',
            price = 175,
            amount = 50,
            info = {},
            type = 'item',
            slot = 1,
        },
        [2] = {
            name = 'engine0',
            price = 100,
            amount = 5,
            info = {},
            type = 'item',
            slot = 2,
            requiredJob = { 'mechanic' }
        },
        [3] = {
            name = 'engine1',
            price = 1499,
            amount = 5,
            info = {},
            type = 'item',
            slot = 3,
            requiredJob = { 'mechanic' }
        },
        [4] = {
            name = 'engine2',
            price = 2499,
            amount = 5,
            info = {},
            type = 'item',
            slot = 4,
            requiredJob = { 'mechanic' }
        },
        [5] = {
            name = 'engine3',
            price = 4999,
            amount = 5,
            info = {},
            type = 'item',
            slot = 5,
            requiredJob = { 'mechanic' }
        },
        [6] = {
            name = 'engine4',
            price = 7499,
            amount = 2,
            info = {},
            type = 'item',
            slot = 6,
            requiredJob = { 'mechanic' }
        },
        [7] = {
            name = 'brake0',
            price = 100,
            amount = 5,
            info = {},
            type = 'item',
            slot = 7,
            requiredJob = { 'mechanic' }
        },
        [8] = {
            name = 'brake1',
            price = 1299,
            amount = 5,
            info = {},
            type = 'item',
            slot = 8,
            requiredJob = { 'mechanic' }
        },
        [9] = {
            name = 'brake2',
            price = 2299,
            amount = 5,
            info = {},
            type = 'item',
            slot = 9,
            requiredJob = { 'mechanic' }
        },
        [10] = {
            name = 'brake3',
            price = 4799,
            amount = 5,
            info = {},
            type = 'item',
            slot = 10,
            requiredJob = { 'mechanic' }
        },
        [11] = {
            name = 'transmission0',
            price = 100,
            amount = 5,
            info = {},
            type = 'item',
            slot = 11,
            requiredJob = { 'mechanic' }
        },
        [12] = {
            name = 'transmission1',
            price = 1499,
            amount = 5,
            info = {},
            type = 'item',
            slot = 12,
            requiredJob = { 'mechanic' }
        },
        [13] = {
            name = 'transmission2',
            price = 2499,
            amount = 5,
            info = {},
            type = 'item',
            slot = 13,
            requiredJob = { 'mechanic' }
        },
        [14] = {
            name = 'transmission3',
            price = 4999,
            amount = 5,
            info = {},
            type = 'item',
            slot = 14,
            requiredJob = { 'mechanic' }
        },
        [15] = {
            name = 'suspension0',
            price = 100,
            amount = 5,
            info = {},
            type = 'item',
            slot = 15,
            requiredJob = { 'mechanic' }
        },
        [16] = {
            name = 'suspension1',
            price = 999,
            amount = 5,
            info = {},
            type = 'item',
            slot = 16,
            requiredJob = { 'mechanic' }
        },
        [17] = {
            name = 'suspension2',
            price = 1499,
            amount = 5,
            info = {},
            type = 'item',
            slot = 17,
            requiredJob = { 'mechanic' }
        },
        [18] = {
            name = 'suspension3',
            price = 1999,
            amount = 5,
            info = {},
            type = 'item',
            slot = 18,
            requiredJob = { 'mechanic' }
        },
        [19] = {
            name = 'suspension4',
            price = 2499,
            amount = 5,
            info = {},
            type = 'item',
            slot = 19,
            requiredJob = { 'mechanic' }
        },
        [20] = {
            name = 'turbo0',
            price = 100,
            amount = 5,
            info = {},
            type = 'item',
            slot = 20,
            requiredJob = { 'mechanic' }
        },
        [21] = {
            name = 'turbo1',
            price = 4999,
            amount = 5,
            info = {},
            type = 'item',
            slot = 21,
            requiredJob = { 'mechanic' }
        },
    },
    ["petshop"] = {
        [1] = {
            name = 'keepcompanionwesty',
            price = 2000,
            amount = 5,
            info = {},
            type = 'item',
            slot = 1
        },
        [2] = {
            name = 'keepcompanionshepherd',
            price = 3000,
            amount = 5,
            info = {},
            type = 'item',
            slot = 2
        },
        [3] = {
            name = 'keepcompanionretriever',
            price = 4000,
            amount = 5,
            info = {},
            type = 'item',
            slot = 3
        },
        [4] = {
            name = 'keepcompanionrottweiler',
            price = 4000,
            amount = 5,
            info = {},
            type = 'item',
            slot = 4
        },
        [5] = {
            name = 'keepcompanionpug',
            price = 2000,
            amount = 5,
            info = {},
            type = 'item',
            slot = 5
        },
        [6] = {
            name = 'keepcompanionpoodle',
            price = 2500,
            amount = 5,
            info = {},
            type = 'item',
            slot = 6
        },

        [7] = {
            name = 'keepcompanionmtlion2',
            price = 10000,
            amount = 5,
            info = {},
            type = 'item',
            slot = 7
        },
        [8] = {
            name = 'keepcompanioncat',
            price = 2500,
            amount = 5,
            info = {},
            type = 'item',
            slot = 8
        },
        [9] = {
            name = 'keepcompanionmtlion',
            price = 10000,
            amount = 5,
            info = {},
            type = 'item',
            slot = 9
        },
        [10] = {
            name = 'keepcompanionhusky',
            price = 5000,
            amount = 5,
            info = {},
            type = 'item',
            slot = 10
        },
        [11] = {
            name = 'petfood',
            price = 199,
            amount = 1000,
            info = {},
            type = 'item',
            slot = 11
        },
        [12] = {
            name = 'collarpet',
            price = 5000,
            amount = 50,
            info = {},
            type = 'item',
            slot = 12
        },
        [13] = {
            name = 'firstaidforpet',
            price = 250,
            amount = 50,
            info = {},
            type = 'item',
            slot = 13
        },
    },
}

Config.Locations = {
    --['casino'] = {
        --['label'] = 'Diamond Casino',
        --['type'] = 'normal',
        --['coords'] = {
            --[1] = vector3(948.3834, 34.21247, 71.839)
        --},
        --['products'] = Config.Products['casino'],
        --['showblip'] = true,
    --},
    ['ltdgasoline'] = {
        ['label'] = 'LTD Gasoline',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(-48.44, -1757.86, 29.42),
            [2] = vector3(-47.23, -1756.58, 29.42)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['247supermarket'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(25.7, -1347.3, 29.49),
            [2] = vector3(25.7, -1344.99, 29.49)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['robsliquor6'] = {
        ['label'] = 'Casino Bar',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(936.21, 28.42, 71.83)
        },
        ['products'] = Config.Products['alcohol'],
        ['showblip'] = true,
    },
    ['robsliquor'] = {
        ['label'] = 'Rob\'s Liqour',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(-1222.77, -907.19, 12.32)
        },
        ['products'] = Config.Products['alcohol'],
        ['showblip'] = true,
    },
    ['ltdgasoline2'] = {
        ['label'] = 'LTD Gasoline',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(-707.41, -912.83, 19.21),
            [2] = vector3(-707.32, -914.65, 19.21)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['robsliquor2'] = {
        ['label'] = 'Rob\'s Liqour',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(-1487.7, -378.53, 40.16)
        },
        ['products'] = Config.Products['alcohol'],
        ['showblip'] = true,
    },
    ['ltdgasoline3'] = {
        ['label'] = 'LTD Gasoline',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(-1820.33, 792.66, 138.1),
            [2] = vector3(-1821.55, 793.98, 138.1)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['robsliquor3'] = {
        ['label'] = 'Rob\'s Liqour',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(-2967.79, 391.64, 15.04)
        },
        ['products'] = Config.Products['alcohol'],
        ['showblip'] = true,
    },
    ['247supermarket2'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(-3038.71, 585.9, 7.9),
            [2] = vector3(-3041.04, 585.11, 7.9)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['247supermarket3'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(-3241.47, 1001.14, 12.83),
            [2] = vector3(-3243.98, 1001.35, 12.83)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['247supermarket4'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(1728.66, 6414.16, 35.03),
            [2] = vector3(1729.72, 6416.27, 35.03)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['247supermarket5'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(1697.99, 4924.4, 42.06),
            [2] = vector3(1699.44, 4923.47, 42.06)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['247supermarket6'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(1961.48, 3739.96, 32.34),
            [2] = vector3(1960.22, 3742.12, 32.34)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['robsliquor4'] = {
        ['label'] = 'Rob\'s Liqour',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(1165.28, 2709.4, 38.15)
        },
        ['products'] = Config.Products['alcohol'],
        ['showblip'] = true,
    },
    ['247supermarket7'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(547.79, 2671.79, 42.15),
            [2] = vector3(548.1, 2669.38, 42.15)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['247supermarket8'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(2679.25, 3280.12, 55.24),
            [2] = vector3(2677.13, 281.38, 55.24)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['247supermarket9'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(2557.94, 382.05, 108.62),
            [2] = vector3(2555.53, 382.18, 108.62)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['ltdgasoline4'] = {
        ['label'] = 'LTD Gasoline',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(1163.7, -323.92, 69.2),
            [2] = vector3(1163.4, -322.24, 69.2)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['robsliquor5'] = {
        ['label'] = 'Rob\'s Liqour',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(1135.66, -982.76, 46.41)
        },
        ['products'] = Config.Products['alcohol'],
        ['showblip'] = true,
    },
    ['247supermarket10'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(373.55, 325.56, 103.56),
            [2] = vector3(374.29, 327.9, 103.56)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['247supermarket11'] = {
        ['label'] = '24/7 Supermarket',
        ['type'] = 'normal',
        ['coords'] = {
            [1] = vector3(161.26, 6640.58, 31.61),
            [2] = vector3(162.9, 6642.37, 31.61)
        },
        ['products'] = Config.Products['normal'],
        ['showblip'] = true,
    },
    ['hardware'] = {
        ['label'] = 'Tööriistapood',
        ['type'] = 'hardware',
        ['coords'] = {
            [1] = vector3(45.55, -1749.01, 29.6)
        },
        ['products'] = Config.Products['hardware'],
        ['showblip'] = true,
    },
    ['hardware2'] = {
        ['label'] = 'Tööriistapood',
        ['type'] = 'hardware',
        ['coords'] = {
            [1] = vector3(2747.8, 3472.86, 55.67)
        },
        ['products'] = Config.Products['hardware'],
        ['showblip'] = true,
    },
    ['hardware3'] = {
        ['label'] = 'Tööriistapood',
        ['type'] = 'hardware',
        ['coords'] = {
            [1] = vector3(-421.84, 6136.09, 31.78)
        },
        ['products'] = Config.Products['hardware'],
        ['showblip'] = true,
    },
    ['ammunation1'] = {
        ['label'] = 'Ammunation',
        ['type'] = 'weapon',
        ['coords'] = {
            [1] = vector3(-662.1, -935.3, 21.8)
        },
        ['products'] = Config.Products['weapons'],
        ['showblip'] = true,
    },
    ['ammunation2'] = {
        ['label'] = 'Ammunation',
        ['type'] = 'weapon',
        ['coords'] = {
            [1] = vector3(810.2, -2157.3, 29.6)
        },
        ['products'] = Config.Products['weapons'],
        ['showblip'] = true,
    },
    ['ammunation3'] = {
        ['label'] = 'Ammunation',
        ['type'] = 'weapon',
        ['coords'] = {
            [1] = vector3(1693.4, 3759.5, 34.7)
        },
        ['products'] = Config.Products['weapons'],
        ['showblip'] = true,
    },
    ['ammunation4'] = {
        ['label'] = 'Ammunation',
        ['type'] = 'weapon',
        ['coords'] = {
            [1] = vector3(-330.2, 6083.8, 31.4)
        },
        ['products'] = Config.Products['weapons'],
        ['showblip'] = true,
    },
    ['ammunation5'] = {
        ['label'] = 'Ammunation',
        ['type'] = 'weapon',
        ['coords'] = {
            [1] = vector3(252.3, -50.0, 69.9)
        },
        ['products'] = Config.Products['weapons'],
        ['showblip'] = true,
    },
    ['ammunation6'] = {
        ['label'] = 'Ammunation',
        ['type'] = 'weapon',
        ['coords'] = {
            [1] = vector3(22.0, -1107.2, 29.8)
        },
        ['products'] = Config.Products['weapons'],
        ['showblip'] = true,
    },
    ['ammunation7'] = {
        ['label'] = 'Ammunation',
        ['type'] = 'weapon',
        ['coords'] = {
            [1] = vector3(2567.6, 294.3, 108.7)
        },
        ['products'] = Config.Products['weapons'],
        ['showblip'] = true,
    },
    ['ammunation8'] = {
        ['label'] = 'Ammunation',
        ['type'] = 'weapon',
        ['coords'] = {
            [1] = vector3(-1117.5, 2698.6, 18.5)
        },
        ['products'] = Config.Products['weapons'],
        ['showblip'] = true,
    },
    ['ammunation9'] = {
        ['label'] = 'Ammunation',
        ['type'] = 'weapon',
        ['coords'] = {
            [1] = vector3(842.4, -1033.4, 28.1)
        },
        ['products'] = Config.Products['weapons'],
        ['showblip'] = true,
    },
    ['pharmacy'] = {
        ['label'] = 'Apteek',
        ['type'] = 'pharmacy',
        ['coords'] = {
            [1] = vector3(-172.42, 6385.58, 31.5)
        },
        ['products'] = Config.Products['pharmacy'],
        ['showblip'] = true,
    },
    ['parts'] = {
        ['label'] = 'Autoosad',
        ['type'] = 'parts',
        ['coords'] = {
            [1] = vector3(807.02, -809.95, 26.2)
        },
        ['products'] = Config.Products['parts'],
        ['showblip'] = false,
    },
    ['petshop'] = {
        ['label'] = 'Loomapood',
        ['type'] = 'petshop',
        ['coords'] = {
            [1] = vector3(562.27, 2741.57, 42.87)
        },
        ['products'] = Config.Products['petshop'],
        ['showblip'] = true,
    },
}

Config.Peds = {
    ['supermarket'] = vector4(24.43, -1348.54, 29.5, 305.52),
    ['supermarket2'] = vector4(-47.36, -1758.6, 29.42, 52.42),
    ['supermarket3'] = vector4(-706.17, -914.57, 19.22, 89.88),
    ['supermarket4'] = vector4(1164.87, -323.7, 69.21, 96.72),
    ['supermarket5'] = vector4(372.18, 325.17, 103.57, 280.38),
    ['supermarket6'] = vector4(-1819.55, 793.51, 138.09, 137.08),
    ['supermarket7'] = vector4(-3037.78, 584.81, 7.91, 44.67),
    ['supermarket8'] = vector4(-3240.98, 999.89, 12.83, 25.57),
    ['supermarket9'] = vector4(548.99, 2672.43, 42.16, 120.48),
    ['supermarket10'] = vector4(1960.63, 3738.89, 32.34, 323.78),
    ['supermarket11'] = vector4(2679.12, 3278.72, 55.24, 2.41),
    ['supermarket12'] = vector4(1697.33, 4923.39, 42.06, 323.24),
    ['supermarket13'] = vector4(159.56, 6640.79, 31.61, 255.39),
    ['supermarket14'] = vector4(1727.37, 6414.15, 35.04, 278.03),
    ['supermarket15'] = vector4(2558.4, 380.65, 108.62, 19.49),
}

Config.Hardware = {
    ['hardware'] = vector4(46.54, -1749.67, 29.63, 48.45),
    ['hardware2'] = vector4(2747.57, 3472.85, 55.67, 248.58),
    ['hardware3'] = vector4(-421.3, 6136.92, 31.88, 173.96),
}

Config.Ammunation = {
    ['ammunation'] = vector4(22.74, -1105.61, 29.8, 157.48),
    ['ammunation2'] = vector4(810.12, -2159.0, 29.62, 356.25),
    ['ammunation3'] = vector4(842.51, -1035.25, 28.19, 359.37),
    ['ammunation4'] = vector4(253.78, -50.51, 69.94, 77.28),
    ['ammunation5'] = vector4(-662.22, -933.6, 21.83, 182.16),
    ['ammunation6'] = vector4(2567.84, 292.55, 108.73, 1.63),
    ['ammunation7'] = vector4(-1118.98, 2699.83, 18.55, 223.47),
    ['ammunation8'] = vector4(1692.3, 3760.99, 34.71, 230.02),
    ['ammunation9'] = vector4(-331.52, 6085.01, 31.45, 222.8),
}

Config.Alko = {
    ['alko'] = vector4(1164.89, 2710.84, 38.16, 202.35),
    ['alko2'] = vector4(-1486.91, -377.24, 40.16, 164.12),
    ['alko3'] = vector4(-1221.08, -907.71, 12.33, 58.53),
    ['alko4'] = vector4(1134.38, -983.46, 46.42, 306.56),
    ['alko5'] = vector4(-2966.39, 391.91, 15.04, 119.51),
}

Config.Pharmacy = {
    ['pharmacy'] = vector4(-171.26, 6386.41, 31.5, 136.18),
}

Config.Parts = {
    ['parts'] = vector4(807.02, -809.95, 26.2, 98.23),
}