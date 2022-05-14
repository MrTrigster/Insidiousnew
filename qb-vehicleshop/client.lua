-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData() -- Just for resource restart (same as event handler)
local insideZones = {}

for name, shop in pairs(Config.Shops) do -- foreach shop
    insideZones[name] = false  -- default to not being in a shop
end

local testDriveVeh, inTestDrive = 0, false
local ClosestVehicle = 1
local zones = {}

function getShopInsideOf() 
    for name, shop in pairs(Config.Shops) do -- foreach shop
        if insideZones[name] then
            return name
        end
    end
    return nil
end

-- Handlers

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    local citizenid = PlayerData.citizenid
    local gameTime = GetGameTimer()
    TriggerServerEvent('i13-vehicleshop:server:addPlayer', citizenid, gameTime)
    TriggerServerEvent('i13-vehicleshop:server:checkFinance')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    local citizenid = PlayerData.citizenid
    TriggerServerEvent('i13-vehicleshop:server:removePlayer', citizenid)
    PlayerData = {}
end)

-- Static Headers

local vehHeaderMenu = {
    {
        header = 'Vehicle Options',
        txt = 'Interact with the current vehicle',
        params = {
            event = 'i13-vehicleshop:client:showVehOptions'
        }
    }
}

local financeMenu = {
    {
        header = 'Financed Vehicles',
        txt = 'Browse your owned vehicles',
        params = {
            event = 'i13-vehicleshop:client:getVehicles'
        }
    }
}

local returnTestDrive = {
    {
        header = 'Finish Test Drive',
        params = {
            event = 'i13-vehicleshop:client:TestDriveReturn'
        }
    }
}

-- Functions

local function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

local function comma_value(amount)
    local formatted = amount
    while true do
      formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
      if (k==0) then
        break
      end
    end
    return formatted
end

local function getVehName()
    return QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["name"]
end

local function getVehPrice()
    return comma_value(QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["price"])
end

local function getVehBrand()
    return QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["brand"]
end

local function getVehClass()
    return QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["class"]
end

local function setClosestShowroomVehicle()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    local closestShop = getShopInsideOf()
    for id, veh in pairs(Config.Shops[closestShop]["ShowroomVehicles"]) do
        local dist2 = #(pos - vector3(Config.Shops[closestShop]["ShowroomVehicles"][id].coords.x, Config.Shops[closestShop]["ShowroomVehicles"][id].coords.y, Config.Shops[closestShop]["ShowroomVehicles"][id].coords.z))
        if current ~= nil then
            if dist2 < dist then
                current = id
                dist = dist2
            end
        else
            dist = dist2
            current = id
        end
    end
    if current ~= ClosestVehicle then
        ClosestVehicle = current
    end
end

local function createTestDriveReturn()
    testDriveZone = BoxZone:Create(
        Config.Shops[getShopInsideOf()]["ReturnLocation"],
        3.0,
        5.0, {
        name="box_zone"
    })

    testDriveZone:onPlayerInOut(function(isPointInside)
        if isPointInside and IsPedInAnyVehicle(PlayerPedId()) then
			SetVehicleForwardSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0)
            exports['qb-menu']:openMenu(returnTestDrive)
        else
            exports['qb-menu']:closeMenu()
        end
    end)
end

local function startTestDriveTimer(testDriveTime)
    local gameTimer = GetGameTimer()
    CreateThread(function()
        while inTestDrive do
            Wait(1)
            if GetGameTimer() < gameTimer+tonumber(1000*testDriveTime) then
                local secondsLeft = GetGameTimer() - gameTimer
                drawTxt('Test Drive Time Remaining: '..math.ceil(testDriveTime - secondsLeft/1000),4,0.5,0.93,0.50,255,255,255,180)
            end
        end
    end)
end

local function isInShop() 
    for shopName, isInside in pairs(insideZones) do
        if isInside then
            return true
        end
    end

    return false
end

local function createVehZones(shopName) -- This will create an entity zone if config is true that you can use to target and open the vehicle menu
    if not Config.UsingTarget then
        for i = 1, #Config.Shops[shopName]['ShowroomVehicles'] do
            zones[#zones+1] = BoxZone:Create(
                vector3(Config.Shops[shopName]['ShowroomVehicles'][i]['coords'].x,
                Config.Shops[shopName]['ShowroomVehicles'][i]['coords'].y,
                Config.Shops[shopName]['ShowroomVehicles'][i]['coords'].z),
                2.75,
                2.75, {
                name="box_zone",
                debugPoly=false,
            })
        end
        local combo = ComboZone:Create(zones, {name = "vehCombo", debugPoly = false})
        combo:onPlayerInOut(function(isPointInside)
            local insideShop = getShopInsideOf()
            if isPointInside then
                if PlayerData.job.name == Config.Shops[insideShop]['Job'] or Config.Shops[insideShop]['Job'] == 'none' then
                    exports['qb-menu']:showHeader(vehHeaderMenu)
                end
            else
                exports['qb-menu']:closeMenu()
            end
        end)
    else
        exports['qb-target']:AddGlobalVehicle({
            options = {
                {
                    type = "client",
                    event = "i13-vehicleshop:client:showVehOptions",
                    icon = "fas fa-car",
                    label = "Sõiduki Tegevused",
                    canInteract = function(entity)
                        local closestShop = getShopInsideOf()
                        if (closestShop ~= nil) and (Config.Shops[closestShop]['Job'] == 'none' or PlayerData.job.name == Config.Shops[closestShop]['Job']) then
                            return true
                        end
                        return false
                    end
                },
            },
            distance = 2.0
        })
    end
end

-- Zones

function createFreeUseShop(shopShape, name)
    local zone = PolyZone:Create(shopShape, {  -- create the zone
        name= name,
        minZ = shopShape.minZ,
        maxZ = shopShape.maxZ
    })
    
    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            insideZones[name] = true
            CreateThread(function()
                while insideZones[name] do
                    setClosestShowroomVehicle()
                    vehicleMenu = {
                        {
                            isMenuHeader = true,
                            header = getVehBrand():upper().. ' '..getVehName():upper().. ' - $' ..getVehPrice().. ' | Class: ' ..getVehClass():upper(),
                        },
                        {
                            header = "Osta Sõiduk",
                            txt = 'Osta hetkel valitud sõiduk',
                            params = {
                                isServer = true,
                                event = 'i13-vehicleshop:server:buyShowroomVehicle',
                                args = {
                                    buyVehicle = Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle
                                }
                            }
                        },
                        {
                            header = 'Vaheta Sõidukit',
                            txt = 'Vaheta display sõidukit',
                            params = {
                                event = 'i13-vehicleshop:client:vehCategories',
                                args = {
                                    shopName = name
                                }
                            }
                        },
                    }
                    Wait(1000)
                end
            end)
        else
            insideZones[name] = false -- leave the shops zone
            ClosestVehicle = 1
        end
    end)
end

function createManagedShop(shopShape, name, jobName)
    local zone = PolyZone:Create(shopShape, {  -- create the zone
        name= name,
        minZ = shopShape.minZ,
        maxZ = shopShape.maxZ
    })
    
    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            insideZones[name] = true
            CreateThread(function()
                while insideZones[name] and PlayerData.job ~= nil and PlayerData.job.name == Config.Shops[name]['Job'] do
                    setClosestShowroomVehicle()
                    local closestShop = getShopInsideOf()
                    vehicleMenu = {
                        {
                            isMenuHeader = true,
                            header = getVehBrand():upper().. ' '..getVehName():upper().. ' - $' ..getVehPrice().. ' | Class: ' ..getVehClass():upper(),
                        },
                        {
                            header = "Müü Sõiduk",
                            txt = 'Müü see sõiduk isikule',
                            params = {
                                event = 'i13-vehicleshop:client:openIdMenu',
                                args = {
                                    vehicle = Config.Shops[closestShop]["ShowroomVehicles"][ClosestVehicle].chosenVehicle,
                                    type = 'sellVehicle'
                                }
                            }
                        },
                        {
                            header = 'Vaheta Sõidukit',
                            txt = 'Vaheta display sõidukit',
                            params = {
                                event = 'i13-vehicleshop:client:vehCategories',
                                args = {
                                    shopName = name
                                }
                            }
                        },
                    }
                    Wait(1000)
                end
            end)
        else
            insideZones[name] = false -- leave the shops zone
            ClosestVehicle = 1
        end
    end)
end

for name, shop in pairs(Config.Shops) do 
    if shop['Type'] == 'free-use' then
        createFreeUseShop(shop['Zone']['Shape'], name)
    elseif shop['Type'] == 'managed' then
        createManagedShop(shop['Zone']['Shape'], name)
    end
end

-- Events

RegisterNetEvent('i13-vehicleshop:client:homeMenu', function()
    exports['qb-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent('i13-vehicleshop:client:showVehOptions', function()
    exports['qb-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent('i13-vehicleshop:client:TestDrive', function()
    if not inTestDrive and ClosestVehicle ~= 0 then
        inTestDrive = true
        local prevCoords = GetEntityCoords(PlayerPedId())
        QBCore.Functions.SpawnVehicle(Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle, function(veh)
            local closestShop = getShopInsideOf()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            exports['LegacyFuel']:SetFuel(veh, 100)
            SetVehicleNumberPlateText(veh, 'TESTDRIVE')
            SetEntityAsMissionEntity(veh, true, true)
            SetEntityHeading(veh, Config.Shops[closestShop]["VehicleSpawn"].w)
            TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
            TriggerServerEvent('i13-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
            testDriveVeh = veh
            QBCore.Functions.Notify('You have '..Config.Shops[closestShop]["TestDriveTimeLimit"]..' minutes remaining')
            SetTimeout(Config.Shops[closestShop]["TestDriveTimeLimit"] * 60000, function()
                if testDriveVeh ~= 0 then
                    testDriveVeh = 0
                    inTestDrive = false
                    QBCore.Functions.DeleteVehicle(veh)
                    SetEntityCoords(PlayerPedId(), prevCoords)
                    QBCore.Functions.Notify('Vehicle test drive complete')
                end
            end)
        end, Config.Shops[getShopInsideOf()]["VehicleSpawn"], false)
        createTestDriveReturn()
        startTestDriveTimer(Config.Shops[getShopInsideOf()]["TestDriveTimeLimit"] * 60)
    else
        QBCore.Functions.Notify('Already in test drive', 'error')
    end
end)

RegisterNetEvent('i13-vehicleshop:client:customTestDrive', function(data)
    if not inTestDrive then
        inTestDrive = true
        shopInsideOf = getShopInsideOf()
        local vehicle = data
        local prevCoords = GetEntityCoords(PlayerPedId())
        QBCore.Functions.SpawnVehicle(vehicle, function(veh)
            local shopInsideOf = getShopInsideOf()
            exports['LegacyFuel']:SetFuel(veh, 100)
            SetVehicleNumberPlateText(veh, 'TESTDRIVE')
            SetEntityAsMissionEntity(veh, true, true)
            SetEntityHeading(veh, Config.Shops[shopInsideOf]["VehicleSpawn"].w)
            TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
            TriggerServerEvent('i13-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
            testDriveVeh = veh
            QBCore.Functions.Notify('You have '..Config.Shops[shopInsideOf]["TestDriveTimeLimit"]..' minutes remaining')
            SetTimeout(Config.Shops[shopInsideOf]["TestDriveTimeLimit"] * 60000, function()
                if testDriveVeh ~= 0 then
                    testDriveVeh = 0
                    inTestDrive = false
                    QBCore.Functions.DeleteVehicle(veh)
                    SetEntityCoords(PlayerPedId(), prevCoords)
                    QBCore.Functions.Notify('Vehicle test drive complete')
                end
            end)
        end, Config.Shops[shopInsideOf]["VehicleSpawn"], false)
        createTestDriveReturn()
        startTestDriveTimer(Config.Shops[shopInsideOf]["TestDriveTimeLimit"] * 60)
    else
        QBCore.Functions.Notify('Already in test drive', 'error')
    end
end)

RegisterNetEvent('i13-vehicleshop:client:TestDriveReturn', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh == testDriveVeh then
        testDriveVeh = 0
        inTestDrive = false
        QBCore.Functions.DeleteVehicle(veh)
        exports['qb-menu']:closeMenu()
        testDriveZone:destroy()
    else
        QBCore.Functions.Notify('This is not your test drive vehicle', 'error')
    end
end)

RegisterNetEvent('i13-vehicleshop:client:vehCategories', function(data)
    local categoryMenu = {
        {
            header = '< Tagasi',
            params = {
                event = 'i13-vehicleshop:client:homeMenu'
            }
        }
    }
    for k,v in pairs(Config.Shops[getShopInsideOf()]['Categories']) do
        categoryMenu[#categoryMenu + 1] = {
            header = v,
            params = {
                event = 'i13-vehicleshop:client:openVehCats',
                args = {
                    catName = k,
                    shopName = data.shopName
                }
            }
        }
    end
    exports['qb-menu']:openMenu(categoryMenu)
end)

RegisterNetEvent('i13-vehicleshop:client:openVehCats', function(data)
    local vehicleMenu = {
        {
            header = '< Tagasi',
            params = {
                event = 'i13-vehicleshop:client:vehCategories',
                args = {
                    shopName = data.shopName
                }
            }
        }
    }
    for k,v in pairs(QBCore.Shared.Vehicles) do
        if QBCore.Shared.Vehicles[k]["category"] == data.catName and QBCore.Shared.Vehicles[k]["shop"] == getShopInsideOf() then
            vehicleMenu[#vehicleMenu + 1] = {
                header = v.name.. ' | Class: ' ..v.class,
                txt = 'Hind: $'..v.price,
                params = {
                    isServer = true,
                    event = 'i13-vehicleshop:server:swapVehicle',
                    args = {
                        toVehicle = v.model,
                        ClosestVehicle = ClosestVehicle,
                        ClosestShop = getShopInsideOf()
                    }
                }
            }
        end
    end
    exports['qb-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent('i13-vehicleshop:client:openStockTable', function()
    local stockMenu = {
        {
            isMenuHeader = true,
            header = 'Laoseisu Tabel',
        }
    }
    QBCore.Functions.TriggerCallback('i13-vehicleshop:server:getVehicleStock', function(result)
        if result then
            for k,v in pairs(result) do
                stockMenu[#stockMenu + 1] = {
                    header = v.name,
                    txt = 'Stock: '..v.stock,
                    params = {
                        event = 'i13-vehicleshop:client:selectedStockInfo',
                        args = {
                            vehName = v.name,
                            vehModel = v.model,
                            orderPrice = v.restock,
                            currentStock = v.stock,
                        }
                    }
                }
            end
            exports['qb-menu']:openMenu(stockMenu)
        end
    end, 'import')
end)

RegisterNetEvent('i13-vehicleshop:client:selectedStockInfo', function(data)
    local currentStockMenu = {
        {
            isMenuHeader = true,
            header = data.vehName..' | Stock: '..data.currentStock,
        },
        {
            header = 'Telli Juurde | $'..data.orderPrice..' tk',
            txt = 'Telli seda sõidukit juurde',
            params = {
                event = 'i13-vehicleshop:client:selectedStockAmount',
                args = {
                    model = data.vehModel,
                    price = data.orderPrice,
                }
            }
        }
    }
    exports['qb-menu']:openMenu(currentStockMenu)
end)

RegisterNetEvent('i13-vehicleshop:client:selectedStockAmount', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = 'Telli Juurde',
        submitText = 'Telli',
        inputs = {
            {
                text = 'Kogus',
                name = 'ordernum',
                type = 'number',
                isRequired = true
            }
        }
    })
    if dialog then
        if not dialog.ordernum then return end
        TriggerServerEvent('i13-vehicleshop:server:orderMoreStock', data.model, data.price, dialog.ordernum)
    end
end)

RegisterNetEvent('i13-vehicleshop:client:openFinance', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = getVehBrand():upper().. ' ' ..data.buyVehicle:upper().. ' - $' ..data.price,
        submitText = "Submit",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'downPayment',
                text = 'Down Payment Amount - Min ' ..Config.MinimumDown..'%'
            },
            {
                type = 'number',
                isRequired = true,
                name = 'paymentAmount',
                text = 'Total Payments - Min '..Config.MaximumPayments
            }
        }
    })
    if dialog then
        if not dialog.downPayment or not dialog.paymentAmount then return end
        TriggerServerEvent('i13-vehicleshop:server:financeVehicle', dialog.downPayment, dialog.paymentAmount, data.buyVehicle)
    end
end)

RegisterNetEvent('i13-vehicleshop:client:openCustomFinance', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {"tablet2"})
    local dialog = exports['qb-input']:ShowInput({
        header = getVehBrand():upper().. ' ' ..data.vehicle:upper().. ' - $' ..data.price,
        submitText = "Submit",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'downPayment',
                text = 'Down Payment Amount - Min 10%'
            },
            {
                type = 'number',
                isRequired = true,
                name = 'paymentAmount',
                text = 'Total Payments - Max '..Config.MaximumPayments
            },
            {
                text = "Server ID (#)",
                name = "playerid", 
                type = "number",
                isRequired = true
            }
        }
    })
    if dialog then
        if not dialog.downPayment or not dialog.paymentAmount or not dialog.playerid then return end
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('i13-vehicleshop:server:sellfinanceVehicle', dialog.downPayment, dialog.paymentAmount, data.vehicle, dialog.playerid)
    end
end)

RegisterNetEvent('i13-vehicleshop:client:swapVehicle', function(data)
    local shopName = data.ClosestShop
    if Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].chosenVehicle ~= data.toVehicle then
        local closestVehicle, closestDistance = QBCore.Functions.GetClosestVehicle(vector3(Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.x, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.y, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.z))
        if closestVehicle == 0 then return end
        if closestDistance < 5 then QBCore.Functions.DeleteVehicle(closestVehicle) end
        while DoesEntityExist(closestVehicle) do
            Wait(50)
        end
        Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].chosenVehicle = data.toVehicle
        local model = GetHashKey(data.toVehicle)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(50)
        end
        local veh = CreateVehicle(model, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.x, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.y, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.z, false, false)
        while not DoesEntityExist(veh) do
            Wait(50)
        end
        SetModelAsNoLongerNeeded(model) 
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh,true)
        SetEntityHeading(veh, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.w)
        SetVehicleDoorsLocked(veh, 3)
        FreezeEntityPosition(veh, true)
        SetVehicleNumberPlateText(veh, 'OSTAMIND')
    end
end)

RegisterNetEvent('i13-vehicleshop:client:buyShowroomVehicle', function(vehicle, plate)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        exports['LegacyFuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, plate)
        SetEntityHeading(veh, Config.Shops[getShopInsideOf()]["VehicleSpawn"].w)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        TriggerServerEvent("i13-vehicletuning:server:SaveVehicleProps", QBCore.Functions.GetVehicleProperties(veh))
    end, Config.Shops[getShopInsideOf()]["VehicleSpawn"], true)
end)

RegisterNetEvent('i13-vehicleshop:client:getVehicles', function()
    QBCore.Functions.TriggerCallback('i13-vehicleshop:server:getVehicles', function(vehicles)
        local ownedVehicles = {}
        for k,v in pairs(vehicles) do
            if v.balance then
                local name = QBCore.Shared.Vehicles[v.vehicle]["name"]
                local plate = v.plate:upper()
                ownedVehicles[#ownedVehicles + 1] = {
                    header = ''..name..'',
                    txt = 'Numbrimärk: ' ..plate,
                    params = {
                        event = 'i13-vehicleshop:client:getVehicleFinance',
                        args = {
                            vehiclePlate = plate,
                            balance = v.balance,
                            paymentsLeft = v.paymentsleft,
                            paymentAmount = v.paymentamount
                        }
                    }
                }
            end
        end
        exports['qb-menu']:openMenu(ownedVehicles)
    end)
end)

RegisterNetEvent('i13-vehicleshop:client:getVehicleFinance', function(data)
    local vehFinance = {
        {
            header = '< Go Back',
            params = {
                event = 'i13-vehicleshop:client:getVehicles'
            }
        },
        {
            isMenuHeader = true,
            header = 'Total Balance Remaining',
            txt = '$'..comma_value(data.balance)..''
        },
        {
            isMenuHeader = true,
            header = 'Total Payments Remaining',
            txt = ''..data.paymentsLeft..''
        },
        {
            isMenuHeader = true,
            header = 'Recurring Payment Amount',
            txt = '$'..comma_value(data.paymentAmount)..''
        },
        {
            header = 'Make a payment',
            params = {
                event = 'i13-vehicleshop:client:financePayment',
                args = {
                    vehData = data,
                    paymentsLeft = data.paymentsleft,
                    paymentAmount = data.paymentamount
                }
            }
        },
        {
            header = 'Payoff vehicle',
            params = {
                isServer = true,
                event = 'i13-vehicleshop:server:financePaymentFull',
                args = {
                    vehBalance = data.balance,
                    vehPlate = data.vehiclePlate
                }
            }
        },
    }
    exports['qb-menu']:openMenu(vehFinance)
end)

RegisterNetEvent('i13-vehicleshop:client:financePayment', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = 'Vehicle Payment',
        submitText = "Make Payment",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'paymentAmount',
                text = 'Payment Amount ($)'
            }
        }
    })
    if dialog then
        if not dialog.paymentAmount then return end
        TriggerServerEvent('i13-vehicleshop:server:financePayment', dialog.paymentAmount, data.vehData)
    end
end)

RegisterNetEvent('i13-vehicleshop:client:openIdMenu', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = QBCore.Shared.Vehicles[data.vehicle]["name"],
        submitText = "Kinnita",
        inputs = {
            {
                text = "Mängija ID (#)",
                name = "playerid", 
                type = "number",
                isRequired = true
            }
        }
    })
    if dialog then
        if not dialog.playerid then return end
        if data.type == 'testDrive' then
            TriggerServerEvent('i13-vehicleshop:server:customTestDrive', data.vehicle, dialog.playerid)
        elseif data.type == 'sellVehicle' then
            TriggerServerEvent('i13-vehicleshop:server:sellShowroomVehicle', data.vehicle, dialog.playerid)
        end
    end
end)

RegisterNetEvent('i13-vehicleshop:client:transferVehicle', function(buyerId, amount)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local plate = QBCore.Functions.GetPlate(vehicle)
    local tcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(buyerId)))
    if #(GetEntityCoords(ped)-tcoords) < 5.0 then
        TriggerServerEvent('i13-vehicleshop:server:transferVehicle', plate, buyerId, amount)
    else
        QBCore.Functions.Notify('Isik kellele müüa tahad on liiga kaugel')
    end
end)

RegisterNetEvent('i13-vehicleshop:client:tpPoliceStorage', function()
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(1000)
    SetEntityCoords(ped, 1004.42, -2997.48, -48.65, 0, 0, 0, false)
    SetEntityHeading(ped, 87.48)
    Wait(1000)
    DoScreenFadeIn(600)
end)

RegisterNetEvent('i13-vehicleshop:client:tpPoliceStorageOut', function()
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(1000)
    SetEntityCoords(ped, 850.13, -1284.26, 27.0, 0, 0, 0, false)
    SetEntityHeading(ped, 272.89)
    Wait(1000)
    DoScreenFadeIn(600)
end)

-- Threads

CreateThread(function()
    exports['qb-target']:AddBoxZone('importStock', vector3(-1256.58, -369.02, 36.91), 0.8, 0.8, {
        name = 'importStock',
        heading = 300,
        debugPoly = false,
        minZ = 35.91,
        maxZ = 37.51
    }, {
        options = {
            {
                type = 'client',
                event = 'i13-vehicleshop:client:openStockTable',
                icon = 'fas fa-clipboard-list',
                label = 'Vaata Laoseisu',
                job = 'import',
            }
        },
        distance = 2.0,
    })

    exports['qb-target']:AddBoxZone('pdupperdoor', vector3(848.81, -1284.34, 28.0), 0.6, 1.4, {
        name = 'pdupperdoor',
        heading = 90,
        debugPoly = false,
        minZ = 27.0,
        maxZ = 29.55
    }, {
        options = {
            {
                type = 'client',
                event = 'i13-vehicleshop:client:tpPoliceStorage',
                label = 'Mine Lattu',
                icon = 'fas fa-door-closed',
                job = {['police']=7},
            }
        },
        distance = 2.0,
    })

    exports['qb-target']:AddBoxZone('pdlowerdoor', vector3(1005.19, -2997.62, -47.65), 0.4, 1.5, {
        name = 'pdlowerdoor',
        heading = 90,
        debugPoly = false,
        minZ = -48.65,
        maxZ = 46.25
    }, {
        options = {
            {
                type = 'client',
                event = 'i13-vehicleshop:client:tpPoliceStorageOut',
                label = 'Mine Välja',
                icon = 'fas fa-door-closed',
                job = 'police',
            }
        },
        distance = 2.0,
    })
end)

CreateThread(function()
    for k,v in pairs(Config.Shops) do
        if v.showBlip then
	    local Dealer = AddBlipForCoord(Config.Shops[k]["Location"])
	    SetBlipSprite (Dealer, 225)
        SetBlipDisplay(Dealer, 4)
        SetBlipScale  (Dealer, 0.75)
	    SetBlipAsShortRange(Dealer, true)
	    SetBlipColour(Dealer, 3)
        BeginTextCommandSetBlipName("STRING")
	    AddTextComponentSubstringPlayerName(Config.Shops[k]["ShopLabel"])
	    EndTextCommandSetBlipName(Dealer)
	end
    end
end)

--[[CreateThread(function()
    local financeZone = BoxZone:Create(Config.FinanceZone, 2.0, 2.0, {
        name="financeZone",
        offset={0.0, 0.0, 0.0},
        scale={1.0, 1.0, 1.0},
        debugPoly=false,
    })

    financeZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            exports['qb-menu']:showHeader(financeMenu)
        else
            exports['qb-menu']:closeMenu()
        end
    end)
end)]]

CreateThread(function()
    for k,v in pairs(Config.Shops) do
        for i = 1, #Config.Shops[k]['ShowroomVehicles'] do
            local model = GetHashKey(Config.Shops[k]["ShowroomVehicles"][i].defaultVehicle)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            local veh = CreateVehicle(model, Config.Shops[k]["ShowroomVehicles"][i].coords.x, Config.Shops[k]["ShowroomVehicles"][i].coords.y, Config.Shops[k]["ShowroomVehicles"][i].coords.z, false, false)
            SetModelAsNoLongerNeeded(model)
            SetEntityAsMissionEntity(veh, true, true)
            SetVehicleOnGroundProperly(veh)
            SetEntityInvincible(veh,true)
            SetVehicleDirtLevel(veh, 0.0)
            SetVehicleDoorsLocked(veh, 3)
            SetEntityHeading(veh, Config.Shops[k]["ShowroomVehicles"][i].coords.w)
            FreezeEntityPosition(veh,true)
            SetVehicleNumberPlateText(veh, 'OSTAMIND')
        end
			
        createVehZones(k)
    end
end)
