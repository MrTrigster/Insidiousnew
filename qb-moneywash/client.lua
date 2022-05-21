local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('i13-moneywash:client:washMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Calvin Clean',
            txt = 'Mr.Clean peseb ainult hunniku kaupa',
            params = {
                event = 'i13-moneywash:WashClient'
            }
        },
    })
end)

RegisterNetEvent('i13-moneywash:WashClient', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            QBCore.Functions.Progressbar("wash_money", "Peseb raha...", math.random(5000, 10000), false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerServerEvent('i13-moneywash:WashIt')
            end, function() -- Cancel
                QBCore.Functions.Notify("Katkestatud", "error")
            end)
        else
            QBCore.Functions.Notify('Sul ei ole vajalikke asju', 'error')
        end
    end , 'markedbills')
end)

RegisterNetEvent('i13-moneywash:client:sellItems', function()
    TriggerServerEvent('i13-moneywash:server:sellItems')
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('wash', vector3(1126.21, -1241.58, 21.15), 0.5, 1.2, {
        name = 'wash',
        heading = 308,
        debugPoly = false,
        minZ = 20.35,
        maxZ = 22.75
    }, {
        options = {
            {
                type = 'client',
                event = 'i13-moneywash:client:washMenu',
                icon = 'fas fa-bell',
                label = 'Koputa Uksele',
            },
            {
                type = 'client',
                event = 'i13-moneywash:client:sellItems',
                icon = 'fas fa-dollar-sign',
                label = 'Müü Oxy',
                item = 'oxy',
            }
        },
        distance = 1.5,
    })
end)