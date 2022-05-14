CreateThread(function()
    if Config.Framework ~= "esx" then return end
    while not loaded do Wait(500) end

    local function GetAmount(action)
        local finished, amount = false, 0
        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "amount", {
            title = Strings["amount_"..action]
        }, function(data, menu)
            if data.value and tonumber(data.value) and tonumber(data.value) > 0 then
                amount = tonumber(data.value)
            end
            finished = true
            menu.close()
        end, function(data, menu)
            menu.close()
            finished = true
        end)

        while not finished do
            Wait(50)
        end
        return amount
    end

    local function GetStorage(propertyId, uniqueId, furnitureId)
        if cache.inInstance then
            return cache.currentInstance.furniture[furnitureId]
        end
        return lib.TriggerCallbackSync("loaf_housing:get_storage", propertyId, uniqueId, furnitureId)
    end

    function SelectItemDepositWithdraw(propertyId, uniqueId, furnitureId, action, itemOrWeapon, items, weapons)
        if not items or not weapons then
            if action == "withdraw" then
                local storage = GetStorage(propertyId, uniqueId, furnitureId)
                items, weapons = storage.items, storage.weapons
            else
                _, _, items, weapons = lib.TriggerCallbackSync("loaf_housing:get_inventory")
            end
        end

        local elements = {}
        if itemOrWeapon == "items" then
            for i, v in pairs(items) do
                if (action == "deposit" and v.count > 0) or (action == "withdraw" and v.amount > 0) then
                    table.insert(elements, {
                        label = ("x%s %s"):format(v.amount or v.count, v.label),
                        value = v
                    })
                end
            end
        elseif itemOrWeapon == "weapons" then
            for k, v in pairs(weapons) do
                table.insert(elements, {
                    label = v.label,
                    value = action == "withdraw" and k or v.name
                })
            end
        end

        if #elements == 0 then
            table.insert(elements, {label = Strings["empty"]})
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_item", {
            title = Strings[action],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            local value = data.current.value
            if not value then 
                return 
            end

            if itemOrWeapon == "items" then
                local amount = GetAmount(action)
                if amount <= 0 then 
                    return 
                end

                if (action == "withdraw" and value.amount < amount) or (action == "deposit" and value.count < amount) then 
                    return Notify(Strings[action == "withdraw" and "storage_not_enough" or "dont_have"]) 
                end

                lib.TriggerCallback("loaf_housing:"..action.."_item", function(success)
                    if success then 
                        if cache.inInstance then
                            cache.currentInstance.furniture = success
                        end
                        menu.close()
                        SelectItemDepositWithdraw(propertyId, uniqueId, furnitureId, action, itemOrWeapon)
                    end
                end, propertyId, uniqueId, furnitureId, (action == "withdraw" and value.item) or value.name, amount)
            elseif itemOrWeapon == "weapons" then
                lib.TriggerCallback("loaf_housing:"..action.."_weapon", function(success)
                    if success then 
                        if cache.inInstance then
                            cache.currentInstance.furniture = success
                        end
                        menu.close()
                        SelectItemDepositWithdraw(propertyId, uniqueId, furnitureId, action, itemOrWeapon)
                    end
                end, propertyId, uniqueId, furnitureId, value)
            end
        end, CloseMenuHandler)
    end

    function DepositWithdraw(propertyId, uniqueId, furnitureId, action)
        local money, dirty, items, weapons
        if action == "withdraw" then
            local storage = GetStorage(propertyId, uniqueId, furnitureId)
            money, dirty, items, weapons = storage.money.cash, storage.money.dirty, storage.items, storage.weapons
        else
            money, dirty, items, weapons = lib.TriggerCallbackSync("loaf_housing:get_inventory")
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), action, {
            title = Strings[action],
            align = cache.menuAlign,
            elements = {
                {
                    label = Strings[action.."_money"]:format(FormatNumber(money)),
                    value = "cash"
                },
                {
                    label = Strings[action.."_dirty"]:format(FormatNumber(dirty)),
                    value = "dirty"
                },
                {
                    label = Strings[action.."_items"],
                    value = "items"
                },
                {
                    label = Strings[action.."_weapons"],
                    value = "weapons"
                },
            }
        }, function(data, menu)
            local value = data.current.value
            if value == "cash" or value == "dirty" then
                local amount = GetAmount(action)
                if amount <= 0 then 
                    return 
                end

                lib.TriggerCallback("loaf_housing:"..action.."_money", function(success)
                    if success then 
                        if cache.inInstance then
                            cache.currentInstance.furniture = success
                        end
                        menu.close()
                        DepositWithdraw(propertyId, uniqueId, furnitureId, action)
                    end
                end, propertyId, uniqueId, furnitureId, value, amount)
            elseif value == "items" or value == "weapons" then
                SelectItemDepositWithdraw(propertyId, uniqueId, furnitureId, action, value, items, weapons)
            end
        end, CloseMenuHandler)
    end

    function OpenStorage(propertyId, uniqueId, furnitureId, owner)
        if Config.RequireKeyStorage then
            if not exports.loaf_keysystem:HasKey(GetKeyName(propertyId, uniqueId)) then
                return Notify(Strings["need_key_storage"])
            end
        end

        local inventoryId = propertyId .. "_" .. uniqueId .. "_" .. furnitureId
        if Config.Inventory == "ox" then
            exports.ox_inventory:openInventory("stash", {id = inventoryId, owner = owner})
            return
        elseif Config.Inventory == "chezza" then
            TriggerEvent("inventory:openHouse", owner, inventoryId, Strings["inventory"], 25000)
            return
        elseif Config.Inventory == "modfreakz" then
            exports["mf-inventory"]:openOtherInventory(inventoryId)
            return
        end
        
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "deposit_withdraw", {
            title = Strings["deposit_withdraw"],
            align = cache.menuAlign,
            elements = {
                {
                    label = Strings["deposit"],
                    value = "deposit"
                },
                {
                    label = Strings["withdraw"],
                    value = "withdraw"
                }
            }
        }, function(data, menu)
            DepositWithdraw(propertyId, uniqueId, furnitureId, data.current.value)
        end, CloseMenuHandler)
    end

    -- wardrobe / outfits
    local function ManageOutfit(outfits, id)
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "manage_outfit", {
            title = outfits[id],
            align = cache.menuAlign,
            elements = {
                {
                    label = Strings["equip_outfit"], 
                    value = "equip"
                },
                {
                    label = Strings["delete_outfit"],
                    value = "delete"
                }
            }
        }, function(data, menu)
            if data.current.value == "equip" then
                lib.TriggerCallback("loaf_housing:get_outfit", function(outfit)
                    if not outfit then return end

                    if GetResourceState("fivem-appearance") == "started" then
                        TriggerEvent("fivem-appearance:setOutfit", outfit)
                    else
                        TriggerEvent("skinchanger:getSkin", function(skin)
                            TriggerEvent("skinchanger:loadClothes", skin, outfit)
                            TriggerEvent("esx_skin:setLastSkin", skin)

                            TriggerEvent("skinchanger:getSkin", function(skin)
                                TriggerServerEvent("esx_skin:save", skin)
                            end)
                        end)
                    end
                end, id)
                return
            end

            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_delete_outfit", {
                title = Strings["confirm_delete_outfit"]:format(outfits[id]),
                align = cache.menuAlign,
                elements = {
                    {label = Strings["no"]},
                    {
                        label = Strings["yes"], 
                        delete = true
                    }
                }
            }, function(data2, menu2)
                if not data2.current.delete then return menu2.close() end
                lib.TriggerCallback("loaf_housing:delete_outfit", function(outfits)
                    ESX.UI.Menu.CloseAll()
                    OpenWardrobe(outfits)
                end, id)
            end, CloseMenuHandler)
        end, CloseMenuHandler)
    end

    function OpenWardrobe(outfits)
        if not outfits then outfits = lib.TriggerCallbackSync("loaf_housing:get_outfits") end
        local elements = {}
        for k, v in pairs(outfits) do
            table.insert(elements, {label = v, id = k})
        end

        if #elements == 0 then
            table.insert(elements, {label = Strings["no_outfits"]})
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_outfit", {
            title = Strings["select_outfit"],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if not data.current.id then return menu.close() end
            ManageOutfit(outfits, data.current.id)
        end, CloseMenuHandler)
    end

    -- select wardrobe or storage
    function ChooseStorageMenu(propertyId, uniqueId, furnitureId, owner)
        CloseMenu()
        local houseData = Houses[propertyId]

        local hasWardrobe, hasStorage
        local locations = houseData.locations

        if not locations and houseData.interior and Config.Interiors[houseData.interior] and Config.Interiors[houseData.interior].locations then
            locations = Config.Interiors[houseData.interior].locations
        end

        if not locations or not locations[furnitureId] then
            hasWardrobe = Config.Wardrobe
            hasStorage = true
        else 
            hasWardrobe = locations[furnitureId].wardrobe
            hasStorage = locations[furnitureId].storage
        end

        if not hasWardrobe then
            OpenStorage(propertyId, uniqueId, furnitureId, owner)
            return
        elseif not hasStorage then
            OpenWardrobe()
            return
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "choose_storage", {
            title = Strings["choose_storage"],
            align = cache.menuAlign,
            elements = {
                {
                    label = Strings["storage"],
                    value = "storage"
                },
                {
                    label = Strings["wardrobe"],
                    value = "wardrobe"
                }
            }
        }, function(data, menu)
            if data.current.value == "storage" then
                OpenStorage(propertyId, uniqueId, furnitureId, owner)
            elseif data.current.value == "wardrobe" then
                OpenWardrobe()
            end
        end, CloseMenuHandler)
    end
end)