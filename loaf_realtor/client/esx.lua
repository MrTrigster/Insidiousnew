CreateThread(function()
    if Config.Framework ~= "esx" then return end
    local ESX
    while ESX == nil do 
        TriggerEvent("esx:getSharedObject", function(obj) 
            ESX = obj 
        end)
        Wait(500)
    end
    while not ESX.GetPlayerData() or not ESX.GetPlayerData().job do
        Wait(500)
    end

    function OnJob(job)
        if not job then
            job = ESX.GetPlayerData().job
        end
        hasJob = job.name == Config.JobName
        isBoss = hasJob and job.grade_name == "boss"
        canCreate = hasJob and job.grade >= Config.CreateGrade

        RefreshMarkers()
    end
    RegisterNetEvent("esx:setJob", OnJob)

    function Notify(msg)
        ESX.ShowNotification(msg)
    end

    local function CloseMenuHandler(data, menu)
        menu.close()
    end

    function BossActions()
        if not isBoss then
            return
        end

        ESX.UI.Menu.CloseAll()

        TriggerEvent("esx_society:openBossMenu", Config.JobName, CloseMenuHandler, {
            wash = false
        })
    end

    -- job menu
    local jobActions = {}

    function JobMenu()
        if not hasJob then
            return
        end

        ESX.UI.Menu.CloseAll()

        local elements = {
            {label = Strings["bill_player"], value = "transfer_bill"},
            {label = Strings["transfer_property"], value = "transfer_bill"}
        }

        if canCreate then
            table.insert(elements, {label = Strings["create_property"], value = "create"})
            table.insert(elements, {label = Strings["remove_property"], value = "remove"})
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "job_menu", {
            title = Strings["job_menu"],
            align = Config.MenuAlign,
            elements = elements
        }, function(data, menu)
            jobActions[data.current.value](data.current.label)
        end, CloseMenuHandler)
    end

    -- menu to bill a player for a house
    local function BillPlayer(name, serverId)
        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "choose_bill", {
            title = Strings["houseid_bill"]
        }, function(data, menu)
            local propertyId = tonumber(data.value)
            if not propertyId then
                return Notify(Strings["invalid_property"])
            end
            
            TriggerServerEvent("loaf_realtor:bill_house", serverId, propertyId)
            ESX.UI.Menu.CloseAll()
        end, CloseMenuHandler)
    end

    local function TransferProperty(name, serverId)
        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "property_transfer", {
            title = Strings["property_transfer"]
        }, function(data, menu)
            local propertyId = tonumber(data.value)
            if not propertyId then
                return Notify(Strings["invalid_property"])
            end
            
            TriggerServerEvent("loaf_realtor:transfer_property", serverId, propertyId)
            ESX.UI.Menu.CloseAll()
        end, CloseMenuHandler)
    end

    jobActions.transfer_bill = function(label)
        local elements = {}
        for _, v in pairs(GetPlayers()) do
            table.insert(elements, {
                label = v.name,
                value = v.serverId
            })
        end
        if #elements == 0 then
            table.insert(elements, {
                label = Strings["noone_nearby"]
            })
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "transfer_bill_menu", {
            title = label == Strings["bill_player"] and Strings["who_bill"] or Strings["who_transfer"],
            align = Config.MenuAlign,
            elements = elements
        }, function(data, menu)
            if not data.current.value then
                return menu.close()
            end

            if label == Strings["bill_player"] then
                BillPlayer(data.current.label, data.current.value)
            elseif label == Strings["transfer_property"] then
                TransferProperty(data.current.label, data.current.value)
            end
        end, CloseMenuHandler)
    end

    -- menu to create a house
    local function FinishHouseCreation(entrance, garageEntrance, garageExit, interiorType, interior)
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "finish_house", {
            title = Strings["set_propertytype"],
            align = Config.MenuAlign,
            elements = {
                {label = Strings["house"], value = "house"},
                {label = Strings["apartment"], value = "apartment"}
            }
        }, function(data, menu)
            local propertyType = data.current.value
            ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "house_label", {
                title = Strings[data.current.value.."_label"]
            }, function(data, menu)
                local name = data.value
                if name == nil or #name < 3 then
                    return Notify(Strings["short_name"])
                end
                menu.close()

                ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "property_price", {
                    title = Strings["property_price"]
                }, function(data, menu)
                    local price = tonumber(data.value)
                    if not price or price < Config.MinPrice then
                        Notify(Strings["price_low"])
                        menu.close()
                        return
                    end
                    
                    TriggerServerEvent("loaf_realtor:add_property", entrance, garageEntrance, garageExit, interiorType, interior, propertyType, name, price)
                    ESX.UI.Menu.CloseAll()
                end, CloseMenuHandler)
            end, CloseMenuHandler)
        end, CloseMenuHandler)
    end

    local function SelectInterior(cb)
        local config, shells = exports.loaf_housing:GetConfig(), exports.loaf_housing:GetShells()
        local elements = {}
        
        local elements2 = {}
        for k, v in pairs(config.Interiors) do
            table.insert(elements2, {
                label = v.label,
                interiorType = "interior",
                interior = k
            })
        end
        if #elements2 > 0 then
            table.insert(elements, {
                label = Strings["misc_interiors"],
                elements = elements2
            })
        end

        table.sort(shells)
        for category, data in pairs(shells) do
            local elements2 = {}
            for i, shell in pairs(data.shells) do
                table.insert(elements2, {
                    label = shell,
                    interiorType = "shell",
                    interior = shell
                })
            end
            if #elements2 > 0 then
                table.insert(elements, {
                    label = data.label or category,
                    elements = elements2
                })
            end
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "choose_category", {
            title = Strings["choose_interior"],
            align = Config.MenuAlign,
            elements = elements
        }, function(data, menu)
            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "choose_interior", {
                title = Strings["choose_interior"],
                align = Config.MenuAlign,
                elements = data.current.elements
            }, function(data2, menu2)
                cb(data2.current.interiorType, data2.current.interior, data2.current.label)
                menu.close()
                menu2.close()
            end, CloseMenuHandler)
        end, CloseMenuHandler)
    end

    jobActions.create = function(label)
        local entranceVector, exitVector
        local entrance, garageEntrance, garageExit, interiorType, interior

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "create_house", {
            title = label,
            align = Config.MenuAlign,
            elements = {
                {label = Strings["set_entrance"], value = "entrance"},

                {label = Strings["set_garage_entrance"], value = "garage_entrance"},
                {label = Strings["set_garage_exit"], value = "garage_exit"},

                {label = Strings["set_interior"], value = "interior"},
                
                {label = Strings["add_property"], value = "create"},
            }
        }, function(data, menu)
            if data.current.value == "entrance" then
                local coords = GetEntityCoords(PlayerPedId())
                entrance = vector4(coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()))
                entranceVector = GetEntityForwardVector(PlayerPedId())
            elseif data.current.value == "garage_entrance" then
                garageEntrance = GetEntityCoords(PlayerPedId())
            elseif data.current.value == "garage_exit" then
                local coords = not IsPedInAnyVehicle(PlayerPedId(), true) and GetEntityCoords(PlayerPedId()) or GetEntityCoords(PlayerPedId()) + vec3(0.0, 0.0, 0.5)
                garageExit = vector4(coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()))
                exitVector = GetEntityForwardVector(PlayerPedId())
            elseif data.current.value == "interior" then
                SelectInterior(function(_type, _interior, label)
                    interiorType = _type
                    interior = _interior

                    Notify(Strings["interior_set"]:format(label))
                end)
            elseif data.current.value == "create" then
                if not entrance then
                    return Notify(Strings["must_entrance"])
                end
                if not interior then
                    return Notify(Strings["must_interior"])
                end

                FinishHouseCreation(entrance, garageEntrance, garageExit, interiorType, interior)
            end
        end, CloseMenuHandler)
        
        while not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "create_house") do Wait(0) end -- wait for menu to open
        while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "create_house") do
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
    end
    -- menu to remove a house
    jobActions.remove = function()
        ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "property_remove", {
            title = Strings["property_remove"]
        }, function(data, menu)
            local propertyId = tonumber(data.value)
            if not propertyId then
                return
            end
            TriggerServerEvent("loaf_realtor:remove_property", propertyId)
            ESX.UI.Menu.CloseAll()
        end, CloseMenuHandler)
    end
    
    loaded = true
end)