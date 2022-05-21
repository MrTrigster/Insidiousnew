local minute = 60
local hour = 60 * minute
local day = 24 * hour
local week = 7 * day
local month = 30 * day
local year = 365 * day

Config = {
    Framework = "qb", --[[
        Valid options:
            * esx       - ESX v1.1, v1.2, v1 final, esx legacy, overextended
            * qb        - qbcore 
    --]]
    
    SpawnAboveHouse = true, --[[
        should the shell be spawned above the house/apartment? 
        pros: 
            no real limit on the amount of shells that can be spawned 
            it will look like the player is at the correct location at the map
        cons: 
            depending on your voice script, players may hear each other
    --]]
    -- Target = "qtarget", --[[ -- not yet finished
    --     Target system to use, set to false if you want to use "Press E ..."
    --     supported:
    --         "qtarget" - qtarget: https://github.com/BerkieBb/qb-target, https://www.youtube.com/watch?v=oWyukyZHtcI
    --         "i13-target" - qb-target: https://github.com/BerkieBb/qb-target, 
    -- --]]


    RentInterval = week,

    SpawnRestart = true, -- spawn players inside the house if they are inside a house and the server restarts?
    SpawnDisconnect = true, -- spawn inside the house if you disconnect while inside? false = spawn at the door instead

    BackupRemovedHouse = true, -- save all houses that are removed (sold/deleted due to inactivity/rent) to a backup file
    MaxProperties = 3, -- the max amount of properties (apartments + houses) a player can own

    InteractableFurniture = true,
    FurnitureStoreLight = true,

    PreviewProperty = true, -- allow players to preview the house/apartment before purchasing it?
    SelectShell = false, -- allow players to choose the shell when purchasing?

    FurnishCommand = {
        Enabled = true,
        Command = "furnish"
    },

    Key = {
        DistanceCheck = true, -- check if the player is nearby the door when using a key (false = can lock/unlock from anywhere, true = must be at the door)
        Distance = 5.0, -- the distance within the door they must be, if DistanceCheck is enabled
    },

    UseRPName = true, -- use the in-game name when giving house?
    Furnish = "key", -- either all, key or owner. all: everyone can furnish key: you must have a key to furnish owner: you must own the property to furnish
    PropertyResell = 0.4, -- the % you get back of the original price when selling a property, 1 = 100%

    FurnitureStore = {
        Entrance = vector4(339.28, -777.14, 29.27, 249.2),
        Interior = vector3(45.34, -1771.77, 29.4),
        Camera = vector3(45.11, -1764.03, 34.0),
        CameraRotation = vector3(-30.72, 0.0, -178.3),
        Heading = 180.0,
        Resell = 0.40, -- the % you get back of the original price when selling furniture, 1 = 100%
    },

    Lockpicking = {
        Enabled = false,
        Police = { -- the jobs that will get notified when someone lockpicks a house
            "police",
            "sheriff"
        },
        MinimumPolice = 1,
    },

    PoliceRaid = {
        Enabled = true,
        Jobs = {
            -- ["job name"] = minimum grade to breach door,
            ["police"] = 1,
            ["sheriff"] = 1,
        },
    },

    Inventory = "default", --[[
        default - default housing, esx: menu based, qb-core: default qb-inventory
        ox - ox_inventory (free): https://github.com/overextended/ox_inventory
        chezza - chezza inventory (paid): https://store.chezza.dev/package/4770357
        modfreakz - modfreakz inventory (paid): https://modit.store/products/mf-inventory
    ]]

    RequireKeyStorage = true, -- require user to have a key to access the storage?
    Wardrobe = true, -- allow people to change outfits?

    Garage = false, -- allow garages? REQUIRES https://store.loaf-scripts.com/package/4310876 

    Realtor = { -- REQUIRES https://store.loaf-scripts.com/package/4457135
        enabled = true, -- enable realtor job? (will fetch houses from database instead of config file)
        requireRealtor = true, -- require to purchase from a realtor, or allow purchasing from a circle?
    },

    ShellPacks = { -- set all packs you have bought to true here
        ["Main Housing Bundle"] = true, -- purchase here: https://www.k4mb1maps.com/package/4673316
        ["Classic Housing"] = false, -- https://www.k4mb1maps.com/package/4673140
        ["Hotel Housing"] = false, -- purchase here: https://www.k4mb1maps.com/package/4811134
        ["Motel Housing"] = false, -- purchase here: https://www.k4mb1maps.com/package/4811137
        ["Deluxe Housing V1"] = false, -- purchase here: https://www.k4mb1maps.com/package/4673159
        ["Highend Housing V1"] = false, -- purchase here: https://www.k4mb1maps.com/package/4673131
        ["Mansion Housing"] = false, -- purchase here: https://www.k4mb1maps.com/package/4783251
        ["Medium Housing V1"] = false, -- purchase here: https://www.k4mb1maps.com/package/4672307
        ["Modern Housing V1"] = false, -- purchase here: https://www.k4mb1maps.com/package/4673169
        
        -- V2 PACKS
        ["Default Housing V2"] = false, -- purchase here: https://www.k4mb1maps.com/package/5015832
        ["Medium Housing V2"] = false, -- purchase here: https://www.k4mb1maps.com/package/5043821
        ["Modern Housing V2"] = false, -- purchase here: https://www.k4mb1maps.com/package/5043818
        ["Deluxe Housing V2"] = false, -- purchase here: https://www.k4mb1maps.com/package/5043817
        ["Highend Housing V2"] = false, -- purchase here: https://www.k4mb1maps.com/package/5043819
    
        -- misc k4mb1 shells
        ["Highend Lab Shells"] = false, -- purchase here: https://www.k4mb1maps.com/package/4698329
        ["Lab Shells Pack"] = false, -- purchase here: https://www.k4mb1maps.com/package/4672285
        ["Furnished Modern Hotels Pack"] = false,
        ["Furnished Housing"] = false, -- purchase here: https://www.k4mb1maps.com/package/4672272
        ["Motel Shells Pack"] = false, -- purchase here: https://www.k4mb1maps.com/package/4672296
        ["Stash Houses"] = false, -- purchase here: https://www.k4mb1maps.com/package/4672293
        ["Garage Shells Pack"] = false, -- purchase here: https://www.k4mb1maps.com/package/4673177
        ["Office Shells Pack"] = false, -- purchase here: https://www.k4mb1maps.com/package/4673258
    },

    Blip = {--https://docs.fivem.net/docs/game-references/blips/
        forSale = { -- if no one owns the house
            enabled = false,
            sprite = 350,
            color = 0,
            scale = 0.5
        },
        owned = { -- if the player owns the house
            enabled = true,
            sprite = 40,
            color = 2,
            scale = 1.0
        },
        ownedOther = { -- if another player owns the house
            enabled = false,
            sprite = 40,
            color = 3,
            scale = 0.75
        },
        furnitureStore = {
            enabled = true,
            sprite = 605,
            color = 0,
            scale = 0.75
        },
    },

    Interiors = { -- https://wiki.rage.mp/index.php?title=Interiors_and_Locations
        -- ["modern_apartment_1"] = {
        --     label = "Modern apartment 1",
        --     coords = vector3(-786.8663, 315.7642, 216.6385),
        --     ipl = "apa_v_mp_h_01_a",
        --     disableFurnishing = true,
        --     lockpick = 1,
        --     locations = {
        --         -- the key here is a unique identifier which will be used for storage
        --         ["location_1"] = {
        --             coords = vector3(-795.96, 327.43, 217.04),
        --             scale = vector3(3.0, 3.0, 0.5),
        --             storage = true,
        --             wardrobe = false,
        --             weight = 50000, -- storage weight limit
        --         },
        --         ["location_2"] = {
        --             coords = vector3(-797.58, 328.29, 220.44),
        --             scale = vector3(3.0, 3.0, 0.5),
        --             storage = false,
        --             wardrobe = true,
        --         },
        --     },
        -- },
    },
}

exports("GetConfig", function()
    return Config
end)