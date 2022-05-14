RegisterNetEvent("loaf_housing:set_houses", function(houses)
    while not cache.ownedHouses do
        Wait(0)
    end
    Wait(1000)

    for id, house in pairs(Houses) do
        if house.marker then
            lib.RemoveMarker(house.marker)
        end

        if house.garageMarker then
            lib.RemoveMarker(house.garageMarker.store)
            lib.RemoveMarker(house.garageMarker.retrieve)
            house.garageMarker = nil
        end

        if house.blip then
            lib.RemoveBlip(house.blip)
        end
    end
    Houses = houses
    ReloadBlips(true)
end)

RegisterNetEvent("loaf_housing:spawn_in_property", function(propertyId, cb)
    propertyId = tonumber(propertyId)
    local propertyData = Houses[propertyId]
    if not propertyData then
        Teleport(vector4(195.17, -933.77, 29.7, 144.5))
        if cb then cb() end
        return
    end

    local stringId = tostring(propertyId)
    if not cache.ownedHouses[stringId] then
        Teleport(propertyData.entrance - vector4(0.0, 0.0, 1.0, 0.0))
    else
        EnterProperty(propertyId, cache.ownedHouses[stringId].id)
    end
    if cb then cb() end
end)

RegisterNetEvent("loaf_housing:update_houses", function(houses)
    local new_ownedHouses = {}
    local new_houses = {}
    for _, house in pairs(houses) do
        local stringId = tostring(house.propertyid)
        if house.owner == cache.identifier then
            new_ownedHouses[stringId] = house
        else
            new_houses[stringId] = house
        end
    end
    cache.ownedHouses = new_ownedHouses
    cache.houses = new_houses
    ReloadBlips()
end)

function HouseMenuHandler(data)
    local action, propertyId = table.unpack(data)
    local stringId = tostring(propertyId)
    if action == "use" then
        if cache.busy then return end
        
        if cache.ownedHouses[stringId] then
            OwnPropertyMenu(propertyId)
        elseif cache.houses[stringId] and Houses[propertyId].unique then
            UniqueOwnedMenu(propertyId, cache.houses[stringId].id)
        elseif not Houses[propertyId].unique then
            EnterPurchaseMenu(propertyId)
        else
            local amountProperties = 0
            for _ in pairs(cache.ownedHouses) do
                amountProperties = amountProperties + 1
            end
            if Config.MaxProperties > amountProperties then
                PurchaseMenu(propertyId)
            else
                Notify(Strings["owns_max"])
            end
        end
    elseif action == "exit" then
        CloseMenu()
    end
end

function ReloadBlips(reloadMarkers)
    -- create blips, markers etc
    for id, house in pairs(Houses) do
        Wait(0)

        if house.blip then
            lib.RemoveBlip(house.blip)
        end

        if cache.ownedHouses[tostring(id)] then
            if Config.Blip.owned.enabled then
                house.blip = lib.AddBlip({
                    coords = house.entrance.xyz,
                    sprite = Config.Blip.owned.sprite,
                    color = Config.Blip.owned.color,
                    scale = Config.Blip.owned.scale,
                    category = 11,
                    label = house.type == "house" and Strings["own_house"] or Strings["own_apart"]
                })
            end
        elseif cache.houses[tostring(id)] then
            if Config.Blip.ownedOther.enabled then
                house.blip = lib.AddBlip({
                    coords = house.entrance.xyz,
                    sprite = Config.Blip.ownedOther.sprite,
                    color = Config.Blip.ownedOther.color,
                    scale = Config.Blip.ownedOther.scale,
                    category = 10,
                    label = house.type == "house" and Strings["ply_own_house"] or Strings["ply_own_apart"]
                })
            end
        else
            if Config.Blip.forSale.enabled then
                house.blip = lib.AddBlip({
                    coords = house.entrance.xyz,
                    sprite = Config.Blip.forSale.sprite,
                    color = Config.Blip.forSale.color,
                    scale = Config.Blip.forSale.scale,
                    category = 10,
                    label = house.type == "house" and Strings["purchase_house_blip"] or Strings["purchase_apart_blip"]
                })
            end
        end

        if Config.Garage and cache.ownedHouses[tostring(id)] then
            local shouldAddMarker = false
            if GetResourceState("loaf_garage") == "started" or GetResourceState("cd_garage") == "started" then
                shouldAddMarker = true
            end

            if house.garage then
                if not shouldAddMarker and GetResourceState("qb-garages") == "started" then
                    if not house.garageMarker then
                        house.garageMarker = lib.AddMarker({
                            coords = house.garage.exit.xyz - vector3(0.0, 0.0, 1.0),
                            alpha = 0,
                            scale = vector3(15.0, 15.0, 2.0),
                            callbackData = {},
                        }, function()
                            if house.inMarker then
                                return
                            end
                            house.inMarker = true

                            CreateThread(function()
                                while house.inMarker do -- needed due to qb-houses setting closest house every so often..
                                    Wait(50)
                                    TriggerEvent("qb-garages:client:addHouseGarage", id, {
                                        takeVehicle = house.garage.exit,
                                        spawnPoint = house.garage.exit,
                                        label = "Property Garage"
                                    })
                                    TriggerEvent("qb-garages:client:setHouseGarage", id, true)
                                end
                            end)
                        end, nil, function()
                            house.inMarker = false
                        end)
                    end
                elseif not shouldAddMarker and GetResourceState("rcore_garage") == "started" then
                    if not house.garageMarker then
                        house.garageMarker = lib.AddMarker({
                            coords = house.garage.exit.xyz - vector3(0.0, 0.0, 1.0),
                            scale = vector3(3.0, 3.0, 1.0),
                            callbackData = {},
                            key = "primary",
                            text = "Garage",
                        }, nil, nil, function()
                            if IsPedInAnyVehicle(PlayerPedId()) then
                                TriggerEvent("rcore_garage:StoreMyVehicle", "car")
                            else
                                TriggerEvent("rcore_garage:OpenGarageOnSpot", "car", "civ")
                            end
                        end)
                    end
                end

                if not house.garageMarker and shouldAddMarker then
                    house.garageMarker = {
                        store = lib.AddMarker({
                            coords = house.garage.exit.xyz - vector3(0.0, 0.0, 1.0),
                            scale = vector3(3.0, 3.0, 1.0),
                            callbackData = {},
                            key = "primary",
                            text = Strings["store_vehicle"],
                        }, nil, nil, function()
                            if GetResourceState("loaf_garage") == "started" then
                                exports.loaf_garage:StoreVehicle("property", GetVehiclePedIsUsing(PlayerPedId()))
                            elseif GetResourceState("cd_garage") == "started" then
                                TriggerEvent("cd_garage:StoreVehicle_Main", 1, false)
                            end
                        end),
                        retrieve = lib.AddMarker({
                            coords = house.garage.entrance - vec3(0.0, 0.0, 1.0),
                            callbackData = {},
                            key = "primary",
                            text = Strings["browse_vehicles"],
                        }, nil, nil, function()
                            if GetResourceState("loaf_garage") == "started" then
                                exports.loaf_garage:BrowseVehicles("property", house.garage.exit)
                            elseif GetResourceState("cd_garage") == "started" then
                                TriggerEvent("cd_garage:PropertyGarage", "quick")
                            end
                        end)
                    }
                end
            end
        else
            if house.garageMarker then
                if type(house.garageMarker) == "table" then
                    lib.RemoveMarker(house.garageMarker.store)
                    lib.RemoveMarker(house.garageMarker.retrieve)
                elseif type(house.garageMarker) == "string" then
                    lib.RemoveMarker(house.garageMarker)
                end
                house.garageMarker = nil
            end
        end

        -- reload markers for mlo interiors
        if house.interiortype == "walkin" and house.locations then
            for key, location in pairs(house.locations) do
                if location.marker then
                    lib.RemoveMarker(location.marker)
                end
                
                if cache.ownedHouses[tostring(id)] or cache.houses[tostring(id)] then
                    local owner = (cache.ownedHouses[tostring(id)] and cache.ownedHouses[tostring(id)].owner) or cache.houses[tostring(id)].owner
                    local uniqueId = (cache.ownedHouses[tostring(id)] and cache.ownedHouses[tostring(id)].id) or cache.houses[tostring(id)].id

                    location.marker = lib.AddMarker({
                        coords = location.coords,
                        type = 1,
                        alpha = 0,
                        scale = location.scale,
                        callbackData = {
                            enter = {"enter", id, uniqueId, key, owner},
                            press = {"use", id, uniqueId, key, owner},
                            exit = {"exit", id, uniqueId, key, owner}
                        },
                        key = "secondary",
                        text = location.storage and Strings["access_storage"] or Strings["access_wardrobe"],
                    }, StorageMenuHandler, StorageMenuHandler, StorageMenuHandler)
                end
            end
        end

        if not reloadMarkers then 
            reloadMarkers = Config.Target
        end

        if reloadMarkers or not house.marker then
            if house.marker then
                lib.RemoveMarker(house.marker)
            end
            house.marker = lib.AddMarker({
                coords = house.entrance.xyz - vec3(0.0,0.0,1.0),
                type = 1,
                callbackData = {
                    enter = {"enter", id},
                    press = {"use", id},
                    exit = {"exit", id}
                },
                key = "primary",
                text = house.type == "house" and Strings["manage_house"]:format(id) or Strings["manage_apart"]:format(id),
            }, HouseMenuHandler, HouseMenuHandler, HouseMenuHandler)
        end
    end
end