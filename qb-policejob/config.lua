Config = {}

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["roadsign"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.MaxSpikes = 5

Config.HandCuffItem = 'handcuffs'

Config.Locations = {
    ["duty"] = {
        [1] = vector3(441.51, -979.96, 30.69),
    },
    ["vehicle"] = {
        [1] = vector4(452.91, -1017.58, 28.47, 94.65),
        [2] = vector4(475.17, -1021.5, 28.07, 271.79),
    },
    ["stash"] = {
        [1] = vector3(485.74, -1005.21, 25.73),
    },
    ["impound"] = {
        [1] = vector4(442.22, -1015.92, 28.66, 90.48),
    },
    ["helicopter"] = {
        [1] = vector4(449.168, -981.325, 43.691, 87.234),
    },
    ["armory"] = {
        [1] = vector3(484.33, -1002.05, 25.73),
    },
    ["gear"] = {
        [1] = vector3(485.54, -1007.2, 25.73),
    },
    ["trash"] = {
        [1] = vector3(475.42, -1005.12, 34.22),
    },
    ["fingerprint"] = {
        [1] = vector3(482.09, -1012.15, 34.23),
    },
    ["evidence"] = {
        [1] = vector3(472.13, -1005.25, 34.22),
        [2] = vector3(471.96, -1008.45, 34.22),
        [3] = vector3(475.2, -1008.24, 34.22),
    },
   ["stations"] = {
       [1] = {label = "MRPD Jaoskond", coords = vector4(428.23, -984.28, 29.76, 3.5)},
       [2] = {label = "Vangla", coords = vector4(1845.903, 2585.873, 45.672, 272.249)},
   },
}

Config.ArmoryWhitelist = {}

Config.PoliceHelicopter = "POLMAV"

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", coords = vector3(257.45, 210.07, 109.08), r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", coords = vector3(232.86, 221.46, 107.83), r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", coords = vector3(252.27, 225.52, 103.99), r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", coords = vector3(-53.1433, -1746.714, 31.546), r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", coords = vector3(-1482.9, -380.463, 42.363), r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", coords = vector3(-1224.874, -911.094, 14.401), r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", coords = vector3(-718.153, -909.211, 21.49), r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarkt Innocence Blvd. CAM#1", coords = vector3(23.885, -1342.441, 31.672), r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", coords = vector3(1133.024, -978.712, 48.515), r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", coords = vector3(1151.93, -320.389, 71.33), r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarkt Clinton Ave CAM#1", coords = vector3(383.402, 328.915, 105.541), r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", coords = vector3(-1832.057, 789.389, 140.436), r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", coords = vector3(-2966.15, 387.067, 17.393), r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarkt Ineseno Road CAM#1", coords = vector3(-3046.749, 592.491, 9.808), r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarkt Barbareno Rd. CAM#1", coords = vector3(-3246.489, 1010.408, 14.705), r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarkt Route 68 CAM#1", coords = vector3(539.773, 2664.904, 44.056), r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", coords = vector3(1169.855, 2711.493, 40.432), r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarkt Senora Fwy CAM#1", coords = vector3(2673.579, 3281.265, 57.541), r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarkt Alhambra Dr. CAM#1", coords = vector3(1966.24, 3749.545, 34.143), r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarkt Senora Fwy CAM#2", coords = vector3(1729.522, 6419.87, 37.262), r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", coords = vector3(309.341, -281.439, 55.88), r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", coords = vector3(144.871, -1043.044, 31.017), r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", coords = vector3(-355.7643, -52.506, 50.746), r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", coords = vector3(-1214.226, -335.86, 39.515), r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", coords = vector3(-2958.885, 478.983, 17.406), r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", coords = vector3(-102.939, 6467.668, 33.424), r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", coords = vector3(-163.75, 6323.45, 33.424), r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", coords = vector3(166.42, 6634.4, 33.69), r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", coords = vector3(163.74, 6644.34, 33.69), r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", coords = vector3(169.54, 6640.89, 33.69), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico Jewelery CAM#1", coords = vector3(-627.54, -239.74, 40.33), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico Jewelery CAM#2", coords = vector3(-627.51, -229.51, 40.24), r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico Jewelery CAM#3", coords = vector3(-620.3, -224.31, 40.23), r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico Jewelery CAM#4", coords = vector3(-622.57, -236.3, 40.31), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}

Config.AuthorizedVehicles = {
	-- Grade 0
	[0] = {
		["vic"] = "Crown Vic",
	},
	-- Grade 1
	[1] = {
		["vic"] = "Crown Vic",
	},
	-- Grade 2
	[2] = {
		["vic"] = "Crown Vic",
        ["exp"] = "Explorer",
        ["tau"] = "Taurus",
	},
	-- Grade 3
	[3] = {
		["vic"] = "Crown Vic",
		["exp"] = "Explorer",
        ["tau"] = "Taurus",
        ["tah"] = "Tahoe",
        ["mach1rb"] = "Interceptor Mustang",
	},
	-- Grade 4
	[4] = {
		["vic"] = "Crown Vic",
		["chrg"] = "Charger",
        ["tau"] = "Taurus",
		["exp"] = "Explorer",
		["tah"] = "Tahoe",
        ["mach1rb"] = "Interceptor Mustang",
	},

    [5] = {
		["vic"] = "Crown Vic",
		["chrg"] = "Charger",
		["exp"] = "Explorer",
		["tah"] = "Tahoe",
		["tau"] = "Taurus",
        ["mach1rb"] = "Interceptor Mustang",
	},

    [6] = {
		["vic"] = "Crown Vic",
		["chrg"] = "Charger",
		["exp"] = "Explorer",
		["tah"] = "Tahoe",
		["tau"] = "Taurus",
        ["mach1rb"] = "Interceptor Mustang",
	},

    [7] = {
		["vic"] = "Crown Vic",
		["chrg"] = "Charger",
		["exp"] = "Explorer",
		["tah"] = "Tahoe",
		["tau"] = "Taurus",
		["nm_cam69"] = "Unmarked Camaro",
        ["mach1rb"] = "Interceptor Mustang",
        ["bmwm5"] = "Unmarked BMW M5",
	},

    [8] = {
		["vic"] = "Crown Vic",
		["chrg"] = "Charger",
		["exp"] = "Explorer",
		["tah"] = "Tahoe",
		["tau"] = "Taurus",
		["nm_cam69"] = "Unmarked Camaro",
        ["mach1rb"] = "Interceptor Mustang",
        ["bmwm5"] = "Unmarked BMW M5",
	},

    [9] = {
		["vic"] = "Crown Vic",
		["chrg"] = "Charger",
		["exp"] = "Explorer",
		["tah"] = "Tahoe",
		["tau"] = "Taurus",
		["nm_cam69"] = "Unmarked Camaro",
        ["mach1rb"] = "Interceptor Mustang",
        ["bmwm5"] = "Unmarked BMW M5",
        ["mclarenpd"] = "Interceptor Mclaren",
	},

    [10] = {
		["vic"] = "Crown Vic",
		["chrg"] = "Charger",
		["exp"] = "Explorer",
		["tah"] = "Tahoe",
		["tau"] = "Taurus",
		["nm_cam69"] = "Unmarked Camaro",
		["riot"] = "Riot",
        ["mach1rb"] = "Interceptor Mustang",
        ["bmwm5"] = "Unmarked BMW M5",
        ["mclarenpd"] = "Interceptor Mclaren",
	},

    [11] = {
		["vic"] = "Crown Vic",
		["chrg"] = "Charger",
		["exp"] = "Explorer",
		["tah"] = "Tahoe",
		["tau"] = "Taurus",
		["nm_cam69"] = "Unmarked Camaro",
		["riot"] = "Riot",
        ["mach1rb"] = "Interceptor Mustang",
        ["bmwm5"] = "Unmarked BMW M5",
        ["mclarenpd"] = "Interceptor Mclaren",
	},
}

Config.WhitelistedVehicles = {}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm",
    ["AMMO_SMG"] = "9x19mm SMG",
    ["AMMO_RIFLE"] = "7.62x39mm & 5.56x45mm",
    ["AMMO_MG"] = "7.92x57mm",
    ["AMMO_SHOTGUN"] = "12-gauge",
    ["AMMO_SNIPER"] = "12.7x55mm & 7.62x54mmR",
}

Config.Radars = {
	vector4(-623.44421386719, -823.08361816406, 25.25704574585, 145.0),
	vector4(-652.44421386719, -854.08361816406, 24.55704574585, 325.0),
	vector4(1623.0114746094, 1068.9924316406, 80.903594970703, 84.0),
	vector4(-2604.8994140625, 2996.3391113281, 27.528566360474, 175.0),
	vector4(2136.65234375, -591.81469726563, 94.272926330566, 318.0),
	vector4(2117.5764160156, -558.51013183594, 95.683128356934, 158.0),
	vector4(406.89505004883, -969.06286621094, 29.436267852783, 33.0),
	vector4(657.315, -218.819, 44.06, 320.0),
	vector4(2118.287, 6040.027, 50.928, 172.0),
	vector4(-106.304, -1127.5530, 30.778, 230.0),
	vector4(-823.3688, -1146.980, 8.0, 300.0),
}

Config.CarItems = {
    [1] = {
        name = "heavyarmor",
        amount = 2,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "empty_evidence_bag",
        amount = 10,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "police_stormram",
        amount = 2,
        info = {},
        type = "item",
        slot = 3,
    },
}

Config.Items = {
    label = "Politsei Relvakapp",
    slots = 30,
    items = {
        [1] = {
            name = "weapon_pistol_mk2",
            price = 999,
            amount = 20,
            info = {
                serie = "", 
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [2] = {
            name = "weapon_stungun",
            price = 399,
            amount = 20,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [3] = {
            name = "weapon_pumpshotgun",
            price = 1499,
            amount = 20,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 3,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [4] = {
            name = "weapon_heavyrifle",
            price = 1999,
            amount = 20,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 4,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9}
        },
        [5] = {
            name = "weapon_carbinerifle_mk2",
            price = 1699,
            amount = 20,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 5,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [6] = {
            name = "weapon_nightstick",
            price = 229,
            amount = 20,
            info = {},
            type = "weapon",
            slot = 6,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [7] = {
            name = "pistol_ammo",
            price = 99,
            amount = 50,
            info = {},
            type = "item",
            slot = 7,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [8] = {
            name = "shotgun_ammo",
            price = 119,
            amount = 50,
            info = {},
            type = "item",
            slot = 8,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [9] = {
            name = "rifle_ammo",
            price = 129,
            amount = 50,
            info = {},
            type = "item",
            slot = 9,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [10] = {
            name = "handcuffs",
            price = 119,
            amount = 50,
            info = {},
            type = "item",
            slot = 10,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [11] = {
            name = "weapon_flashlight",
            price = 229,
            amount = 20,
            info = {},
            type = "weapon",
            slot = 11,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [12] = {
            name = "empty_evidence_bag",
            price = 20,
            amount = 50,
            info = {},
            type = "item",
            slot = 12,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [13] = {
            name = "armor",
            price = 299,
            amount = 50,
            info = {},
            type = "item",
            slot = 13,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [14] = {
            name = "radio",
            price = 249,
            amount = 50,
            info = {},
            type = "item",
            slot = 14,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [15] = {
            name = "heavyarmor",
            price = 499,
            amount = 50,
            info = {},
            type = "item",
            slot = 15,
            authorizedJobGrades = {1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [16] = {
            name = "firstaid",
            price = 399,
            amount = 50,
            info = {},
            type = "item",
            slot = 16,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [17] = {
            name = "bandage",
            price = 69,
            amount = 50,
            info = {},
            type = "item",
            slot = 17,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [18] = {
            name = "ifak",
            price = 199,
            amount = 50,
            info = {},
            type = "item",
            slot = 18,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [19] = {
            name = "weapon_bzgas",
            price = 699,
            amount = 10,
            info = {},
            type = "item",
            slot = 19,
            authorizedJobGrades = {3, 4, 5, 6, 7, 8, 9}
        },
        [20] = {
            name = "taserammo",
            price = 39,
            amount = 10,
            info = {},
            type = "item",
            slot = 20,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [21] = {
            name = "bodycam",
            price = 150,
            amount = 10,
            info = {},
            type = "item",
            slot = 21,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        },
        [22] = {
            name = "spikestrip",
            price = 350,
            amount = 10,
            info = {},
            type = "item",
            slot = 22,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
        }
    }
}

-- PURSUIT STUFF

Config.DefaultKey = 'N'

Config.SlowdownOnSwitch = false
Config.SlowdownPercentage = 0.2 -- 0.2 => 20%

Config.PlaySoundOnSwitch = true

Config.PlayServerSyncedSound = true -- server synced sounds can be heard by other players, disable if you cannot hear the sounds at higher speeds or mess with the distance settings below
Config.MaxSoundDistance = 3.0 -- Server Synced only, and no volume falloff
Config.MaxSoundDistanceAtMediumSpeeds = 5.0 -- Do not touch if you don't know what you're doing!
Config.MaxSoundDistanceAtHighSpeeds = 10.0 -- Do not touch if you don't know what you're doing!

Config.SoundFile = 'beep-sound-1' -- file name without the .ogg (located in /resources/[standalone]/interact-sound/client/html/sounds/)
Config.SoundVolume = 0.05

Config.SwitchNotification = "Pursuit Mode: %s" -- %s will be replaced with the vehicle mode, e.g. S+

Config.AuthorizedJobs = { -- empty => everyone can use it
    "police",
    -- "ambulance",
}

Config.VehicleModes = { -- If you define a new mode, you will have to add a new Vehicle Modification and a new mode for EVERY vehicle defined in Config.VehiclesConfig!
    "B",
    "A",
    "S"
}

Config.VehicleModifications = {
    ["B"] = {
        ["Turbo"] = false,
        ["XenonHeadlights"] = false,
        ["Engine"] = -1,
        ["Brakes"] = -1,
        ["Transmission"] = -1,
        ["XenonHeadlightsColor"] = 0,
    },
    ["A"] = {
        ["Turbo"] = false,
        ["XenonHeadlights"] = false,
        ["Engine"] = -1,
        ["Brakes"] = -1,
        ["Transmission"] = -1,
        ["XenonHeadlightsColor"] = 0,
    },
    ["S"] = {
        ["Turbo"] = false,
        ["XenonHeadlights"] = false,
        ["Engine"] = -1,
        ["Brakes"] = -1,
        ["Transmission"] = -1,
        ["XenonHeadlightsColor"] = 0,
    },
}

-- To add more cars just copy an existing one and adjust the values correspondingly (don't forget to change the model name aswell, e.g. police3) 
-- You can remove or add any value that is a float, integer or vector3 (for available values check handling.meta) but make sure to do so for every mode / class of that vehicle, otherwise the value won't be reset
Config.VehiclesConfig = {
    ['18mustangum'] = {
        ["B"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.700000,
            ["fInitialDriveMaxFlatVel"] = 172.000000,
            ["fSteeringLock"] = 34.000000,
            ["fInitialDriveForce"] = 0.310000
        },
        ["A"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.700000,
            ["fInitialDriveMaxFlatVel"] = 183.000000,
            ["fSteeringLock"] = 34.000000,
            ["fInitialDriveForce"] = 0.345000
        },
        ["S"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.700000,
            ["fInitialDriveMaxFlatVel"] = 240.000000,
            ["fSteeringLock"] = 34.000000,
            ["fInitialDriveForce"] = 0.385000
        },
    },
    ['mach1bb'] = {
        ["B"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.700000,
            ["fInitialDriveMaxFlatVel"] = 172.000000,
            ["fSteeringLock"] = 34.000000,
            ["fInitialDriveForce"] = 0.310000
        },
        ["A"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.700000,
            ["fInitialDriveMaxFlatVel"] = 183.000000,
            ["fSteeringLock"] = 34.000000,
            ["fInitialDriveForce"] = 0.345000
        },
        ["S"] = {
            ["fDriveInertia"] = 1.000000,
            ["fBrakeForce"] = 0.700000,
            ["fInitialDriveMaxFlatVel"] = 240.000000,
            ["fSteeringLock"] = 34.000000,
            ["fInitialDriveForce"] = 0.385000
        },
    },
    ['poldemonrb'] = {
        ["B"] = {
            ["fDriveInertia"] = 1.200000,
            ["fBrakeForce"] = 0.700000,
            ["fInitialDriveMaxFlatVel"] = 172.000000,
            ["fSteeringLock"] = 34.000000,
            ["fInitialDriveForce"] = 0.610000
        },
        ["A"] = {
            ["fDriveInertia"] = 1.200000,
            ["fBrakeForce"] = 0.700000,
            ["fInitialDriveMaxFlatVel"] = 183.000000,
            ["fSteeringLock"] = 34.000000,
            ["fInitialDriveForce"] = 0.645000
        },
        ["S"] = {
            ["fDriveInertia"] = 1.200000,
            ["fBrakeForce"] = 0.700000,
            ["fInitialDriveMaxFlatVel"] = 240.000000,
            ["fSteeringLock"] = 34.000000,
            ["fInitialDriveForce"] = 0.685000
        },
    },
}

Config.UseGeneralVehicleConfig = false -- change this if you want every EMERGENCY vehicle to be able to change modes (still restricted by Configs.AuthorizedJobs)
Config.EmergencyVehiclesOnly = true -- change this if you want EVERY vehicle to be able to change modes (still restricted by Configs.AuthorizedJobs)
Config.GeneralVehicleConfig = {
    ["B"] = {
        ["fDriveInertia"] = 1.000000,
        ["fBrakeForce"] = 0.500000,
        ["fInitialDriveMaxFlatVel"] = 172.000000,
        ["fSteeringLock"] = 34.000000,
        ["fInitialDriveForce"] = 0.310000
    },
    ["A"] = {
        ["fDriveInertia"] = 1.000000,
        ["fBrakeForce"] = 0.500000,
        ["fInitialDriveMaxFlatVel"] = 175.000000,
        ["fSteeringLock"] = 34.000000,
        ["fInitialDriveForce"] = 0.340000
    },
    ["S"] = {
        ["fDriveInertia"] = 1.000000,
        ["fBrakeForce"] = 0.500000,
        ["fInitialDriveMaxFlatVel"] = 240.000000,
        ["fSteeringLock"] = 34.000000,
        ["fInitialDriveForce"] = 0.380000
    },
}