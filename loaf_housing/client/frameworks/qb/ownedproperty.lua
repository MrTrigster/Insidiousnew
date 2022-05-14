CreateThread(function()
    if Config.Framework ~= "qb" then return end
    while not loaded do Wait(500) end

    function DepositRent(propertyId)
        local dialog = exports["qb-input"]:ShowInput({
            header = Strings["rent_amount"],
            submitText = Strings["deposit_rent"],
            inputs = {
                {
                    text = "Summa",
                    name = "amount",
                    type = "number",
                    isRequired = true
                }
            }
        })

        if dialog then
            StartLoading(Strings["depositing_rent"])
            lib.TriggerCallbackSync("loaf_housing:deposit_rent", cache.ownedHouses[tostring(propertyId)].rent, tonumber(dialog.amount))
            StopLoading()
        end
        ManageRent(propertyId)
    end
    function ManageRent(propertyId)
        local houseData = Houses[propertyId]
        local ownedData = cache.ownedHouses[tostring(propertyId)]
        local balance, due = lib.TriggerCallbackSync("loaf_housing:fetch_rent_balance", ownedData.rent)

        local elements = {
            {
                header = Strings["manage_rent"],
                isMenuHeader = true
            },
            {
                header = Strings["rent_balance"]:format(balance),
                isMenuHeader = true
            },
            {
                header = Strings["rent_due"]:format(due),
                isMenuHeader = true
            },
            {
                header = Strings["rent"]:format(houseData.rent),
                isMenuHeader = true
            },
            {
                header = Strings["deposit_rent"],
                params = {
                    event = DepositRent,
                    args = propertyId,
                    isAction = true
                }
            }
        }

        exports["qb-menu"]:openMenu(elements)
    end

    function ConfirmTransfer(data)
        local propertyId, playerName, playerId = table.unpack(data)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")
        
        exports["qb-menu"]:openMenu({
            {
                header = Strings["confirm_transfer_"..houseApart]:format(propertyId, playerName, playerId),
                isMenuHeader = true
            },
            {
                header = Strings["no"]
            },
            {
                header = Strings["yes"],
                params = {
                    event = function()
                        StartLoading(Strings["transferring_"..houseApart])
                        local success, reason = lib.TriggerCallbackSync("loaf_housing:transfer_property", propertyId, playerId)
                        if success then
                            Notify(Strings["transferred_"..houseApart]:format(propertyId, playerName, playerId))
                        elseif reason == "other_owns" then
                            Notify(Strings["other_owns_"..houseApart]:format(playerName, propertyId))
                        end
                        StopLoading()
                    end,
                    isAction = true
                }
            }
        })
    end
    function TransferProperty(propertyId)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")

        local nearbyPlayers = GetPlayers()
        local elements = {
            {
                header = Strings["who_transfer_"..houseApart]:format(propertyId),
                isMenuHeader = true
            }
        }
        for _, v in pairs(nearbyPlayers) do
            table.insert(elements, {
                header = Strings["transfer_to"]:format(v.name, v.serverId),
                params = {
                    event = ConfirmTransfer,
                    args = {propertyId, v.name, v.serverId},
                    isAction = true
                }
            })
        end
        if #nearbyPlayers == 0 then
            table.insert(elements, {
                header = Strings["noone_nearby"]
            })
        end

        exports["qb-menu"]:openMenu(elements)
    end

    function ConfirmSell(propertyId)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")
        local ownedData = cache.ownedHouses[tostring(propertyId)]

        local price = houseData.price or 0
        price = math.floor(price * Config.PropertyResell or 1)

        exports["qb-menu"]:openMenu({
            {
                header = Strings["confirm_sell_"..houseApart]:format(propertyId, FormatNumber(price)),
                isMenuHeader = true
            },
            {
                header = Strings["no"]
            },
            {
                header = Strings["yes"],
                params = {
                    event = function()
                        StartLoading(Strings["selling_"..houseApart])
                        local success, reason = lib.TriggerCallbackSync("loaf_housing:sell_property", propertyId)
                        if success then 
                            Notify(Strings["sold_"..houseApart]:format(FormatNumber(price)))
                        end
                        StopLoading()
                    end,
                    isAction = true
                }
            }
        })
    end

    function OwnPropertyMenu(propertyId)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")
        local ownedData = cache.ownedHouses[tostring(propertyId)]

        local elements = {
            {
                header = Strings["manage_owned_"..houseApart]:format(propertyId),
                isMenuHeader = true
            }
        }
        if houseData.interiortype ~= "walkin" then
            table.insert(elements, {
                header = Strings["enter_"..houseApart],
                params = {
                    event = function()
                        EnterProperty(propertyId, ownedData.id)
                    end,
                    isAction = true
                }
            })
        end
        table.insert(elements, {
            header = Strings["copy_keys"],
            params = {
                event = "loaf_housing:copy_keys",
                isServer = true,
                args = propertyId,
            }
        })
        table.insert(elements, {
            header = Strings["change_lock"],
            params = {
                event = "loaf_housing:change_lock",
                isServer = true,
                args = propertyId,
            }
        })
        table.insert(elements, {
            header = Strings["transfer_"..houseApart],
            params = {
                event = TransferProperty,
                args = propertyId,
                isAction = true
            }
        })
        if ownedData.rent then
            table.insert(elements, {
                header = Strings["manage_rent"],
                params = {
                    event = ManageRent,
                    args = propertyId,
                    isAction = true
                }
            })
        else
            local price = houseData.price or 0
            price = math.floor(price * Config.PropertyResell or 1)

            table.insert(elements, {
                header = Strings["sell_"..houseApart]:format(FormatNumber(price)),
                params = {
                    event = ConfirmSell,
                    args = propertyId,
                    isAction = true
                }
            })
        end
        if not houseData.unique then
            elements[1].txt = Strings["your_"..houseApart.."_id"]:format(ownedData.id)
            if Config.Lockpicking.Enabled then
                table.insert(elements, {
                    header = Strings["lockpick_"..houseApart],
                    params = {
                        event = SelectLockpick,
                        args = propertyId,
                        isAction = true
                    }
                })
            end
            table.insert(elements, {
                header = Strings["enter_other_"..houseApart],
                params = {
                    event = EnterOtherMenu,
                    args = propertyId,
                    isAction = true
                }
            })
        end

        exports["qb-menu"]:openMenu(elements)
    end
end)