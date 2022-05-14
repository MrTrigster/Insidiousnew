CreateThread(function()
    if Config.Framework ~= "qb" then return end
    while not loaded do Wait(500) end

    function KnockMenu(propertyId, uniqueId)
        exports["qb-menu"]:openMenu({
            {
                header = Strings["knock_door"],
                isMenuHeader = true
            },
            {
                header = Strings["yes"],
                params = {
                    event = function()
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
                        while #(GetEntityCoords(PlayerPedId()) - Houses[propertyId].entrance.xyz) <= 3.0 do
                            Wait(50)
                        end
                        TriggerServerEvent("loaf_housing:cancel_knock", propertyId, uniqueId)
                    end,
                    isAction = true
                }
            },
            {
                header = Strings["no"]
            }
        })
    end

    function EnterOtherMenu(propertyId)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")

        local dialog = exports["qb-input"]:ShowInput({
            header = Strings["enter_"..houseApart.."_id"],
            submitText = "Sisene",
            inputs = {
                {
                    text = "Id",
                    name = "id",
                    type = "text",
                    isRequired = true
                }
            }
        })

        if not dialog then return end

        local exists
        for _, property in pairs(cache.houses) do
            if property.propertyid == propertyId and property.id == dialog.id then
                exists = true
                break
            end
        end
        if not exists then
            return Notify(Strings[houseApart.."_not_exist"]:format(dialog.id))
        end
        local entered, reason = EnterProperty(propertyId, dialog.id)
        if reason == "no_access" then
            KnockMenu(propertyId, dialog.id)
        end
    end

    function SelectLockpick(propertyId)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")

        local dialog = exports["qb-input"]:ShowInput({
            header = Strings["lockpick_"..houseApart],
            submitText = "Lockpick",
            inputs = {
                {
                    text = "Id",
                    name = "id",
                    type = "text",
                    isRequired = true
                }
            }
        })

        if not dialog then return end
        Lockpick(propertyId, dialog.id)
    end

    function SelectBreach(propertyId)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")

        local dialog = exports["qb-input"]:ShowInput({
            header = Strings["breach_"..houseApart],
            submitText = "Breach",
            inputs = {
                {
                    text = "Id",
                    name = "id",
                    type = "text",
                    isRequired = true
                }
            }
        })

        if not dialog then return end
        TriggerServerEvent("loaf_housing:breach_door", propertyId, dialog.id)
    end

    function EnterPurchaseMenu(propertyId)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")

        local elements = {
            {
                header = Strings[houseApart .. "_menu"]:format(propertyId),
                isMenuHeader = true
            },
            {
                header = Strings["enter_other_"..houseApart],
                params = {
                    event = EnterOtherMenu,
                    isAction = true,
                    args = propertyId
                }
            }
        }

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
                header = Strings["purchase_rent"],
                params = {
                    event = PurchaseMenu,
                    isAction = true,
                    args = propertyId
                }
            })
        end

        if Config.Lockpicking.Enabled then
            table.insert(elements, {
                header = Strings["lockpick_door"],
                params = {
                    event = SelectLockpick,
                    isAction = true,
                    args = propertyId
                }
            })
        end
        if cache.canBreach then 
            table.insert(elements, {
                header = Strings["breach_door"],
                params = {
                    event = SelectBreach,
                    isAction = true,
                    args = propertyId
                }
            })
        end

        exports["qb-menu"]:openMenu(elements)
    end

    function UniqueOwnedMenu(propertyId, uniqueId)
        local houseData = Houses[propertyId]
        local houseApart = (houseData.type == "house" and "house" or "apart")

        local elements = {
            {
                header = houseData.label,
                isMenuHeader = true
            }
        }
        local locked = lib.TriggerCallbackSync("loaf_housing:get_locked", propertyId, uniqueId)
        if not locked or exports.loaf_keysystem:HasKey(GetKeyName(propertyId, uniqueId)) then
            if houseData.interiortype ~= "walkin" then
                table.insert(elements, {
                    header = Strings["enter_the_"..houseApart],
                    params = {
                        event = function()
                            EnterProperty(propertyId, uniqueId)
                        end, 
                        isAction = true
                    }
                })
            end
        else
            table.insert(elements, {
                header = Strings["knock_on_door"],
                params = {
                    event = function()
                        KnockMenu(propertyId, uniqueId)
                    end,
                    isAction = true
                }
            })
            if Config.Lockpicking.Enabled then
                table.insert(elements, {
                    header = Strings["lockpick_door"],
                    params = {
                        event = function()
                            Lockpick(propertyId, uniqueId)
                        end,
                        isAction = true
                    }
                })
            end
            if cache.canBreach then 
                table.insert(elements, {
                    header = Strings["breach_door"],
                    params = {
                        function()
                            TriggerServerEvent("loaf_housing:breach_door", propertyId, uniqueId)
                        end,
                        isAction = true,
                    }
                })
            end
        end

        exports["qb-menu"]:openMenu(elements)
    end
end)