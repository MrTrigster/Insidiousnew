Config = Config or {}

Config.MinimumPaletoPolice = 4
Config.MinimumPacificPolice = 5
Config.MinimumFleecaPolice = 3
Config.MinimumThermitePolice = 3



Config.PowerStations = {
    [1] = {
        coords = vector3(2474.3, 1464.66, 36.2),
        hit = false
    },
    [2] = {
        coords = vector3(2058.99, 3692.1, 34.59),
        hit = false
    },
    [3] = {
        coords = vector3(711.71, 164.93, 80.75),
        hit = false
    }
}



Config.SmallBanks = {
    ['fleeca1'] = {
        ['label'] = 'Meteor Street',
        ['coords'] = vector3(311.15, -284.49, 54.16),

        ['object'] = GetHashKey('v_ilev_gb_vauldr'),
        ['heading'] = {
            closed = 250.0,
            open = 160.0
        },
        ['camId'] = 21,
        ['isOpened'] = false
    },
    ['fleeca2'] = {
        ['label'] = 'Legion Square',
        ['coords'] = vector3(146.92, -1046.11, 29.36),
        ['object'] = GetHashKey('v_ilev_gb_vauldr'),
        ['heading'] = {
            closed = 250.0,
            open = 160.0
        },
        ['camId'] = 22,
        ['isOpened'] = false
    },
    ['fleeca3'] = {
        ['label'] = 'Hawick Ave',
        ['coords'] = vector3(-353.82, -55.37, 49.03),
        ['object'] = GetHashKey('v_ilev_gb_vauldr'),
        ['heading'] = {
            closed = 250.0,
            open = 160.0
        },
        ['camId'] = 23,
        ['isOpened'] = false
    },
    ['fleeca4'] = {
        ['label'] = 'Del Perro Blvd',
        ['coords'] = vector3(-1210.77, -336.57, 37.78),
        ['object'] = GetHashKey('v_ilev_gb_vauldr'),
        ['heading'] = {
            closed = 296.863,
            open = 206.863
        },
        ['camId'] = 24,
        ['isOpened'] = false
    },
    ['fleeca5'] = {
        ['label'] = 'Great Ocean Hwy',
        ['coords'] = vector3(-2956.55, 481.74, 15.69),
        ['object'] = GetHashKey('hei_prop_heist_sec_door'),
        ['heading'] = {
            closed = 357.542,
            open = 267.542
        },
        ['camId'] = 25,
        ['isOpened'] = false
    },
    ['fleeca6'] = {
        ['label'] = 'East',
        ['coords'] = vector3(1175.96, 2712.87, 38.09),
        ['object'] = GetHashKey('v_ilev_gb_vauldr'),
        ['heading'] = {
            closed = -270.542,
            open = -370.542
        },
        ['camId'] = 25,
        ['isOpened'] = false
    }
}

Config.BigBanks = {
    ['paleto'] = {
        ['label'] = 'Paleto Bay Pank',
        ['coords'] = vector3(-105.61, 6472.03, 31.62),
        ['object'] = -1185205679,
        ['heading'] = {
            closed = 45.45,
            open = 130.45
        },
        ['camId'] = 26,
        ['isOpened'] = false
    },
    ['pacific'] = {
        ['label'] = 'Pacific Standard',
        ['coords'] = {
            [1] = vector3(261.95, 223.11, 106.28),
            [2] = vector3(253.25, 228.44, 101.68)
        },
        ['object'] = 961976194,
        ['heading'] = {
            closed = 160.00001,
            open = 70.00001
        },
        ['thermite'] = {
            [1] = {
                ['coords'] = vector3(256.31, 220.65, 106.42),
                ['isOpened'] = false,
                ['doorId'] = 88
            },
            [2] = {
                ['coords'] = vector3(252.55, 221.15, 101.68),
                ['isOpened'] = false,
                ['doorId'] = 90
            },
            [3] = {
                ['coords'] = vector3(261.15, 215.21, 101.68),
                ['isOpened'] = false,
                ['doorId'] = 91
            }
        },
        ['camId'] = 26,
        ['isOpened'] = false,
        ['isOpenedTwo'] = false
    }
}



Config.ActivityStatus = {
    ['pacific'] = {
        label = 'Pacific Pank',
        status = false,
    },
    ['paleto'] = {
        label = 'Paleto Pank',
        status = false,
    },
    ['fleeca1'] = {
        label = 'Fleeca Pank (Meteor Street)',
        status = false,
    },
    ['fleeca2'] = {
        label = 'Fleeca Pank (Legion Square)',
        status = false,
    },
    ['fleeca3'] = {
        label = 'Fleeca Pank (Hawick Ave)',
        status = false,
    },
    ['fleeca4'] = {
        label = 'Fleeca Pank (Del Perro Blvd)',
        status = false,
    },
    ['fleeca5'] = {
        label = 'Fleeca Pank (Great Ocean Hwy)',
        status = false,
    },
    ['fleeca6'] = {
        label = 'Fleeca Pank (Route 68)',
        status = false,
    },
}



Config.MaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true
}

Config.FemaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true
}