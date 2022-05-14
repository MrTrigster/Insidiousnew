Config = {}

Config.UseSoundEffect = true

Config.Elevators = {
    ["PillBoxRestrictedWest"] = {
        Group = {"police", "ambulance"},
        Sound = "liftSoundBellRing",
        Name = "Pillbox Lift",
        Floors = {
            [1] = {
                Label = "Katus (West)",
                FloorDesc = "Lift katusele",
                Restricted = true,
                Coords = vector3(338.28, -584.74, 74.16),
                ExitHeading = "248.13"
            },
            [2] = {
                Label = "Lobby (West)",
                FloorDesc = "Lift haigla korrusele",
                Restricted = false,
                Coords = vector3(330.27, -601.08, 43.28),
                ExitHeading = "70.23"
            },
            [3] = {
                Label = "Garaaz (West)",
                FloorDesc = "Lift parkla korrusele",
                Restricted = false,
                Coords = vector3(339.91, -584.74, 28.8),
                ExitHeading = "69.95"
            },
        }
    },
    ["PillBoxRestrictedEast"] = {
        Group = {"police", "ambulance"},
        Sound = "liftSoundBellRing",
        Name = "Pillbox Lift",
        Floors = {
            [1] = {
                Label = "Katus (East)",
                FloorDesc = "Lift katusele",
                Restricted = true,
                Coords = vector3(339.03, -583.05, 74.16),
                ExitHeading = "250.29"
            },
            [2] = {
                Label = "Lobby (East)",
                FloorDesc = "Lift haigla korrusele",
                Restricted = false,
                Coords = vector3(332.09, -595.77, 43.28),
                ExitHeading = "65.84"
            },
            [3] = {
                Label = "Garaaz (East)",
                FloorDesc = "Lift parkla korrusele",
                Restricted = false,
                Coords = vector3(344.52, -586.2, 28.8),
                ExitHeading = "249.3"
            },
        }
    },
    ["HumaneUnrestricted"] = {
        Sound = "liftSoundBellRing",
        Name = "Humane Labs Lift",
        Floors = {
            [1] = {
                Label = "-1 Korrus",
                FloorDesc = "Lift -1 Korrusele",
                Restricted = false,
                Coords = vector3(3539.62, 3672.71, 28.12),
                ExitHeading = "171.02"
            },
            [2] = {
                Label = "-3",
                FloorDesc = "Lift -3 Korrusele",
                Restricted = false,
                Coords = vector3(3539.65, 3672.89, 20.99),
                ExitHeading = "167.82"
            },
        }
    },
    ['RealEstateRestricted'] = {
        Group = {'rea'},
        Sound = 'liftSoundBellRing',
        Name = 'Kinnisvara Büroo',
        Floors = {
            [1] = {
                Label = 'Penthouse',
                FloorDesc = 'Penthouse Korrus',
                Restricted = true,
                Coords = vector3(371.76, -58.95, 111.96),
                ExitHeading = '249.45',
            },
            [2] = {
                Label = 'Büroo',
                FloorDesc = 'Büroo Korrus',
                Restricted = false,
                Coords = vector3(372.31, -58.74, 103.36),
                ExitHeading = '254.45',
            },
            [3] = {
                Label = '1. Korrus',
                FloorDesc = 'Esiukse Korrus',
                Restricted = false,
                Coords = vector3(388.92, -75.4, 68.18),
                ExitHeading = '156.75',
            },
        }
    }
}

Config.ElevatorButton = {

    ------ / Pill Box Hospital

    -- Restricted/Unrestricted
    [1] = { name = "pillboxGarageWest", location = vector3(339.72, -586.2, 28.8), width = 0.2, length = 0.3, heading = 250, minz = 29.0, maxz = 29.3},
    [2] = { name = "pillboxLobbyWest", location = vector3(329.99, -602.69, 43.28), width = 0.3, length = 0.3, heading = 70, minz = 43.48, maxz = 43.78},
    [3] = { name = "pillboxRoofWest", location = vector3(337.92, -584.46, 74.16), width = 0.3, length = 1.2, heading = 70, minz = 73.16, maxz = 75.41},
    [4] = { name = "pillboxGarageEast", location = vector3(344.72, -584.73, 28.8), width = 0.3, length = 0.3, heading = 70, minz = 29.0, maxz = 29.3},
    [5] = { name = "pillboxLobbyEast", location = vector3(332.02, -597.21, 43.28), width = 0.3, length = 0.3, heading = 341, minz = 43.43, maxz = 43.78},
    [5] = { name = "pillboxRoofEast", location = vector3(338.49, -582.95, 74.16), width = 0.3, length = 1.2, heading = 70, minz = 73.16, maxz = 75.41},

    -- // Humane Labs
    -- Unrestricted
    [6] = { name = "humaneupper", location = vector3(3538.33, 3673.32, 28.12), width = 0.2, length = 0.3, heading = 350, minz = 28.32, maxz = 28.82},
    [7] = { name = "humanelower", location = vector3(3538.26, 3673.26, 20.99), width = 0.2, length = 0.3, heading = 350, minz = 21.24, maxz = 21.69},

    -- // Real Estate
    -- Unrestricted
    [8] = { name = "reahq1", location = vector3(389.46, -74.49, 68.18), width = 0.5, length = 4.2, heading = 340, minz = 67.18, maxz = 69.98},
    [9] = { name = "reahq2", location = vector3(371.52, -58.31, 103.36), width = 0.2, length = 0.3, heading = 70, minz = 103.41, maxz = 103.76},

    -- Restricted
    [10] = { name = "reahq3", location = vector3(371.06, -58.78, 111.96), width = 0.2, length = 0.3, heading = 70, minz = 111.96, maxz = 112.36},

}