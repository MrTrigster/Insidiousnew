CreateThread(function()
    if Config.Framework ~= "esx" then return end
    while ESX == nil do 
        TriggerEvent("esx:getSharedObject", function(obj) 
            ESX = obj 
        end)
        Wait(250)
    end
    while not ESX.GetPlayerData() or not ESX.GetPlayerData().job do
        Wait(250)
    end
    loaded = true

    function CloseMenu()
        ESX.UI.Menu.CloseAll()
    end

    function Notify(msg)
        ESX.ShowNotification(msg)
    end

    function CloseMenuHandler(data, menu)
        menu.close()
    end

    cache.canBreach = false
    if Config.PoliceRaid.Enabled then
        local function OnJob(job) -- handle if you are allowed to breach a door or not
            if not job then
                job = ESX.GetPlayerData().job
            end

            local isPolice = false
            for jobName, grade in pairs(Config.PoliceRaid.Jobs) do
                if jobName == job.name and job.grade >= grade then
                    isPolice = true
                    break
                end
            end

            cache.canBreach = isPolice
        end

        RegisterNetEvent("esx:setJob", OnJob)
        OnJob()
    end

    function LetInMenu()
        local instance = cache.currentInstance
        local knocking = lib.TriggerCallbackSync("loaf_housing:get_knocking", instance.property, instance.id)
        local elements = {}

        for src, _ in pairs(knocking) do
            src = tonumber(src)
            local name = GetPlayerName(src)
            if Config.UseRPName then 
                name = lib.TriggerCallbackSync("loaf_keysystem:get_name", src) or name 
            end
            table.insert(elements, {
                label = name,
                value = src
            })
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "let_in_menu", {
            title = Strings["let_someone_in"],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "let_in_player", {
                title = Strings["let_in"]:format(data.current.label),
                align = cache.menuAlign,
                elements = {
                    {
                        label = Strings["yes"],
                        value = true
                    },
                    {
                        label = Strings["no"],
                        value = no
                    }
                }
            }, function(data2, menu2)
                TriggerServerEvent("loaf_housing:handle_knock", instance.property, instance.id, data.current.value, data2.current.value)
                menu2.close()
                menu.close()
                Wait(250)
                LetInMenu()
            end, CloseMenuHandler)
        end, CloseMenuHandler)
    end

    function OpenInstanceMenu()
        ESX.UI.Menu.CloseAll()

        local instance = cache.currentInstance
        local housedata = Houses[instance.property]
        local houseApart = (housedata.type == "house" and "house" or "apart")

        local elements = {
            {
                label = Strings["let_someone_in"],
                value = "let_in"
            }
        }

        local allowedFurnish = Config.Furnish == "all" or cache.identifier == instance.owner
        if not allowedFurnish and Config.Furnish == "key" then
            allowedFurnish = exports.loaf_keysystem:HasKey(GetKeyName(instance.property, instance.id))
        end

        if allowedFurnish then
            if cache.currentInstance.interior then
                if cache.currentInstance.interior.disableFurnishing then allowedFurnish = false end
            elseif cache.currentInstance.shell then
                if Shells[cache.currentInstance.shell].disableFurnishing then allowedFurnish = false end
            end
        end

        if allowedFurnish then
            table.insert(elements, {
                label = Strings["furnish_"..houseApart],
                value = "furnish"
            })
            table.insert(elements, {
                label = Strings["manage_furniture"],
                value = "manage_furniture"
            })
        end

        if not housedata.unique then
            table.insert(elements, {
                label = Strings[houseApart.."_id"]:format(cache.currentInstance.id)
            })
        end

        table.insert(elements, {
            label = Strings["exit_"..houseApart],
            value = "exit"
        })

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "instance_menu", {
            title = cache.identifier == instance.owner and Strings["manage_owned_"..houseApart]:format(instance.property) or Strings["instance_menu_"..houseApart]:format(instance.property),
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value == "exit" then
                menu.close()
                cache.inInstance = false
            elseif data.current.value == "furnish" then
                SelectFurnitureMenu()
            elseif data.current.value == "manage_furniture" then
                PlacedFurnitureMenu()
                ManagePlacedFurniture()
            elseif data.current.value == "let_in" then
                LetInMenu()
            end
        end, CloseMenuHandler)
    end

    function SelectLockpick(propertyId)
        local housedata = Houses[propertyId]
        local houseApart = (housedata.type == "house" and "house" or "apart")

        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "select_lockpick", {
            title = Strings["lockpick_"..houseApart]
        }, function(data, menu)
            CloseMenu()
            Lockpick(propertyId, data.value)
        end, CloseMenuHandler)
    end

    function SelectBreach(propertyId)
        local housedata = Houses[propertyId]
        local houseApart = (housedata.type == "house" and "house" or "apart")

        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "select_breach", {
            title = Strings["breach_"..houseApart]
        }, function(data, menu)
            CloseMenu()
            TriggerServerEvent("loaf_housing:breach_door", propertyId, data.value)
        end, CloseMenuHandler)
    end

    local function ChooseInterior(category)
        local elements = {}
        for i, v in pairs(Categories[category].shells) do
            table.insert(elements, {
                label = v,
                value = i
            })
        end

        local selectedShell
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "select_shell", {
            title = Strings["select_interior"],
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            selectedShell = data.current.value
            menu.close()
        end, CloseMenuHandler)
        
        while not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_shell") do Wait(0) end
        while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "select_shell") do Wait(0) end
        return selectedShell
    end

    function PurchaseMenu(propertyid)
        local housedata = Houses[propertyid]
        local houseApart = (housedata.type == "house" and "house" or "apart")
        local elements, label = {}, Strings[houseApart .. "_menu"]:format(propertyid)

        if (Config.Realtor.enabled and not Config.Realtor.requireRealtor) or not Config.Realtor.enabled then
            if housedata.rent and housedata.price then
                label = Strings["purchase_rent_"..houseApart]
                elements = {
                    {
                        label = Strings["purchase"]:format(housedata.price),
                        value = "purchase"
                    },
                    {
                        label = Strings["rent"]:format(housedata.rent),
                        value = "rent"
                    }
                }
            else
                label = housedata.rent and Strings["rent_"..houseApart]:format(housedata.rent) or Strings["purchase_"..houseApart]:format(housedata.price)
                elements = {
                    {
                        label = Strings["yes"],
                        value = housedata.rent and "rent" or "purchase"
                    },
                    {
                        label = Strings["no"],
                        value = "cancel"
                    }
                }
            end
        else
            table.insert(elements, {
                label = Strings["contact_realtor"]
            })
        end

        if Config.PreviewProperty and (housedata.interiortype == "shell" or housedata.interiortype == "interior") then
            table.insert(elements, {
                label = Strings["preview_property"],
                value = "preview"
            })
        end
        
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "purchase_property", {
            title = label,
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value == "cancel" then 
                return ESX.UI.Menu.CloseAll() 
            end

            if data.current.value == "preview" then
                PreviewProperty(propertyid)
                return
            end

            if data.current.value == "purchase" or data.current.value == "rent" then
                CloseMenu()

                local shellId
                if housedata.interiortype == "shell" and Config.SelectShell and not housedata.shell then
                    shellId = ChooseInterior(housedata.category)
                    if not shellId then
                        return
                    end
                end

                if housedata.shell then
                    for i, shell in pairs(Categories[housedata.category].shells) do
                        if shell == housedata.shell then
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
                end, propertyid, data.current.value, shellId)
            end
        end, CloseMenuHandler)
    end
end)