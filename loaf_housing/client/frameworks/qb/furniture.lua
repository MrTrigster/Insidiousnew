CreateThread(function()
    if Config.Framework ~= "qb" then return end
    while not loaded do Wait(500) end

    function SelectFurnitureMenu()
        StartLoading(Strings["fetching_furniture"])
        local furniture = lib.TriggerCallbackSync("loaf_housing:get_furniture")
        StopLoading()

        local elements = {
            {
                header = Strings["your_furniture"],
                isMenuHeader = true
            }
        }
        if furniture and #furniture > 0 then
            for i, v in pairs(furniture) do
                if v.amount > 0 then
                    local _, _, furnitureData = FindFurniture(v.object)
                    furnitureData = furnitureData or {label = v.object, price = 0}

                    table.insert(elements, {
                        header = Strings["owned_furniture"]:format(furnitureData.label, v.amount),
                        params = {
                            args = v.object,
                            event = Furnish,
                            isAction = true
                        }
                    })
                end
            end
        else
            table.insert(elements, {header = Strings["no_furniture"]})
        end

        exports["qb-menu"]:openMenu(elements)
    end

    function PlacedFurnitureMenu(id)
        local elements = {
            {
                header = Strings["manage_furniture"],
                isMenuHeader = true
            },
            {
                header = Strings["select_furniture"],
                params = {
                    event = function()
                        local dialog = exports["qb-input"]:ShowInput({
                            header = Strings["furniture_id"],
                            submitText = "Vali",
                            inputs = {
                                {
                                    text = "Id",
                                    name = "id",
                                    type = "number",
                                    isRequired = true
                                }
                            }
                        })
                        
                        if not dialog or not cache.spawnedFurniture[tonumber(dialog.id)] then 
                            return 
                        end
                        PlacedFurnitureMenu(tonumber(dialog.id))
                    end,
                    isAction = true
                }
            }
        }
        if id then
            elements[1].txt = Strings["current_furniture"]:format(id)
            table.insert(elements, {
                header = Strings["remove_selected"],
                params = {
                    event = function()
                        lib.TriggerCallback("loaf_housing:remove_furniture", function()
                            cache.busy = false
                        end, cache.spawnedFurniture[id].id)
                    end,
                    isAction = true
                }
            })
        end
        exports["qb-menu"]:openMenu(elements)
    end

    function SellSpecificFurniture(args)
        local label, object, amount, price = table.unpack(args)
        exports["qb-menu"]:openMenu({
            {
                header = label,
                isMenuHeader = true
            },
            {
                header = Strings["sell_one"]:format(math.floor(price * Config.FurnitureStore.Resell)),
                params = {
                    event = function()
                        StartLoading(Strings["selling_furniture"])
                        lib.TriggerCallbackSync("loaf_housing:sell_furniture", object, 1)
                        Wait(400)
                        StopLoading()
                        SellFurnitureMenu()
                    end, 
                    isAction = true
                }
            },
            {
                header = Strings["sell_all"]:format(math.floor(amount * price * Config.FurnitureStore.Resell)),
                params = {
                    event = function()
                        StartLoading(Strings["selling_furniture"])
                        lib.TriggerCallbackSync("loaf_housing:sell_furniture", object, amount)
                        Wait(400)
                        StopLoading()
                        SellFurnitureMenu()
                    end, 
                    isAction = true
                }
            }
        })
    end
    function SellFurnitureMenu()
        StartLoading(Strings["fetching_furniture"])
        local furniture = lib.TriggerCallbackSync("loaf_housing:get_furniture")
        StopLoading()
        
        local elements = {
            {
                header = Strings["your_furniture"],
                isMenuHeader = true
            }
        }
        if furniture and #furniture > 0 then
            for i, v in pairs(furniture) do
                if v.amount > 0 then
                    local _, _, furnitureData = FindFurniture(v.object)
                    furnitureData = furnitureData or {label = v.object, price = 0}

                    table.insert(elements, {

                        header = Strings["owned_furniture"]:format(furnitureData.label, v.amount),
                        params = {
                            event = SellSpecificFurniture,
                            args = {furnitureData.label, v.object, v.amount, furnitureData.price},
                            isAction = true
                        }
                    })
                end
            end
        else
            table.insert(elements, {header = Strings["no_furniture"]})
        end
        exports["qb-menu"]:openMenu(elements)
    end

    function FurnitureStoreMenu()
        exports["qb-menu"]:openMenu({
            {
                header = Strings["furniture_purchase_sell"],
                isMenuHeader = true
            },
            {
                header = Strings["purchase_furniture"],
                params = {
                    event = BrowseFurniture,
                    isAction = true
                }
            },
            {
                header = Strings["resell_furniture"],
                params = {
                    event = SellFurnitureMenu,
                    isAction = true
                }
            }
        })
    end
end)