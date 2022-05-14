local QBCore = exports['qb-core']:GetCoreObject()


CreateThread(function()
    for k, v in pairs(Config.location) do
        exports['qb-target']:AddBoxZone(v.name, v.coords, 1, 4, {
            name = v.name,
            heading = v.heading,
            debugPoly = false,
            minZ = v.minz,
            maxZ = v.maxz,
        }, {
            options = {
                {
                  type = "client",
                  action = function(entity) 
                    TriggerEvent('re2-vault:viewStorages', k)
                  end,
                  icon = "fas fa-box-open",
                  label = "Vaata Kappi",
                },
                {
                    type = "client",
                    action = function(entity) 
                      TriggerEvent('re2-vault:createStorage', k)
                    end,
                    icon = "fas fa-boxes",
                    label = "Osta Kapp $7,500",
                  },
            },
            distance = 2.5
        })
    end
    
  end)

AddEventHandler('re2-vault:viewStorages', function(location)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    local p = nil
    local data ={
        cid = citizenid,
        storagelocation = Config.location[location].name,
    }
    local fetchStoragePromise = function(data)
        if p then return end
        p = promise.new()
        QBCore.Functions.TriggerCallback('re2-vault:server:fetchStorage', function(result)
            p:resolve(result)
        end, data)
        return Citizen.Await(p)
    end
    
    local result = fetchStoragePromise(data)
    p = nil
    if result then
        local storagesMenu = {
            {
                header = "Sinu Kapid "..Config.location[location].name,
                isMenuHeader = true
            }
        }

        for k, v in pairs(result) do
            storagesMenu[#storagesMenu+1] = {
                header = v.storagename,
                txt = "Ruum : "..(v.storage_size/1000).." -- Omanik : "..v.citizenid,
                params = {
                    event = "re2-vault:openStorageMenu",
                    args = {
                        storageid = v.id
                    }
                }

            }
        end

        storagesMenu[#storagesMenu+1] = {
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }

        }
        exports['qb-menu']:openMenu(storagesMenu)
    else
        QBCore.Functions.Notify("Siin ei ole kappi", "error")
    end
end)


AddEventHandler('re2-vault:openStorageMenu', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local dialog = exports['qb-input']:ShowInput({
        header = "Kapi Parool",
        submitText = "Kinnita",
        inputs = {
            {
                text = "Parool", -- text you want to be displayed as a place holder
                name = "password", -- name of the input should be unique otherwise it might override
                type = "password", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if dialog ~= nil then
        local p = nil
        local data ={
            password = dialog.password,
            id = data.storageid
        }
        local openStoragePromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:checkThePassword', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = openStoragePromise(data)
        p = nil
        if result then
            local v = result[1]
            local storageMenu = {
                {
                    isHeader = true,
                    header = 'Kapp '..v.storagename
                },
                {
                    header = '📦 | Ava Kapp',
                    txt = 'Ava '..v.storagename .." kapp",
                    params = {
                        event = 're2-vault:openInventory',
                        args = {
                            storagename = v.storage_location..'_'..v.storagename..'_'..v.citizenid,
                            storagesize = v.storage_size
                        }
                    }
                }
            }
            if citizenid == v.citizenid then
                local addmembermenu={
                    header = '➕ | Lisa Liige',
                    txt = 'Lisa liikmeid '..v.storagename..' kappi',
                    params = {
                        event = 're2-vault:addMemberToStorage',
                        args = {
                            storageid = v.id,
                        }
                    }
                }
                table.insert(storageMenu,addmembermenu)
                local removememberMenu={
                    header = '➖ | Eemalda Liige',
                    txt = 'Eemalda liikmeid '..v.storagename..' kapist',
                    params = {
                        event = 're2-vault:removeMemberFromStorage',
                        args = {
                            storageid = v.id
                        }
                    }
                }
                table.insert(storageMenu,removememberMenu)
                local addstorageMenu={
                    header = '🛒 | Lisa Ruumi $3,500',
                    txt = 'Lisa 200KG '..v.storagename..' kapile',
                    params = {
                        event = 're2-vault:addCapacity',
                        args = {
                            storageid = v.id
                        }
                    }
                }
                table.insert(storageMenu,addstorageMenu) 
            end
            local closeMenu={
                header = "Sulge Menu",
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            }
            table.insert(storageMenu,closeMenu) 
              exports['qb-menu']:openMenu(storageMenu)
            QBCore.Functions.Notify("Õige Parool", "success")
        else
            QBCore.Functions.Notify("Vale Parool", "error")
        end
    end
end)

AddEventHandler('re2-vault:createStorage', function(location)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    local cpdialog = exports['qb-input']:ShowInput({
        header = "Loo Parool",
        submitText = "Kinnita",
        inputs = {
            {
                text = "Nimi", -- text you want to be displayed as a place holder
                name = "name", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            {
                text = "Parool", -- text you want to be displayed as a place holder
                name = "password", -- name of the input should be unique otherwise it might override
                type = "password", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })
    if cpdialog ~= nil then
        if player.money['cash'] >= tonumber(Config.StorageCreationAmount) then
        local p = nil
        local data ={
            cid = citizenid,
            password = cpdialog.password,
            storagename = cpdialog.name,
            storagelocation = Config.location[location].name,
            storagesize = Config.StorageDefaultWeight
        }
        local createStoragePromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:createStorage', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = createStoragePromise(data)
        p = nil
        if result then
            TriggerServerEvent('re2-vault:server:removeCreateMoney')
            QBCore.Functions.Notify("Kapp Ostetud", "success")
        else
            QBCore.Functions.Notify("See nimi on juba olemas", "error")
        end
        -- return cb(result)
    else
        QBCore.Functions.Notify("Sul ei ole piisavalt sularaha", "error")
    end
    end


end)


AddEventHandler('re2-vault:addMemberToStorage', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local mdialog = exports['qb-input']:ShowInput({
        header = "Lisa Liige",
        submitText = "Kinnita",
        inputs = {
            {
                text = "Liikme Isikukood", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if mdialog ~= nil then
        local p = nil
        local data ={
            citizenid = mdialog.citizenid,
            id = data.storageid
        }
        local addMemberPromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:addMember', function(result)
                print(json.encode(result))
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = addMemberPromise(data)
        p = nil
        if result then
            QBCore.Functions.Notify("Liige lisatud", "success")
        else
            QBCore.Functions.Notify("Midagi läks valesti", "error")
        end
    end
end)

AddEventHandler('re2-vault:removeMemberFromStorage', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local mdialog = exports['qb-input']:ShowInput({
        header = "Eemalda Liige",
        submitText = "Kinnita",
        inputs = {
            {
                text = "Liikme Isikukood", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if mdialog ~= nil then
        local p = nil
        local data ={
            citizenid = mdialog.citizenid,
            id = data.storageid
        }
        local removeMemberPromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:removeMember', function(result)
                print(json.encode(result))
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = removeMemberPromise(data)
        p = nil
        if result then
            QBCore.Functions.Notify("Liige edukalt eemaldatud", "success")
        else
            QBCore.Functions.Notify("Midagi läks valesti", "error")
        end
    end
end)

AddEventHandler('re2-vault:openInventory', function(data)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", data.storagename,{
            maxweight = data.storagesize,
            slots = Config.StorageSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", data.storagename)
        QBCore.Functions.Notify("Kapp Avaneb...", "success")

    
end)


AddEventHandler('re2-vault:addCapacity', function(data)
    local player=QBCore.Functions.GetPlayerData()
    if player.money['cash'] >= tonumber(Config.StorageAddPrice) then
    local p = nil
    local data ={
        id = data.storageid
    }
    local addCapacityPromise = function(data)
        if p then return end
        p = promise.new()
        QBCore.Functions.TriggerCallback('re2-vault:server:addCapacity', function(result)
            print(json.encode(result))
            p:resolve(result)
        end, data)
        return Citizen.Await(p)
    end
    
    local result = addCapacityPromise(data)
    p = nil
    if result then
        TriggerServerEvent('re2-vault:server:removeAddMoney')
        QBCore.Functions.Notify("Lisasid kapile ruumi juurde", "success")
    else
        QBCore.Functions.Notify("Midagi läks valesti", "error")
    end
else
    QBCore.Functions.Notify("Sul ei ole piisavalt sularaha", "error")
end


end)



