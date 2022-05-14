local QBCore = exports['qb-core']:GetCoreObject()
local isDelivering = false
local ZoneName = nil
local deliveryBlip = nil

local function removeTheZone(zoneName)
    CreateThread(function()
        exports['qb-target']:RemoveZone(zoneName)
    end)
end

RegisterNetEvent('qb-fooddelivery:client:startDelivery', function()
    if not isDelivering then
        isDelivering = true
        QBCore.Functions.TriggerCallback('qb-fooddelivery:server:createDeliveryItems', function(item1, item2)
            if item1 and item2 then
                -- print(item1)
                -- print(item2)
                local itemLabel1 = QBCore.Shared.Items[item1].label
                local itemLabel2 = QBCore.Shared.Items[item2].label

                TriggerServerEvent('qb-phone:server:sendNewMail', {
                    sender = "Solk OÜ",
                    subject = "Tellimuse Sisu",
                    message = "Kohale tuleb toimetada:<br />x1 ".. itemLabel1 .. "<br />x1 " .. itemLabel2 .. "<br /><br />Kliendi asukoht on märgitud Teile GPS seadmele.<br /><br />Soovime Teile head kohaletoimetamist.<br /><br />Solk Ltd"
                })

                local deliveryZone = math.random(1, #Config.DeliveryZones)
                local zone = Config.DeliveryZones[deliveryZone]
                ZoneName = zone.name
                local loc = zone.location

                deliveryBlip = AddBlipForCoord(loc.x, loc.y, loc.z)
                SetBlipColour(deliveryBlip, 2)
                SetBlipRoute(deliveryBlip, true)
                SetBlipRouteColour(deliveryBlip, 2)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName('Klient')
                EndTextCommandSetBlipName(deliveryBlip)

                CreateThread(function()
                    exports['qb-target']:AddBoxZone(ZoneName, loc, zone.length, zone.width, {
                        name = ZoneName,
                        heading = zone.heading,
                        debugPoly = false,
                        minZ = zone.minZ,
                        maxZ = zone.maxZ,
                    }, {
                        options = {
                            {
                                icon = 'fas fa-bell',
                                label = 'Toimeta Tellimus Kohale',
                                action = function()
                                    QBCore.Functions.TriggerCallback('qb-fooddelivery:server:checkItems', function(HasItems)
                                        if HasItems then
                                            QBCore.Functions.Progressbar('fooddelivery', 'Koputab uksele...', 3000, false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {
                                                animDict = 'timetable@jimmy@doorknock@',
                                                anim = 'knockdoor_idle',
                                                flags = 0,
                                            }, {}, {}, function()
                                                TriggerServerEvent('qb-fooddelivery:server:finishDelivery', item1, item2)
                                                isDelivering = false
                                                removeTheZone(ZoneName)
                                                RemoveBlip(deliveryBlip)
                                                ClearAllBlipRoutes()
                                            end, function()
                                                QBCore.Functions.Notify('Katkestatud', 'error')
                                            end)
                                        else
                                            QBCore.Functions.Notify('Sul ei ole vajalikke asju', 'error')
                                        end
                                    end, item1, item2)
                                end,
                            }
                        },
                        distance = 2.5,
                    })
                end)
            end
        end)
    else
        TriggerEvent('qb-phone:client:CustomNotification',
            'Solk',
            'Sul on juba tellimus pooleli',
            'fas fa-pepper-hot',
            '#dc143c',
            2500
        )
    end
end)

RegisterNetEvent('qb-fooddelivery:client:cancelDelivery', function()
    if isDelivering then
        isDelivering = false
        removeTheZone(ZoneName)
        RemoveBlip(deliveryBlip)
        ClearAllBlipRoutes()
        TriggerEvent('qb-phone:client:CustomNotification',
            'Solk',
            'Tellimus edukalt tühistatud',
            'fas fa-pepper-hot',
            '#dc143c',
            2500
        )
    else
        TriggerEvent('qb-phone:client:CustomNotification',
            'Solk',
            'Sul ei ole ühtegi tellimust pooleli',
            'fas fa-pepper-hot',
            '#dc143c',
            2500
        )
    end
end)