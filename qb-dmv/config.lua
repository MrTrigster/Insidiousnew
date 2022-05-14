Config = {}

Config.PaymentType = 'bank'                                 -- 'cash' or 'bank' What account to use for payment
Config.DriversTest = true                                   --[[False = Do not have to take the drivers test to get a Drivers License(will give drivers_license after questionairre.) True = Requires you to take Drivers Test to get driver_license]]
Config.SpeedMultiplier = 3.6                                --KM/H = 3.6 MPH = 2.236936
Config.MaxErrors       = 5
Config.UseTarget       = false                              --CURRENTLY NOT WORKING! (recommend leaving false until future update) Gotta fix the target menu to auto change without having to restart qb-target. True will use qb-target instead of qb-menu False will use qb-menu
Config.Ped = 's_m_y_cop_01'                                 --Will Spawn this ped for qb-target if Config.UseTarget is true
Config.GiveItem = true

Config.Amount = {
    ['theoretical'] = 100,                                  --theoretical test payment amount(If Config.DriversTest = false then the theoritical test will go to the drivers test amount.)
    ['driving']     = 250,                                  --Drivers Test Payment Amount
    ['cdl']         = 250                                   --CDL Test Payment Amount
}

Config.Location = {
  ['blip'] = vector3(1139.89, -463.08, 66.88),
  ['marker'] = vector3(1142.5, -463.67, 66.88),
  ['spawn'] = vector4(1146.77, -466.6, 66.55, 256.2)    -- Location to spawn vehicle upon starting Drivers Test
}
Config.Blip = {                                             -- Blip Config
  Sprite = 351,
  Display = 4,
  Color = 0,
  Scale = 1.2,
  ShortRange = true,
  BlipName = 'Autokool'
}

Config.VehicleModels = {
  driver = 'surge',                                         -- Car to spawn with Driver's Test
  cdl = 'stockade'                                          -- Truck to spawn with CDL Test
}

Config.SpeedLimits = {                                      -- Speed Limits in each zone
  residence = 70,
  town      = 120,
  freeway   = 500
}

Config.CheckPoints = {                                      -- Each Cheackpoint for the Drivers Test

  {
    Pos = {x = 1167.92, y = -482.23, z = 64.69},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        DrawMissionText('~r~Anna Teed~s~ vasakult tulevatele ~y~sõidukitele', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('Sõida järgmisesse punkti. ~y~Linnas~s~ kiirusepiirang: ~y~' .. Config.SpeedLimits['residence'] .. 'KM/H', 7500)
      end)
    end
  },

  {
    Pos = {x = 1084.7, y = -514.79, z = 61.79},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 926.18, y = -584.65, z = 56.38},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        DrawMissionText('Peatu ~r~STOP~s~ märgi juures', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText('Sõida järgmisesse punkti', 5000)
      end)
    end
  },

  {
    Pos = {x = 1174.25, y = -762.14, z = 56.67},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 1242.06, y = -1417.12, z = 34.03},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 1321.3, y = -1596.52, z = 51.39},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 1373.39, y = -1581.82, z = 52.64},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      setCurrentZoneType('town')
      DrawMissionText('~y~Maanteel~s~ on kiirusepiirang:~y~ ' .. Config.SpeedLimits['town'] .. 'KM/H', 7500)
    end
  },

  {
    Pos = {x = 2400.48, y = -446.0, z = 71.28},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 2178.81, y = -502.67, z = 91.97},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      setCurrentZoneType('freeway')
      DrawMissionText('~y~Kiirteel~s~ puudub kiirusepiirang: ~r~Sõida ettevaatlikult!', 7500)
      PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },

  {
    Pos = {x = 1348.27, y = -1085.5, z = 51.22},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 1150.83, y = -1138.06, z = 42.86},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 725.12, y = -579.6, z = 34.82},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 625.83, y = -326.15, z = 42.49},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 1019.06, y = 276.52, z = 81.51},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Võta hoogu maha! Linnasisene kiirusepiirang: ~y~' .. Config.SpeedLimits['residence'] .. 'KM/H', 7500)
      PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },

  {
    Pos = {x = 1151.97, y = 359.25, z = 90.4},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      setCurrentZoneType('residence')
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 809.96, y = -31.78, z = 79.63},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 1210.81, y = -353.81, z = 68.13},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText('Peaaegu läbi! Sõida järgmisesse punkti', 5000)
    end
  },

  {
    Pos = {x = 1159.0, y = -472.14, z = 65.47},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      function QBCore.Functions.DeleteVehicle(vehicle)
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
      end
    end
  },

}