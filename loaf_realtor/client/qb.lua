CreateThread(function()
    if Config.Framework ~= "qb" then return end
    local QBCore
    while not QBCore do
        QBCore = exports["qb-core"]:GetCoreObject()
        Wait(500)
    end
    while not QBCore.Functions.GetPlayerData() or not QBCore.Functions.GetPlayerData().job do
        Wait(500)
    end

    function Notify(msg)
        QBCore.Functions.Notify(msg)
    end

    function OnJob(job)
        if not job then
            job = QBCore.Functions.GetPlayerData().job
        end
        hasJob = job.name == Config.JobName
        isBoss = hasJob and job.isboss
        canCreate = hasJob and job.grade.level >= Config.CreateGrade

        RefreshMarkers()
    end
    RegisterNetEvent("QBCore:Client:OnJobUpdate", OnJob)

    function BossActions()
        if not isBoss then
            return
        end

        TriggerEvent("i13-bossmenu:client:openMenu")
        TriggerEvent("i13-bossmenu:client:OpenMenu")
    end

    -- house creation
    local creatingHouse = false
    local entranceVector, exitVector
    local entrance, garageEntrance, garageExit, interiorType, interior

    local function FinishProperty(propertyType)
        local dialog = exports["qb-input"]:ShowInput({
            header = Strings["add_property"],
            submitText = Strings["add_property"],
            inputs = {
                {
                    text = Strings[propertyType .. "_label"],
                    name = "label",
                    type = "text",
                    isRequired = true
                },
                {
                    text = Strings["property_price"],
                    name = "price",
                    type = "number",
                    isRequired = true
                }
            }
        })

        if dialog and dialog.label and dialog.price then
            local name, price = dialog.label, tonumber(dialog.price)
            if not price or price < Config.MinPrice then
                Notify(Strings["price_low"])
                return
            end

            if name == nil or #name < 3 then
                return Notify(Strings["short_name"])
            end

            TriggerServerEvent("loaf_realtor:add_property", entrance, garageEntrance, garageExit, interiorType, interior, propertyType, name, price)
            creatingHouse = false
        end
    end

    local function SetPropertyType()
        exports["qb-menu"]:openMenu({
            {
                header = Strings["set_propertytype"],
                isMenuHeader = true
            },
            {
                header = Strings["house"],
                params = {
                    args = "house",
                    event = FinishProperty,
                    isAction = true
                }
            },
            {
                header = Strings["apartment"],
                params = {
                    args = "apartment",
                    event = FinishProperty,
                    isAction = true
                }
            }
        })
    end

    local function SetInterior(data)
        interiorType = data[1]
        interior = data[2]
        Notify(Strings["interior_set"]:format(data[3]))
    end

    local function SelectInterior()
        if not creatingHouse then
            return
        end

        local config, shells = exports.loaf_housing:GetConfig(), exports.loaf_housing:GetShells()
        local categoryElements = {
            {
                header = Strings["choose_interior"],
                isMenuHeader = true
            }
        }
        local interiorElements = {}

        for k, v in pairs(config.Interiors) do
            if not interiorElements["misc_interiors"] then
                interiorElements["misc_interiors"] = {
                    {
                        header = Strings["choose_interior"],
                        isMenuHeader = true
                    }
                }
            end

            table.insert(interiorElements["misc_interiors"], {
                header = v.label,
                params = {
                    event = SetInterior,
                    args = {"interior", k, v.label},
                    isAction = true
                }
            })
        end
        
        if interiorElements["misc_interiors"] then
            table.insert(categoryElements, {
                header = Strings["misc_interiors"],
                params = {
                    event = function()
                        exports["qb-menu"]:openMenu(interiorElements["misc_interiors"])
                    end,
                    isAction = true
                }
            })
        end

        for category, data in pairs(shells) do
            for i, shell in pairs(data.shells) do
                if not interiorElements[category] then
                    interiorElements[category] = {
                        {
                            header = Strings["choose_interior"],
                            isMenuHeader = true
                        }
                    }
                end

                table.insert(interiorElements[category], {
                    header = shell,
                    params = {
                        event = SetInterior,
                        args = {"shell", shell, shell},
                        isAction = true
                    }
                })
            end

            if interiorElements[category] then
                table.insert(categoryElements, {
                    header = data.label or category,
                    params = {
                        event = function()
                            exports["qb-menu"]:openMenu(interiorElements[category])
                        end,
                        isAction = true
                    }
                })
            end
        end

        exports["qb-menu"]:openMenu(categoryElements)
    end

    local function HouseCreationMenu()
        if not creatingHouse then
            creatingHouse = true
            entranceVector, exitVector, entrance, garageEntrance, garageExit, interiorType, interior = nil, nil, nil, nil, nil, nil, nil
        end

        exports["qb-menu"]:openMenu({
            {
                header = Strings["create_property"],
                isMenuHeader = true
            },
            {
                header = Strings["set_entrance"], 
                params = {
                    event = function()
                        local coords = GetEntityCoords(PlayerPedId())
                        entrance = vector4(coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()))
                        entranceVector = GetEntityForwardVector(PlayerPedId())
                    end,
                    isAction = true
                }
            },
            -- {
            --     header = Strings["set_garage_entrance"], 
            --     params = {
            --         event = function()
            --             garageEntrance = GetEntityCoords(PlayerPedId())
            --         end,
            --         isAction = true
            --     }
            -- },
            -- {
            --     header = Strings["set_garage_exit"], 
            --     params = {
            --         event = function()
            --             local coords = not IsPedInAnyVehicle(PlayerPedId(), true) and GetEntityCoords(PlayerPedId()) or GetEntityCoords(PlayerPedId()) + vec3(0.0, 0.0, 0.5)
            --             garageExit = vector4(coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()))
            --             exitVector = GetEntityForwardVector(PlayerPedId())
            --         end,
            --         isAction = true
            --     }
            -- },
            {
                header = Strings["set_interior"], 
                params = {
                    event = SelectInterior,
                    isAction = true
                }
            },
            {
                header = Strings["cancel_creation"],
                params = {
                    event = function()
                        creatingHouse = false
                    end,
                    isAction = true
                }
            },
            {
                header = Strings["add_property"], 
                params = {
                    event = SetPropertyType,
                    isAction = true
                }
            }
        })
    end

    -- remove property
    local function RemoveProperty()
        local dialog = exports["qb-input"]:ShowInput({
            header = Strings["remove_property"],
            submitText = Strings["remove"],
            inputs = {
                {
                    text = Strings["property_remove"],
                    name = "id",
                    type = "number",
                    isRequired = true
                }
            }
        })

        if not (dialog and dialog.id and tonumber(dialog.id)) then
            return
        end

        TriggerServerEvent("loaf_realtor:remove_property", tonumber(dialog.id))
    end

    -- transfer & bill menu
    local function BillPlayer(serverId)
        local dialog = exports["qb-input"]:ShowInput({
            header = Strings["bill_player"],
            submitText = Strings["send_bill"],
            inputs = {
                {
                    text = Strings["houseid_bill"],
                    name = "id",
                    type = "number",
                    isRequired = true
                }
            }
        })

        if not (dialog and dialog.id and tonumber(dialog.id)) then
            return
        end

        TriggerServerEvent("loaf_realtor:bill_house", serverId, tonumber(dialog.id))
    end

    local function TransferProperty(serverId)
        local dialog = exports["qb-input"]:ShowInput({
            header = Strings["transfer_property"],
            submitText = Strings["transfer"],
            inputs = {
                {
                    text = Strings["property_transfer"],
                    name = "id",
                    type = "number",
                    isRequired = true
                }
            }
        })

        if not (dialog and dialog.id and tonumber(dialog.id)) then
            return
        end

        TriggerServerEvent("loaf_realtor:transfer_property", serverId, tonumber(dialog.id))
    end

    local function TransferBill(transferOrBill)
        local elements = {
            {
                header = Strings["who_" .. transferOrBill],
                isMenuHeader = true
            }
        }

        for _, v in pairs(GetPlayers()) do
            table.insert(elements, {
                header = v.name,
                params = {
                    event = function()
                        if transferOrBill == "bill" then
                            BillPlayer(v.serverId)
                        elseif transferOrBill == "transfer" then
                            TransferProperty(v.serverId)
                        end
                    end, 
                    isAction = true
                }
            })
        end
        if #elements == 0 then
            table.insert(elements, {
                header = Strings["noone_nearby"],
                params = {}
            })
        end

        exports["qb-menu"]:openMenu(elements)
    end

    -- job menu
    function JobMenu()
        if not hasJob then
            return
        end
        if creatingHouse then
            HouseCreationMenu()
            return
        end

        local elements = {
            {
                header = Strings["job_menu"],
                isMenuHeader = true
            }, 
            {
                header = Strings["bill_player"],
                params = {
                    event = TransferBill,
                    isAction = true,
                    args = "bill"
                }
            },
            {
                header = Strings["transfer_property"],
                params = {
                    event = TransferBill,
                    isAction = true,
                    args = "transfer"
                }
            }
        }
        if canCreate then
            table.insert(elements, {
                header = Strings["create_property"],
                params = {
                    event = function()
                        HouseCreationMenu()
                        while creatingHouse do
                            Wait(0)

                            if entrance then
                                DrawMarker(1, entrance.xyz - vec3(0.0, 0.0, 1.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.8, 0.8, 0.4), 255, 255, 0, 150)
                                DrawMarker(2, entrance.xyz - vec3(0.0, 0.0, 0.5), entranceVector, vec3(90.0, 0.1, 90.0), vec3(0.4, 0.4, 0.4), 255, 255, 0, 150)
                
                                Draw3DText(Strings["entrance"], entrance.xyz - vec3(0.0, 0.0, 0.2))
                            end
                            
                            if garageEntrance then
                                DrawMarker(1, garageEntrance - vec3(0.0, 0.0, 1.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.8, 0.8, 0.4), 255, 255, 0, 150)
                
                                Draw3DText(Strings["garage_entrance"], garageEntrance - vec3(0.0, 0.0, 0.5))
                            end
                            
                            if garageExit then
                                DrawMarker(1, garageExit.xyz - vec3(0.0, 0.0, 1.0), vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), vec3(0.8, 0.8, 0.4), 255, 255, 0, 150)
                                DrawMarker(2, garageExit.xyz - vec3(0.0, 0.0, 0.5), exitVector, vec3(90.0, 0.1, 90.0), vec3(0.4, 0.4, 0.4), 255, 255, 0, 150)
                                
                                Draw3DText(Strings["garage_exit"], garageExit.xyz - vec3(0.0, 0.0, 0.2))
                            end
                        end
                    end, 
                    isAction = true
                }
            })
            table.insert(elements, {
                header = Strings["remove_property"],
                params = {
                    event = RemoveProperty,
                    isAction = true
                }
            })
        end

        exports["qb-menu"]:openMenu(elements)
    end
    
    loaded = true
end)