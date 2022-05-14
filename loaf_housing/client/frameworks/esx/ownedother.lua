-- menus for properties owned by other players

CreateThread(function()
    if Config.Framework ~= "esx" then return end
    while not loaded do Wait(500) end

    function KnockMenu(propertyId, uniqueId)
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "knock_menu", {
            title = Strings["knock_door"],
            align = cache.menuAlign,
            elements = {
                {
                    label = Strings["yes"],
                    knock = true
                },
                {label = Strings["no"]}
            }
        }, function(data, menu)
            menu.close()
            if not data.current.knock then return end
            CloseMenu()

            local sequenceId = OpenSequenceTask()
            TaskAchieveHeading(0, Houses[propertyId].entrance.w - 180.0, 1500)
            TaskPlayAnim(0, LoadDict("timetable@jimmy@doorknock@"), "knockdoor_idle", 8.0, -8.0, -1, 0, 0, false, false, false)
            CloseSequenceTask(sequenceId)
            
            TaskPerformSequence(PlayerPedId(), sequenceId)
            while not IsEntityPlayingAnim(PlayerPedId(), "timetable@jimmy@doorknock@", "knockdoor_idle", 3) do
                Wait(0)
            end
            while IsEntityPlayingAnim(PlayerPedId(), "timetable@jimmy@doorknock@", "knockdoor_idle", 3) do
                Wait(0)
            end
            TriggerServerEvent("loaf_housing:knock_door", propertyId, uniqueId)
        end, CloseMenuHandler)
    end

    function UniqueOwnedMenu(propertyId, uniqueId)
        local housedata = Houses[propertyId]
        local houseApart = (housedata.type == "house" and "house" or "apart")
        local elements = {}
        local locked = lib.TriggerCallbackSync("loaf_housing:get_locked", propertyId, uniqueId)
        if not locked or exports.loaf_keysystem:HasKey(GetKeyName(propertyId, uniqueId)) then
            if housedata.interiortype ~= "walkin" then
                table.insert(elements, {
                    label = Strings["enter_the_"..houseApart],
                    value = "enter"
                })
            end
        else
            table.insert(elements, {
                label = Strings["knock_on_door"],
                value = "knock"
            })
            if Config.Lockpicking.Enabled then
                table.insert(elements, {
                    label = Strings["lockpick_door"],
                    value = "lockpick"
                })
            end
            if cache.canBreach then 
                table.insert(elements, {
                    label = Strings["breach_door"],
                    value = "breach"
                })
            end
        end

        CloseMenu()
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "unique_other_menu", {
            title = Houses[propertyId].label,
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value == "enter" then
                EnterProperty(propertyId, uniqueId)
            elseif data.current.value == "knock" then
                KnockMenu(propertyId, uniqueId)
            elseif data.current.value == "lockpick" then
                Lockpick(propertyId, uniqueId)
            elseif data.current.value == "breach" then
                CloseMenu()
                TriggerServerEvent("loaf_housing:breach_door", propertyId, uniqueId)
            end
        end, CloseMenuHandler)
    end

    function EnterOtherMenu(propertyId)
        local housedata = Houses[propertyId]
        local houseApart = (housedata.type == "house" and "house" or "apart")

        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "enter_other", {
            title = Strings["enter_"..houseApart.."_id"]
        }, function(data, menu)
            local exists
            for _, property in pairs(cache.houses) do
                if property.propertyid == propertyId and property.id == data.value then
                    exists = true
                    break
                end
            end
            if not exists then
                return Notify(Strings[houseApart.."_not_exist"]:format(data.value))
            end
            local entered, reason = EnterProperty(propertyId, data.value)
            if reason == "no_access" then
                KnockMenu(propertyId, data.value)
            end
        end, CloseMenuHandler)
    end

    function EnterPurchaseMenu(propertyid)
        local houseData = Houses[propertyid]
        local houseApart = (houseData.type == "house" and "house" or "apart")
        local elements = {}

        table.insert(elements, {
            label = Strings["enter_other_"..houseApart],
            value = "enter_other"
        })

        local amountProperties = 0
        for _ in pairs(cache.ownedHouses) do
            amountProperties = amountProperties + 1
        end
        if amountProperties < Config.MaxProperties then
            local label
            if houseData.rent and houseData.price then
                label = Strings["purchase_rent"]
            elseif houseData.rent then
                label = Strings["rent"]:format(houseData.rent)
            else
                label = Strings["purchase"]:format(houseData.price)
            end

            table.insert(elements, {
                label = label,
                value = "purchase"
            })
        end
        if Config.Lockpicking.Enabled then
            table.insert(elements, {
                label = Strings["lockpick_door"],
                value = "lockpick"
            })
        end
        if cache.canBreach then 
            table.insert(elements, {
                label = Strings["breach_door"],
                value = "breach"
            })
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "enter_purchase", {
            title = Strings[houseApart.."_menu"]:format(propertyid),
            align = cache.menuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value == "enter_other" then
                EnterOtherMenu(propertyid)
            elseif data.current.value == "purchase" then
                PurchaseMenu(propertyid)
            elseif data.current.value == "lockpick" then
                SelectLockpick(propertyid)
            elseif data.current.value == "breach" then
                SelectBreach(propertyid)
            end
        end, CloseMenuHandler)
    end
end)