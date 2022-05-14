CreateThread(function()
    if Config.Framework ~= "qb" then return end
    while not loaded do Wait(500) end

    function OpenWardrobe()
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
        TriggerEvent("qb-clothing:client:openOutfitMenu")
    end

    function ChooseStorageMenu(propertyId, uniqueId, furnitureId, owner)
        if Config.RequireKeyStorage then
            if not exports.loaf_keysystem:HasKey(GetKeyName(propertyId, uniqueId)) then
                return Notify(Strings["need_key_storage"])
            end
        end
            
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

        local inventoryId = propertyId .. "_" .. uniqueId .. "_" .. furnitureId
        inventoryId = inventoryId:gsub("-", "_")

        if not hasWardrobe then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", inventoryId)
            TriggerEvent("InteractSound_CL:PlayOnOne", "StashOpen", 0.4)
            TriggerEvent("inventory:client:SetCurrentStash", inventoryId)
            return
        elseif not hasStorage then
            OpenWardrobe()
            return
        end

        exports["qb-menu"]:openMenu({
            {
                header = Strings["choose_storage"],
                isMenuHeader = true
            },
            {
                header = Strings["storage"],
                params = {
                    event = function()
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", inventoryId)
                        TriggerEvent("InteractSound_CL:PlayOnOne", "StashOpen", 0.4)
                        TriggerEvent("inventory:client:SetCurrentStash", inventoryId)
                    end,
                    isAction = true
                }
            },
            {
                header = Strings["wardrobe"],
                params = {
                    event = OpenWardrobe,
                    isAction = true
                }
            }
        })
    end
end)
