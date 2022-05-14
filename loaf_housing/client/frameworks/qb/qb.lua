CreateThread(function()
    if Config.Framework ~= "qb" then return end
    while not QBCore do
        Wait(500)
        QBCore = exports["qb-core"]:GetCoreObject()
    end
    while not QBCore.Functions.GetPlayerData() or not QBCore.Functions.GetPlayerData().job do
        Wait(500)
    end
    loaded = true

    function CloseMenu()
        exports["qb-menu"]:closeMenu()
    end

    function Notify(msg)
        QBCore.Functions.Notify(msg)
    end

    cache.canBreach = false
    if Config.PoliceRaid.Enabled then
        local function OnJob(job)
            if not job then
                job = QBCore.Functions.GetPlayerData().job
            end

            local isPolice = false
            for jobName, grade in pairs(Config.PoliceRaid.Jobs) do
                if jobName == job.name and job.grade.level >= grade then
                    isPolice = true
                    break
                end
            end

            cache.canBreach = isPolice
        end

        RegisterNetEvent("QBCore:Client:OnJobUpdate", OnJob)
        OnJob()
    end

    function LetInMenu()
        local instance = cache.currentInstance
        local knocking = lib.TriggerCallbackSync("loaf_housing:get_knocking", instance.property, instance.id)

        local elements = {
            {
                header = Strings["let_someone_in"],
                isMenuHeader = true
            }
        }
        for src, _ in pairs(knocking) do
            src = tonumber(src)
            local name = GetPlayerName(src)
            if Config.UseRPName then 
                name = lib.TriggerCallbackSync("loaf_keysystem:get_name", src) or name 
            end

            table.insert(elements, {
                header = name,
                params = {
                    event = function()
                        exports["qb-menu"]:openMenu({
                            {
                                header = Strings["let_in"]:format(name),
                                isMenuHeader = true
                            },
                            {
                                header = Strings["yes"],
                                params = {
                                    event = function()
                                        TriggerServerEvent("loaf_housing:handle_knock", instance.property, instance.id, src, true)
                                    end,
                                    isAction = true
                                }
                            },
                            {
                                header = Strings["no"],
                                params = {
                                    event = function()
                                        TriggerServerEvent("loaf_housing:handle_knock", instance.property, instance.id, src, false)
                                    end,
                                    isAction = true
                                }
                            }
                        })
                    end,
                    isAction = true
                }
            })
        end

        exports["qb-menu"]:openMenu(elements)
    end

    function OpenInstanceMenu()
        local instance = cache.currentInstance
        local houseData = Houses[instance.property]
        local houseApart = (houseData.type == "house" and "house" or "apart")

        local allowedFurnish = Config.Furnish == "all" or cache.identifier == instance.owner
        if not allowedFurnish and Config.Furnish == "key" then
            allowedFurnish = exports.loaf_keysystem:HasKey(GetKeyName(instance.property, instance.id))
        end
        if allowedFurnish then
            if cache.currentInstance.interior then
                if cache.currentInstance.interior.disableFurnishing then 
                    allowedFurnish = false 
                end
            elseif cache.currentInstance.shell then
                if Shells[cache.currentInstance.shell].disableFurnishing then 
                    allowedFurnish = false 
                end
            end
        end

        local elements = {
            {
                header = cache.identifier == instance.owner and Strings["manage_owned_"..houseApart]:format(instance.property) or Strings["instance_menu_"..houseApart]:format(instance.property),
                isMenuHeader = true
            },
            {
                header = Strings["let_someone_in"],
                params = {
                    event = LetInMenu,
                    isAction = true
                }
            }
        }
        if not houseData.unique then
            elements[1].txt = Strings[houseApart.."_id"]:format(cache.currentInstance.id)
        end

        if allowedFurnish then
            table.insert(elements, {
                header = Strings["furnish_"..houseApart],
                params = {
                    event = SelectFurnitureMenu,
                    isAction = true
                }
            })
            table.insert(elements, {
                header = Strings["manage_furniture"],
                params = {
                    event = function()
                        PlacedFurnitureMenu()
                        ManagePlacedFurniture()
                        Wait(5000)
                        cache.busy = false
                    end,
                    isAction = true
                }
            })
        end

        table.insert(elements, {
            header = Strings["exit_"..houseApart],
            params = {
                event = function()
                    cache.inInstance = false
                end,
                isAction = true
            }
        })
        
        exports["qb-menu"]:openMenu(elements)
    end

    local function ChooseInterior(category, propertyId, purchaseRent)
        local elements = {
            {
                header = Strings["select_interior"],
                isMenuHeader = true
            }
        }
        for i, v in pairs(Categories[category].shells) do
            table.insert(elements, {
                header = v,
                params = {
                    event = function()
                        StartLoading(Strings["processing_payment"])
                        lib.TriggerCallback("loaf_housing:purchase_property", function(res, reason)
                            if not res then
                                Notify(Strings[reason])
                            end
                            StopLoading()
                        end, propertyId, purchaseRent, i)
                    end,
                    isAction = true
                }
            })
        end
        exports["qb-menu"]:openMenu(elements)
    end

    local function PurchaseOrRent(data)
        local propertyId, purchaseRent = table.unpack(data)
        local houseData = Houses[propertyId]

        if houseData.interiortype == "shell" and Config.SelectShell and not houseData.shellId then
            ChooseInterior(houseData.category, propertyId, purchaseRent)
        else
            local shellId
            if houseData.shell then
                for i, shell in pairs(Categories[houseData.category].shells) do
                    if shell == houseData.shell then
                        shellId = i
                        break
                    end
                end
            end

            StartLoading(Strings["processing_payment"])
            lib.TriggerCallback("loaf_housing:purchase_property", function(res, reason)
                if not res then
                    Notify(Strings[reason])
                end
                StopLoading()
            end, propertyId, purchaseRent, shellId)
        end
    end

    function PurchaseMenu(propertyId)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")
        local elements = {}

        if (Config.Realtor.enabled and not Config.Realtor.requireRealtor) or not Config.Realtor.enabled then
            if houseData.rent and houseData.price then
                elements = {
                    {
                        header = Strings["purchase_rent_"..houseApart],
                        isMenuHeader = true
                    },
                    {
                        header = Strings["purchase"]:format(houseData.price),
                        params = {
                            event = PurchaseOrRent,
                            args = {propertyId, "purchase"},
                            isAction = true
                        }
                    },
                    {
                        header = Strings["rent"]:format(houseData.rent),
                        params = {
                            event = PurchaseOrRent,
                            args = {propertyId, "rent"},
                            isAction = true
                        }
                    }
                }
            else
                elements = {
                    {
                        header = houseData.rent and Strings["rent_"..houseApart]:format(houseData.rent) or Strings["purchase_"..houseApart]:format(houseData.price),
                        isMenuHeader = true
                    },
                    {
                        header = Strings["yes"],
                        params = {
                            event = PurchaseOrRent,
                            args = {propertyId, houseData.rent and "rent" or "purchase"},
                            isAction = true
                        }
                    },
                    {
                        header = Strings["no"]
                    }
                }
            end
        else
            elements = {
                {
                    header = Strings[houseApart .. "_menu"]:format(propertyId),
                    isMenuHeader = true
                },
                {
                    header = Strings["contact_realtor"],
                    isMenuHeader = true
                }
            }
        end

        if Config.PreviewProperty and (houseData.interiortype == "shell" or houseData.interiortype == "interior") then
            table.insert(elements, {
                header = Strings["preview_property"],
                params = {
                    event = PreviewProperty,
                    args = propertyId,
                    isAction = true
                }
            })            
        end

        exports["qb-menu"]:openMenu(elements)
    end
end)