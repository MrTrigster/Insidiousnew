-- menus for properties owned by you

CreateThread(function()
    if Config.Framework ~= "esx" then return end
    while not loaded do Wait(500) end

    function ManageRent(wallet, propertyid)
        local elements = {}
        local balance, due = lib.TriggerCallbackSync("loaf_housing:fetch_rent_balance", wallet)
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "manage_rent", {
            title = Strings["manage_rent"],
            align = cache.menuAlign,
            elements = {
                {label = Strings["rent_balance"]:format(balance)},
                {label = Strings["rent_due"]:format(due)},
                {label = Strings["rent"]:format(Houses[propertyid].rent)},
                {
                    label = Strings["deposit_rent"],
                    value = "deposit"
                }
            }
        }, function(data, menu)
            if data.current.value == "deposit" then
                ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "deposit_amount", {
                    title = Strings["rent_amount"]
                }, function(data2, menu2)
                    if not data2.value or not tonumber(data2.value) or tonumber(data2.value) < 0 then return end
                    menu2.close()
                    menu.close()
                    StartLoading(Strings["depositing_rent"])
                    lib.TriggerCallbackSync("loaf_housing:deposit_rent", wallet, tonumber(data2.value))
                    StopLoading()
                    ManageRent(wallet, propertyid)
                end, CloseMenuHandler)
            end
        end, CloseMenuHandler)
    end

    function TransferProperty(propertyid, houseApart)
        local elements, nearbyPlayers = {}, GetPlayers()
        for _, v in pairs(nearbyPlayers) do
            elements[#elements+1] = {
                label = Strings["transfer_to"]:format(v.name, v.serverId),
                name = v.name,
                id = v.serverId
            }
        end
        if #elements == 0 then 
            elements = {{label = Strings["noone_nearby"]}}
        end
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_transfer", {
            title = Strings["who_transfer_"..houseApart]:format(propertyid),
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if not data.current.name then return menu.close() end

            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_transfer", {
                title = Strings["confirm_transfer_"..houseApart]:format(propertyid, data.current.name, data.current.id),
                align = cache.menuAlign,
                elements = {
                    {label = Strings["no"], value = "no"},
                    {label = Strings["yes"], value = "yes"},
                },
            }, function(data2, menu2)
                if data2.current.value == "no" then return menu2.close() end
                CloseMenu()
                StartLoading(Strings["transferring_"..houseApart])
                local success, reason = lib.TriggerCallbackSync("loaf_housing:transfer_property", propertyid, data.current.id)
                if success then
                    Notify(Strings["transferred_"..houseApart]:format(propertyid, data.current.name, data.current.id))
                elseif reason == "other_owns" then
                    Notify(Strings["other_owns_"..houseApart]:format(data.current.name, propertyid))
                end
                StopLoading()
            end, CloseMenuHandler)
        end, CloseMenuHandler)
    end

    function ConfirmSell(propertyid, houseApart, price, formattedPrice)
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_sell", {
            title = Strings["confirm_sell_"..houseApart]:format(propertyid, formattedPrice),
            align = cache.menuAlign,
            elements = {
                {label = Strings["no"], value = "no"},
                {label = Strings["yes"], value = "yes"},
            },
        }, function(data, menu)
            if data.current.value == "no" then return menu.close() end
            CloseMenu()
            StartLoading(Strings["selling_"..houseApart])
            local success, reason = lib.TriggerCallbackSync("loaf_housing:sell_property", propertyid)
            if success then 
                Notify(Strings["sold_"..houseApart]:format(formattedPrice))
            end
            StopLoading()
        end, CloseMenuHandler)
    end

    function OwnPropertyMenu(propertyid)
        ESX.UI.Menu.CloseAll()
        local housedata = Houses[propertyid]
        local houseApart = (housedata.type == "house" and "house" or "apart")
        local elements = {}
        if housedata.interiortype ~= "walkin" then
            table.insert(elements, {
                label = Strings["enter_"..houseApart],
                value = "enter_property"
            })
        end
        table.insert(elements, {
            label = Strings["copy_keys"],
            value = "copy_keys"
        })
        table.insert(elements, {
            label = Strings["change_lock"],
            value = "change_lock"
        })
        table.insert(elements, {
            label = Strings["transfer_"..houseApart],
            value = "transfer_property"
        })
        
        local ownedData = cache.ownedHouses[tostring(propertyid)]
        if ownedData.rent then
            table.insert(elements, {
                label = Strings["manage_rent"],
                value = "manage_rent"
            })
        else
            local price = Houses[propertyid] and Houses[propertyid].price or 0
            price = math.floor(price * Config.PropertyResell or 1)
            table.insert(elements, {
                label = Strings["sell_"..houseApart]:format(FormatNumber(price)),
                value = "sell_property",
                price = price,
                formattedPrice = FormatNumber(price)
            })
        end
        if not housedata.unique then
            table.insert(elements, {
                label = Strings["your_"..houseApart.."_id"]:format(ownedData.id)
            })
            if Config.Lockpicking.Enabled then
                table.insert(elements, {
                    label = Strings["lockpick_"..houseApart],
                    value = "lockpick"
                })
            end
            table.insert(elements, {
                label = Strings["enter_other_"..houseApart],
                value = "enter_other"
            })
        end
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "manage_house", {
            title = Strings["manage_owned_"..houseApart]:format(propertyid),
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value == "enter_property" then
                EnterProperty(propertyid, ownedData.id)
            elseif data.current.value == "copy_keys" then
                TriggerServerEvent("loaf_housing:copy_keys", propertyid)
                menu.close()
            elseif data.current.value == "change_lock" then
                TriggerServerEvent("loaf_housing:change_lock", propertyid)
                menu.close()
            elseif data.current.value == "transfer_property" then
                TransferProperty(propertyid, houseApart)
            elseif data.current.value == "sell_property" then
                ConfirmSell(propertyid, houseApart, data.current.price, data.current.formattedPrice)
            elseif data.current.value == "manage_rent" then
                ManageRent(ownedData.rent, propertyid)
            elseif data.current.value == "enter_other" then
                EnterOtherMenu(propertyid)
            elseif data.current.value == "lockpick" then
                SelectLockpick(propertyid)
            end
        end, CloseMenuHandler)
    end
end)