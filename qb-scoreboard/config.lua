Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 'F10' -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 64) -- It returnes 64 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ["storerobbery"] = {
        minimum = 0, --2
        busy = false,
    },
    ["bankrobbery"] = {
        minimum = 0, --3
        busy = false,
    },
    ["jewellery"] = {
        minimum = 0, --4
        busy = false,
    },
    ["paleto"] = {
        minimum = 0, --4
        busy = false,
    },
    ["pacific"] = {
        minimum = 0, --5
        busy = false,
    },
}

-- Current Cops Online
Config.CurrentCops = 0

-- Current Ambulance / Doctors Online
Config.CurrentAmbulance = 0

-- Show ID's for all players or Opted in Staff
Config.ShowIDforALL = true