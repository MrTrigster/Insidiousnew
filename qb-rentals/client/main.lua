local QBCore = exports['qb-core']:GetCoreObject()
local SpawnCar = false
local SpawnKopter = false
local SpawnBoat = false

-- Config Options 

local blips = {
    {title= 'Auto Rent', colour= 50, id= 225, x= 111.0112, y= -1088.67, z= 29.302},
    {title= 'Helikopteri Rent', colour= 50, id= 574, x= -1185.79, y= -2826.65, z= 13.95},
    {title= 'Paadi Rent', colour= 50, id= 427, x= -753.55, y= -1512.24, z= 5.02}, 
}

local vehicles = {
    land = {
        [1] = {
            model = 'surge',
            money = 1000,
        },
        [2] = {
            model = 'subn',
            money = 2500,
        },
        [3] = {
            model = 'cog55',
            money = 5000,
        },
    },
    air = {
        [1] = {
            model = 'seasparrow',
            money = 5000,
        },
        [2] = {
            model = 'frogger2',
            money = 9500,
        },
        [3] = {
            model = 'swift',
            money = 20000,
        },
    },
    sea = {
        [1] = {
            model = 'seashark3',
            money = 5000,
        },
        [2] = {
            model = 'dinghy3',
            money = 7500,
        },
        [3] = {
            model = 'longfin',
            money = 10000,
        },
    }
}
-- Vehicle Rentals
local comma_value = function(n) -- credit http://richard.warburton.it
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

RegisterNetEvent('qb-rental:client:openMenu', function(data)
    menu = data.MenuType
    license = data.LicenseType

    if license == 'driving' then
        QBCore.Functions.TriggerCallback('qb-rental:server:checkLicense', function(result)
            if result then
                local vehMenu = {
                    {
                        header = 'Renditavad Sõidukid',
                        isMenuHeader = true,
                    }
                }
                if menu == "vehicle" then
                    vehMenu[#vehMenu + 1] = {
                        header = 'Tagasta Sõiduk',
                        txt = 'Tagasta renditud sõiduk',
                        params = {
                            event = "qb-rental:client:return",
                            args = {
                                menuType = data.MenuType
                            }
                        }
                    }
                    for k=1, #vehicles.land do
                        local veh = QBCore.Shared.Vehicles[vehicles.land[k].model]
                        local name = veh and ('%s %s'):format(veh.brand, veh.name) or vehicles.land[k].model:sub(1,1):upper()..vehicles.land[k].model:sub(2)
                        vehMenu[#vehMenu+1] = {
                            id = k+1,
                            header = name,
                            txt = ("$%s"):format(comma_value(vehicles.land[k].money)),
                            params = {
                                event = "qb-rental:client:spawncar",
                                args = {
                                    model = vehicles.land[k].model,
                                    money = vehicles.land[k].money,
                                }
                            }
                        }
                    end
                end
                exports['qb-menu']:openMenu(vehMenu)
            else
                QBCore.Functions.Notify('Sul ei ole juhilube', 'error')
            end
        end, 'driving')
    elseif license == 'pilot' then
        QBCore.Functions.TriggerCallback('qb-rental:server:checkLicense', function(result)
            if result then
                local vehMenu = {
                    {
                        header = 'Renditavad Sõidukid',
                        isMenuHeader = true,
                    }
                }
                if menu == "aircraft" then
                    vehMenu[#vehMenu + 1] = {
                        header = 'Tagasta Helikopter',
                        txt = 'Tagasta renditud helikopter',
                        params = {
                            event = "qb-rental:client:return",
                            args = {
                                menuType = data.MenuType
                            }
                        }
                    }
                    for k=1, #vehicles.air do
                        local veh = QBCore.Shared.Vehicles[vehicles.air[k].model]
                        local name = veh and ('%s %s'):format(veh.brand, veh.name) or vehicles.air[k].model:sub(1,1):upper()..vehicles.air[k].model:sub(2)
                        vehMenu[#vehMenu+1] = {
                            id = k+1,
                            header = name,
                            txt = ("$%s"):format(comma_value(vehicles.air[k].money)),
                            params = {
                                event = "qb-rental:client:spawncar",
                                args = {
                                    model = vehicles.air[k].model,
                                    money = vehicles.air[k].money,
                                }
                            }
                        }
                    end
                end
                exports['qb-menu']:openMenu(vehMenu)
            else
                QBCore.Functions.Notify('Sul ei ole piloodilube', 'error')
                return
            end
        end, 'pilot')
    elseif license == 'boat' then
        local vehMenu = {
            {
                header = 'Renditavad Sõidukid',
                isMenuHeader = true,
            }
        }
        if menu == "boat" then
            vehMenu[#vehMenu + 1] = {
                header = 'Tagasta Paat',
                txt = 'Tagasta renditud paat',
                params = {
                    event = "qb-rental:client:return",
                    args = {
                        menuType = data.MenuType
                    }
                }
            }
            for k=1, #vehicles.sea do
                local veh = QBCore.Shared.Vehicles[vehicles.sea[k].model]
                local name = veh and ('%s %s'):format(veh.brand, veh.name) or vehicles.sea[k].model:sub(1,1):upper()..vehicles.sea[k].model:sub(2)
                vehMenu[#vehMenu+1] = {
                    id = k+1,
                    header = name,
                    txt = ("$%s"):format(comma_value(vehicles.sea[k].money)),
                    params = {
                        event = "qb-rental:client:spawncar",
                        args = {
                            model = vehicles.sea[k].model,
                            money = vehicles.sea[k].money,
                        }
                    }
                }
            end
        end
        exports['qb-menu']:openMenu(vehMenu)
    end

    -- local vehMenu = {
    --     {
    --         header = 'Renditavad Sõidukid',
    --         isMenuHeader = true,
    --     }
    -- }
    
    -- if menu == "vehicle" then
    --     vehMenu[#vehMenu + 1] = {
    --         header = 'Tagasta Sõiduk',
    --         txt = 'Tagasta renditud sõiduk',
    --         params = {
    --             event = "qb-rental:client:return",
    --             args = {
    --                 menuType = data.MenuType
    --             }
    --         }
    --     }
    --     for k=1, #vehicles.land do
    --         local veh = QBCore.Shared.Vehicles[vehicles.land[k].model]
    --         local name = veh and ('%s %s'):format(veh.brand, veh.name) or vehicles.land[k].model:sub(1,1):upper()..vehicles.land[k].model:sub(2)
    --         vehMenu[#vehMenu+1] = {
    --             id = k+1,
    --             header = name,
    --             txt = ("$%s"):format(comma_value(vehicles.land[k].money)),
    --             params = {
    --                 event = "qb-rental:client:spawncar",
    --                 args = {
    --                     model = vehicles.land[k].model,
    --                     money = vehicles.land[k].money,
    --                 }
    --             }
    --         }
    --     end
    -- elseif menu == "aircraft" then
    --     vehMenu[#vehMenu + 1] = {
    --         header = 'Tagasta Helikopter',
    --         txt = 'Tagasta renditud helikopter',
    --         params = {
    --             event = "qb-rental:client:return",
    --             args = {
    --                 menuType = data.MenuType
    --             }
    --         }
    --     }
    --     for k=1, #vehicles.air do
    --         local veh = QBCore.Shared.Vehicles[vehicles.air[k].model]
    --         local name = veh and ('%s %s'):format(veh.brand, veh.name) or vehicles.air[k].model:sub(1,1):upper()..vehicles.air[k].model:sub(2)
    --         vehMenu[#vehMenu+1] = {
    --             id = k+1,
    --             header = name,
    --             txt = ("$%s"):format(comma_value(vehicles.air[k].money)),
    --             params = {
    --                 event = "qb-rental:client:spawncar",
    --                 args = {
    --                     model = vehicles.air[k].model,
    --                     money = vehicles.air[k].money,
    --                 }
    --             }
    --         }
    --     end
    -- elseif menu == "boat" then
    --     vehMenu[#vehMenu + 1] = {
    --         header = 'Tagasta Paat',
    --         txt = 'Tagasta renditud paat',
    --         params = {
    --             event = "qb-rental:client:return",
    --             args = {
    --                 menuType = data.MenuType
    --             }
    --         }
    --     }
    --     for k=1, #vehicles.sea do
    --         local veh = QBCore.Shared.Vehicles[vehicles.sea[k].model]
    --         local name = veh and ('%s %s'):format(veh.brand, veh.name) or vehicles.sea[k].model:sub(1,1):upper()..vehicles.sea[k].model:sub(2)
    --         vehMenu[#vehMenu+1] = {
    --             id = k+1,
    --             header = name,
    --             txt = ("$%s"):format(comma_value(vehicles.sea[k].money)),
    --             params = {
    --                 event = "qb-rental:client:spawncar",
    --                 args = {
    --                     model = vehicles.sea[k].model,
    --                     money = vehicles.sea[k].money,
    --                 }
    --             }
    --         }
    --     end
    -- end
    -- exports['qb-menu']:openMenu(vehMenu)
end)

local CreateNPC = function()
    -- Vehicle Rentals
    created_ped = CreatePed(5, `a_m_y_business_03` , 109.9739, -1088.61, 28.302, 345.64, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    -- Aircraft Rentals
    created_ped = CreatePed(5, `s_m_y_airworker` , -1185.79, -2826.65, 12.95, 184.65, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    -- Boat Rentals
    created_ped = CreatePed(5, `mp_m_boatstaff_01` , -753.5, -1512.27, 4.02, 25.61, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
end

local SpawnNPC = function()
    CreateThread(function()
        -- Vehicle Rentals
        RequestModel(`a_m_y_business_03`)
        while not HasModelLoaded(`a_m_y_business_03`) do
            Wait(1)
        end
        -- Aircraft Rentals
        RequestModel(`s_m_y_airworker`)
        while not HasModelLoaded(`s_m_y_airworker`) do
            Wait(1)
        end
        -- Aircraft Rentals
        RequestModel(`mp_m_boatstaff_01`)
        while not HasModelLoaded(`mp_m_boatstaff_01`) do
            Wait(1)
        end
        CreateNPC() 
    end)
end

CreateThread(function()
    SpawnNPC()
end)

RegisterNetEvent('qb-rental:client:spawncar', function(data)
    local player = PlayerPedId()
    local money = data.money
    local model = data.model
    if menu == "vehicle" then
        if IsAnyVehicleNearPoint(111.4223, -1081.24, 29.192, 2.0) then
            QBCore.Functions.Notify('Teine sõiduk on ees', 'error')
            return
        end
    elseif menu == "aircraft" then
        if IsAnyVehicleNearPoint(-1178.37, -2845.79, 13.95, 10.0) then 
            QBCore.Functions.Notify('Teine sõiduk on ees', 'error')
            return
        end 
    elseif menu == "boat" then
        if IsAnyVehicleNearPoint(-794.95, -1506.27, 1.08, 10.0) then 
            QBCore.Functions.Notify('Teine sõiduk on ees', 'error')
            return
        end  
    end

    QBCore.Functions.TriggerCallback("qb-rental:server:CashCheck",function(money)
        if money then
            if menu == "vehicle" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, 340.0)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports['LegacyFuel']:SetFuel(vehicle, 100)
                    SpawnCar = true
                end, vector4(111.4223, -1081.24, 29.192,340.0), true)
            elseif menu == "aircraft" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, 332.66)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports['LegacyFuel']:SetFuel(vehicle, 100)
                    SpawnKopter = true
                end, vector4(-1178.37, -2845.79, 13.95, 332.66), true)
            elseif menu == "boat" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, 107.79)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports['LegacyFuel']:SetFuel(vehicle, 100)
                    SpawnBoat = true
                end, vector4(-794.95, -1506.27, 1.08, 107.79), true)
            end 
            Wait(1000)
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel)
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent('qb-rental:server:rentalpapers', plate, vehicleLabel)
        else
            QBCore.Functions.Notify('Sul ei ole piisavalt sularaha', "error", 4500)
        end
    end, money)
end)

RegisterNetEvent('qb-rental:client:return', function(data)
    if data.menuType == 'vehicle' then
        if SpawnCar then
            local Player = QBCore.Functions.GetPlayerData()
            local car = GetVehiclePedIsIn(PlayerPedId(),true)
            local plate = QBCore.Functions.GetPlate(car)
            QBCore.Functions.Notify('Sõiduk Tagastatud', 'success')
            TriggerServerEvent('qb-rental:server:removepapers', plate)
            NetworkFadeOutEntity(car, true,false)
            Wait(2000)
            QBCore.Functions.DeleteVehicle(car)
            SpawnCar = false
        else
            QBCore.Functions.Notify('Pole sõidukit mida tagastada', "error")
        end
    elseif data.menuType == 'aircraft' then
        if SpawnKopter then
            local Player = QBCore.Functions.GetPlayerData()
            local car = GetVehiclePedIsIn(PlayerPedId(),true)
            local plate = QBCore.Functions.GetPlate(car)
            QBCore.Functions.Notify('Helikopter Tagastatud', 'success')
            TriggerServerEvent('qb-rental:server:removepapers', plate)
            NetworkFadeOutEntity(car, true,false)
            Wait(2000)
            QBCore.Functions.DeleteVehicle(car)
            SpawnKopter = false
        else
            QBCore.Functions.Notify('Pole sõidukit mida tagastada', "error")
        end
    elseif data.menuType == 'boat' then
        if SpawnBoat then
            local Player = QBCore.Functions.GetPlayerData()
            local car = GetVehiclePedIsIn(PlayerPedId(),true)
            local plate = QBCore.Functions.GetPlate(car)
            QBCore.Functions.Notify('Paat Tagastatud', 'success')
            TriggerServerEvent('qb-rental:server:removepapers', plate)
            NetworkFadeOutEntity(car, true,false)
            Wait(2000)
            QBCore.Functions.DeleteVehicle(car)
            SpawnBoat = false
        else
            QBCore.Functions.Notify('Pole sõidukit mida tagastada', "error")
        end
    end
end)

CreateThread(function()
    for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.65)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
    end
end)

CreateThread(function()
    local carModel = {
        'a_m_y_business_03'
    }
    exports['qb-target']:AddTargetModel(carModel, {
        options = {
            {
                type = 'client',
                event = 'qb-rental:client:openMenu',
                icon = 'fas fa-car',
                label = 'Rendi Sõiduk',
                MenuType = 'vehicle',
                LicenseType = 'driving',
            },
        },
        distance = 2.5,
    })

    local airModel = {
        's_m_y_airworker',
    }
    exports['qb-target']:AddTargetModel(airModel, {
        options = {
            {
                type = 'client',
                event = 'qb-rental:client:openMenu',
                icon = 'fas fa-plane',
                label = 'Rendi Helikopter',
                MenuType = 'aircraft',
                LicenseType = 'pilot',
            }
        },
        distance = 2.5,
    })

    local boatModel = {
        'mp_m_boatstaff_01'
    }
    exports['qb-target']:AddTargetModel(boatModel, {
        options = {
            {
                type = 'client',
                event = 'qb-rental:client:openMenu',
                icon = 'fas fa-ship',
                label = 'Rendi Paat',
                MenuType = 'boat',
                LicenseType = 'boat',
            }
        },
        distance = 2.5,
    })
end)