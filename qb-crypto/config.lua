Crypto = {

    History = {
        ["qbit"] = {}
    },

    Worth = {
        ["qbit"] = 1000
    },
    
    Labels = {
        ["qbit"] = "I13C"
    },

    Exchange = {
        coords = vector3(2068.04, 2993.61, -67.7),
        RebootInfo = {
            state = false,
            percentage = 0
        },
    },

    -- For auto updating the value of qbit
    Coin = 'qbit',
    RefreshTimer = 10, -- In minutes, so every 10 minutes.

    -- Crashes or luck
    ChanceOfCrashOrLuck = 2, -- This is in % (1-100)
    Crash = {20,80}, -- Min / Max
    Luck = {20,45}, -- Min / Max

    -- If not not Chance of crash or luck, then this shit
    ChanceOfDown = 40, -- If out of 100 hits less or equal to
    ChanceOfUp = 60, -- If out of 100 is greater or equal to
    CasualDown = {1,20}, -- Min / Max (If it goes down)
    CasualUp = {1,20}, -- Min / Max (If it goes up)
}
