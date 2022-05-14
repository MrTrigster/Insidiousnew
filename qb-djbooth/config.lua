Config = {}

Config.DefaultVolume = 0.1 -- Accepted values are 0.01 - 1

Config.Locations = {
    ['vanilla'] = {
        ['job'] = 'taxi', -- Required job to use booth
        ['radius'] = 30, -- The radius of the sound from the booth
        ['coords'] = vector3(120.52, -1281.5, 29.48), -- Where the booth is located
        ['playing'] = false
    },
    ['savu'] = {
        ['gang'] = 'racing',
        ['radius'] = 45,
        ['coords'] = vector3(1416.03, 1165.14, 114.34),
        ['playing'] = false
    }
}
