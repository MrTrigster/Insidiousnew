-- menus for furniture

CreateThread(function()
    if Config.Framework ~= "esx" then return end
    while not loaded do Wait(500) end

    function SelectFurnitureMenu()
        StartLoading(Strings["fetching_furniture"])
        lib.TriggerCallback("loaf_housing:get_furniture", function(furniture)
            local elements = {}
            if furniture and #furniture > 0 then
                for i, v in pairs(furniture) do
                    if v.amount > 0 then
                        local _, _, furnitureData = FindFurniture(v.object)
                        furnitureData = furnitureData or {label = v.object, price = 0}

                        table.insert(elements, {
                            label = Strings["owned_furniture"]:format(furnitureData.label, v.amount),
                            price = furnitureData.price,
                            object = v.object,
                            amount = v.amount,
                            index = i
                        })
                    end
                end
            else
                table.insert(elements, {label = Strings["no_furniture"]})
            end

            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_furniture", {
                title = Strings["your_furniture"],
                align = cache.menuAlign,
                elements = elements
            }, function(data, menu)
                menu.close()
                if not data.current.object then 
                    return 
                end
                Furnish(data.current.object)
            end, CloseMenuHandler)

            StopLoading()
        end)
    end

    function PlacedFurnitureMenu(id)
        local elements = {
            {
                label = Strings["select_furniture"],
                value = "select"
            }
        }
        if id then
            table.insert(elements, {
                label = Strings["current_furniture"]:format(id)
            })
            table.insert(elements, {
                label = Strings["remove_selected"],
                value = "remove"
            })
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "placed_furniture", {
            title = Strings["manage_furniture"],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value == "select" then
                ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "furniture_id", {
                    title = Strings["furniture_id"]
                }, function(data2, menu2)
                    menu2.close()
                    local furnitureId = tonumber(data2.value)
                    if furnitureId and cache.spawnedFurniture[furnitureId] then
                        menu.close()
                        PlacedFurnitureMenu(furnitureId)
                    end
                end, CloseMenuHandler)
            elseif data.current.value == "remove" then
                lib.TriggerCallback("loaf_housing:remove_furniture", function()
                    menu.close()
                    cache.busy = false
                end, cache.spawnedFurniture[id].id)
            end
        end, function(data, menu)
            menu.close()
            cache.busy = false
        end)
    end

    function SellFurnitureMenu()
        StartLoading(Strings["fetching_furniture"])
        lib.TriggerCallback("loaf_housing:get_furniture", function(furniture)
            local elements = {}
            if furniture and #furniture > 0 then
                for i, v in pairs(furniture) do
                    if v.amount > 0 then
                        local _, _, furnitureData = FindFurniture(v.object)
                        furnitureData = furnitureData or {label = v.object, price = 0}

                        table.insert(elements, {
                            label = Strings["owned_furniture"]:format(furnitureData.label, v.amount),
                            price = furnitureData.price,
                            object = v.object,
                            amount = v.amount,
                            index = i
                        })
                    end
                end
            else
                table.insert(elements, {label = Strings["no_furniture"]})
            end

            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "sell_furniture", {
                title = Strings["your_furniture"],
                align = cache.menuAlign,
                elements = elements
            }, function(data, menu)
                local data = data.current
                if not data.object then 
                    return menu.close() 
                end
                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "sell_one_multiple", {
                    title = data.label,
                    align = cache.menuAlign,
                    elements = {
                        {
                            label = Strings["sell_one"]:format(math.floor(data.price * Config.FurnitureStore.Resell)),
                            value = "sell_one"
                        },
                        {
                            label = Strings["sell_all"]:format(math.floor(data.amount * data.price * Config.FurnitureStore.Resell)),
                            value = "sell_all"
                        }
                    }
                }, function(data2, menu2)
                    StartLoading(Strings["selling_furniture"])
                    if data2.current.value == "sell_one" then
                        lib.TriggerCallbackSync("loaf_housing:sell_furniture", data.object, 1)
                    elseif data2.current.value == "sell_all" then
                        lib.TriggerCallbackSync("loaf_housing:sell_furniture", data.object, data.amount)
                    end
                    Wait(400)
                    StopLoading()
                    menu.close()
                    menu2.close()
                    SellFurnitureMenu()
                end, CloseMenuHandler)
            end, CloseMenuHandler)

            StopLoading()
        end)
    end

    function FurnitureStoreMenu()
        CloseMenu()
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "furniture_purchase_sell", {
            title = Strings["furniture_purchase_sell"],
            align = cache.menuAlign,
            elements = {
                {label = Strings["purchase_furniture"], value = "purchase"},
                {label = Strings["resell_furniture"], value = "sell"}
            }
        }, function(data, menu)
            if data.current.value == "purchase" then
                menu.close()
                BrowseFurniture()
            elseif data.current.value == "sell" then
                SellFurnitureMenu()
            end
        end, CloseMenuHandler)
    end
end)