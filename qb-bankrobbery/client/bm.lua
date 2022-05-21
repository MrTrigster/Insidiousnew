local QBCore = exports['qb-core']:GetCoreObject()
-- boosting stuff pood

RegisterNetEvent('i13-bankrobbery:client:setActivityBusy', function(activity, busy)
    Config.ActivityStatus[activity].status = busy
end)

RegisterNetEvent('i13-bankrobbery:client:openMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Blackmarket',
            txt = '',
            isMenuHeader = true,
        },
        {
            header = 'Status',
            txt = 'Kontrolli röövide staatust',
            params = {
                event = 'i13-bankrobbery:client:checkStatus',
            }
        },
        {
            header = 'Pood',
            txt = 'Osta röövideks varustust',
            params = {
                event = 'i13-bankrobbery:client:openShopMenu',
            }
        },
        {
            header = 'Boosting',
            txt = 'Osta boostimiseks varustust',
            params = {
                event = 'i13-bankrobbery:client:openBoostMenu',
            }
        }
    })
end)

RegisterNetEvent('i13-bankrobbery:client:checkStatus', function()
    local MenuOptions = {}
    MenuOptions[#MenuOptions + 1] = {
        header = 'Pankade Staatus',
        txt = '',
        isMenuHeader = true,
    }
    for k,v in pairs(Config.ActivityStatus) do
        if Config.ActivityStatus[k].status then
            MenuOptions[#MenuOptions + 1] = {
                header = Config.ActivityStatus[k].label,
                txt = 'Cooldown',
                isMenuHeader = true,
            }
        elseif not Config.ActivityStatus[k].status then
            MenuOptions[#MenuOptions + 1] = {
                header = Config.ActivityStatus[k].label,
                txt = 'Saadaval',
                isMenuHeader = true,
            }
        end
    end
    MenuOptions[#MenuOptions + 1] = {
        header = '',
        txt = '⬅ Tagasi',
        params = {
            event = 'i13-bankrobbery:client:openMenu',
        }
    }
    exports['qb-menu']:openMenu(MenuOptions)
end)

RegisterNetEvent('i13-bankrobbery:client:openShopMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Blackmarket Pood',
            txt = '',
            isMenuHeader = true,
        },
        {
            header = 'Hacking Laptop (Harjutamiseks)',
            txt = '75 INC',
            params = {
                event = 'i13-bankrobbery:client:buyShopItem',
                args = 1,
            }
        },
        {
            header = 'Hacking Laptop (Fleeca Pank)',
            txt = '85 INC',
            params = {
                event = 'i13-bankrobbery:client:buyShopItem',
                args = 2,
            }
        },
        {
            header = 'Hacking Laptop (Paleto Pank)',
            txt = '95 INC',
            params = {
                event = 'i13-bankrobbery:client:buyShopItem',
                args = 3,
            }
        },
        {
            header = 'Hacking Laptop (Pacific Pank)',
            txt = '110 INC',
            params = {
                event = 'i13-bankrobbery:client:buyShopItem',
                args = 4,
            }
        },
        {
            header = 'Electronic Kit',
            txt = '50 INC',
            params = {
                event = 'i13-bankrobbery:client:buyShopItem',
                args = 5,
            }
        },
        {
            header = '',
            txt = '⬅ Tagasi',
            params = {
                event = 'i13-bankrobbery:client:openMenu',
            }
        }
    })
end)

RegisterNetEvent('i13-bankrobbery:client:openBoostMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Boosting Pood',
            txt = '',
            isMenuHeader = true,
        },
        {
            header = 'Boosting Laptop',
            txt = '80 INC',
            params = {
                event = 'i13-bankrobbery:client:buyBoostingItem',
                args = 1,
            }
        },
        {
            header = 'Disabler',
            txt = '40 INC',
            params = {
                event = 'i13-bankrobbery:client:buyBoostingItem',
                args = 2,
            }
        },
        {
            header = '',
            txt = '⬅ Tagasi',
            params = {
                event = 'i13-bankrobbery:client:openMenu',
            }
        }
    })
end)

RegisterNetEvent('i13-bankrobbery:client:buyShopItem', function(item)
    if item == 1 then
        TriggerServerEvent('i13-bankrobbery:server:buyTestLaptop')
    elseif item == 2 then
        TriggerServerEvent('i13-bankrobbery:server:buyFleecaLaptop')
    elseif item == 3 then
        TriggerServerEvent('i13-bankrobbery:server:buyPaletoLaptop')
    elseif item == 4 then
        TriggerServerEvent('i13-bankrobbery:server:buyPacificLaptop')
    elseif item == 5 then
        TriggerServerEvent('i13-bankrobbery:server:buyElectronicKit')
    end
end)

RegisterNetEvent('i13-bankrobbery:client:buyBoostingItem', function(item)
    if item == 1 then
        TriggerServerEvent('i13-bankrobbery:server:buyBoostingLaptop')
    elseif item == 2 then
        TriggerServerEvent('i13-bankrobbery:server:buyDisabler')
    end
end)

-- Threads

CreateThread(function()
    local pedModel = `s_m_y_xmech_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector4(-593.53, -1766.5, 23.18, 245.17)

    ped = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, loc.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('bankBM', vector3(-593.51, -1766.48, 23.18), 0.7, 0.7, {
        name = 'bankBM',
        heading = 60,
        debugPoly = false,
        minZ = 22.18,
        maxZ = 24.03
    }, {
        options = {
            {
                type = 'client',
                event = 'i13-bankrobbery:client:openMenu',
                icon = 'fas fa-comment',
                label = 'Räägi Isikuga',
            }
        },
        distance = 1.5,
    })
end)
