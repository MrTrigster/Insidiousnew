local QBCore = exports['qb-core']:GetCoreObject()

local ped = nil

-- Functions

--[[local function SetupItems(shop)
    local products = Config.Locations[shop].products
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end ]]

local function SetupShopItems()
    local products = Config.Products['normal']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function SetupHardwareItems()
    local products = Config.Products['hardware']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function SetupAlkoItems()
    local products = Config.Products['alcohol']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function SetupAmmunationItems()
    local products = Config.Products['weapons']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function SetupPharmacyItems()
    local products = Config.Products['pharmacy']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function SetupPartsItems()
    local products = Config.Products['parts']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function SetupWeedItems()
    local products = Config.Products['weed']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function SetupMethItems()
    local products = Config.Products['meth']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function SetupWeapItems()
    local products = Config.Products['weap']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function SetupPetshopItems()
    local products = Config.Products['petshop']
    local playerJob = QBCore.Functions.GetPlayerData().job.name
    local items = {}
    for i = 1, #products do
        if not products[i].requiredJob then
            items[#items+1] = products[i]
        else
            for i2 = 1, #products[i].requiredJob do
                if playerJob == products[i].requiredJob[i2] then
                    items[#items+1] = products[i]
                end
            end
        end
    end
    return items
end

local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Events

RegisterNetEvent('i13-shops:client:UpdateShop', function(shop, itemData, amount)
    TriggerServerEvent('i13-shops:server:UpdateShopItems', shop, itemData, amount)
end)

RegisterNetEvent('i13-shops:client:SetShopItems', function(shop, shopProducts)
    Config.Locations[shop]['products'] = shopProducts
end)

RegisterNetEvent('i13-shops:client:RestockShopItems', function(shop, amount)
    if Config.Locations[shop]['products'] ~= nil then
        for k, v in pairs(Config.Locations[shop]['products']) do
            Config.Locations[shop]['products'][k].amount = Config.Locations[shop]['products'][k].amount + amount
        end
    end
end)

RegisterNetEvent('i13-shops:client:OpenShop', function()
    local products = Config.Products['normal']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Pood'

    ShopItems.items = SetupShopItems()

    for k, v in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    ShopItems.slots = 30
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_shop', ShopItems)
end)

RegisterNetEvent('i13-shops:client:OpenHardwareShop', function()
    local products = Config.Products['hardware']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Tööriistapood'

    ShopItems.items = SetupHardwareItems()

    for k, v in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    ShopItems.slots = 30
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_hardware', ShopItems)
end)

RegisterNetEvent('i13-shops:client:OpenAlkoShop', function()
    local products = Config.Products['alcohol']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Alkopood'

    ShopItems.items = SetupAlkoItems()

    for k, v in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    ShopItems.slots = 30
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_alko', ShopItems)
end)

RegisterNetEvent('i13-shops:client:OpenAmmunationShop', function()
    local products = Config.Products['weapons']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Relvapood'
    QBCore.Functions.TriggerCallback('i13-shops:server:getLicenseStatus', function(hasLicense, hasLicenseItem)
        if hasLicense and hasLicenseItem then
            ShopItems.items = SetupAmmunationItems()
            QBCore.Functions.Notify('Poemüüja kinnitas su relvaloa', 'success')
            Wait(500)
        else
            for i = 1, #products do
                if not products[i].requiredJob then
                    if not products[i].requiresLicense then
                        ShopItems.items[#ShopItems.items+1] = products[i]
                    end
                else
                    for i2 = 1, #products[i].requiredJob do
                        if QBCore.Functions.GetPlayerData().job.name == products[i].requiredJob[i2] and not products[i].requiresLicense then
                            ShopItems.items[#ShopItems.items+1] = products[i]
                        end
                    end
                end
            end
            QBCore.Functions.Notify('Poemüüja keeldus relvade näitamisest', 'error')
            Wait(500)
            QBCore.Functions.Notify('Räägi politseinikuga, et relvaluba saada', 'error')
            Wait(1000)
        end

        for k, v in pairs(ShopItems.items) do
            ShopItems.items[k].slot = k
        end
        ShopItems.slots = 30
        TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_ammunation', ShopItems)
    end)
end)

RegisterNetEvent('i13-shops:client:OpenPharmacyShop', function()
    local products = Config.Products['pharmacy']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Apteek'

    ShopItems.items = SetupPharmacyItems()

    for k, v in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    ShopItems.slots = 30
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_pharmacy', ShopItems)
end)

RegisterNetEvent('i13-shops:client:OpenPartsShop', function()
    local products = Config.Products['parts']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Autoosad'

    ShopItems.items = SetupPartsItems()

    for k, v in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    ShopItems.slots = 30
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_parts', ShopItems)
end)

RegisterNetEvent('i13-shops:client:OpenWeedShop', function()
    local products = Config.Products['weed']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Smoke On The Water'

    ShopItems.items = SetupWeedItems()

    for k, v in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    ShopItems.slots = 30
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_weed', ShopItems)
end)

RegisterNetEvent('i13-shops:client:OpenMethShop', function()
    local products = Config.Products['meth']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Meth'

    ShopItems.items = SetupMethItems()

    for k, v in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    ShopItems.slots = 30
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_meth', ShopItems)
end)

RegisterNetEvent('i13-shops:client:openWeapShop', function()
    local products = Config.Products['weap']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Relvad'

    ShopItems.items = SetupWeapItems()

    for k, v in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    ShopItems.slots = 30
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_weap', ShopItems)
end)

RegisterNetEvent('i13-shops:client:openPetShop', function()
    local products = Config.Products['petshop']
    local ShopItems = {}
    ShopItems.items = {}
    ShopItems.label = 'Loomapood'

    ShopItems.items = SetupPetshopItems()

    for k, v in pairs(ShopItems.items) do
        ShopItems.items[k].slot = k
    end
    ShopItems.slots = 30
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'store_petshop', ShopItems)
end)

-- Threads

--[[CreateThread(function()
    while true do
        local InRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        for shop, _ in pairs(Config.Locations) do
            if Config.Locations[shop].type ~= 'blackmarket' or Config.Locations[shop].type ~= 'gustavo' or Config.Locations[shop].type ~= 'ernesto' then
                local position = Config.Locations[shop]['coords']
                local products = Config.Locations[shop].products
                for _, loc in pairs(position) do
                    local dist = #(PlayerPos - vector3(loc['x'], loc['y'], loc['z']))
                    if dist < 10 then
                        InRange = true
                        DrawMarker(2, loc['x'], loc['y'], loc['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 255, 255, 155, 0, 0, 0, 1, 0, 0, 0)
                        if dist < 1 then
                            DrawText3Ds(loc['x'], loc['y'], loc['z'] + 0.15, '~g~[E]~w~ - Pood')
                            if IsControlJustPressed(0, 38) then -- E
                                local ShopItems = {}
                                ShopItems.items = {}
                                QBCore.Functions.TriggerCallback('i13-shops:server:getLicenseStatus', function(hasLicense, hasLicenseItem)
                                    ShopItems.label = Config.Locations[shop]['label']
                                    if Config.Locations[shop].type == 'weapon' then
                                        if hasLicense and hasLicenseItem then
                                            ShopItems.items = SetupItems(shop)
                                            QBCore.Functions.Notify('Poemüüja kinnitas su relvaloa', 'success')
                                            Wait(500)
                                        else
                                            for i = 1, #products do
                                                if not products[i].requiredJob then
                                                    if not products[i].requiresLicense then
                                                        ShopItems.items[#ShopItems.items+1] = products[i]
                                                    end
                                                else
                                                    for i2 = 1, #products[i].requiredJob do
                                                        if QBCore.Functions.GetPlayerData().job.name == products[i].requiredJob[i2] and not products[i].requiresLicense then
                                                            ShopItems.items[#ShopItems.items+1] = products[i]
                                                        end
                                                    end
                                                end
                                            end
                                            QBCore.Functions.Notify('Poemüüja keeldus relvade näitamisest', 'error')
                                            Wait(500)
                                            QBCore.Functions.Notify('Räägi politseinikuga, et relvaluba saada', 'error')
                                            Wait(1000)
                                        end
                                    else
                                        ShopItems.items = SetupItems(shop)
                                    end
                                    for k, v in pairs(ShopItems.items) do
                                        ShopItems.items[k].slot = k
                                    end
                                    ShopItems.slots = 30
                                    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'Itemshop_'..shop, ShopItems)
                                end)
                            end
                        end
                    end
                end
            end    
        end

        if not InRange then
            Wait(5000)
        end
        Wait(5)
    end
end) ]]

CreateThread(function()
	for store, _ in pairs(Config.Locations) do
		if Config.Locations[store]['showblip'] then
			StoreBlip = AddBlipForCoord(Config.Locations[store]['coords'][1]['x'], Config.Locations[store]['coords'][1]['y'], Config.Locations[store]['coords'][1]['z'])
			SetBlipColour(StoreBlip, 0)
            if Config.Locations[store]['products'] == Config.Products['normal'] then
				SetBlipSprite(StoreBlip, 52)
				SetBlipScale(StoreBlip, 0.6)
			-- elseif Config.Locations[store]['products'] == Config.Products['gearshop'] then
			-- 	SetBlipSprite(StoreBlip, 52)
			-- 	SetBlipScale(StoreBlip, 0.6)
			elseif Config.Locations[store]['products'] == Config.Products['hardware'] then
				SetBlipSprite(StoreBlip, 402)
				SetBlipScale(StoreBlip, 0.8)
			elseif Config.Locations[store]['products'] == Config.Products['weapons'] then
				SetBlipSprite(StoreBlip, 110)
				SetBlipScale(StoreBlip, 0.85)
			elseif Config.Locations[store]['products'] == Config.Products['casino'] then
				SetBlipSprite(StoreBlip, 617)
				SetBlipScale(StoreBlip, 0.70)
            elseif Config.Locations[store]['products'] == Config.Products['alcohol'] then
                SetBlipSprite(StoreBlip, 93)
                SetBlipScale(StoreBlip, 0.70)
            elseif Config.Locations[store]['products'] == Config.Products['pharmacy'] then
                SetBlipSprite(StoreBlip, 153)
                SetBlipScale(StoreBlip, 0.70)
            elseif Config.Locations[store]['products'] == Config.Products['petshop'] then
                SetBlipSprite(StoreBlip, 273)
                SetBlipScale(StoreBlip, 0.70)
            end

            SetBlipDisplay(StoreBlip, 4)
			SetBlipAsShortRange(StoreBlip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(Config.Locations[store]['label'])
			EndTextCommandSetBlipName(StoreBlip)
		end
    end
end)

CreateThread(function()
    local pedModel = `mp_m_shopkeep_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    for k, pos in pairs(Config.Peds) do
        local loc = pos
        local pedHeading = loc.w

        ped = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, pedHeading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

CreateThread(function()
    local pedModel = `s_m_m_gaffer_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    for k, pos in pairs(Config.Hardware) do
        local loc = pos
        local pedHeading = loc.w

        ped = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, pedHeading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

CreateThread(function()
    local pedModel = `s_m_m_migrant_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    for k, pos in pairs(Config.Alko) do
        local loc = pos
        local pedHeading = loc.w

        ped = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, pedHeading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

CreateThread(function()
    local pedModel = `s_m_m_ammucountry`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    for k, pos in pairs(Config.Ammunation) do
        local loc = pos
        local pedHeading = loc.w

        ped = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, pedHeading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

CreateThread(function()
    local pedModel = `s_m_m_doctor_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    for k, pos in pairs(Config.Pharmacy) do
        local loc = pos
        local pedHeading = loc.w

        ped = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, pedHeading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

CreateThread(function()
    local pedModel = `s_m_m_autoshop_02`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    for k, pos in pairs(Config.Parts) do
        local loc = pos
        local pedHeading = loc.w

        ped = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, pedHeading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

CreateThread(function()
    local pedModel = `csb_mp_agent14`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector4(-594.56, 226.09, 74.15, 160.52)

    weapPed = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, loc.w, false, true)
    FreezeEntityPosition(weapPed, true)
    SetEntityInvincible(weapPed, true)
    SetBlockingOfNonTemporaryEvents(weapPed, true)

    exports['qb-target']:AddTargetEntity(weapPed, {
        options = {
            {
                type = 'client',
                event = 'i13-shops:client:openWeapShop',
                label = 'Pood',
                icon = 'fas fa-comment-dollar',
                item = 'coin',
            }
        },
        distance = 1.8,
    })
end)

CreateThread(function()
    local pedModel = `s_f_y_scrubs_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector4(562.27, 2741.57, 42.87, 182.0)

    petPed = CreatePed(5, pedModel, loc.x, loc.y, loc.z - 1, loc.w, false, true)
    FreezeEntityPosition(petPed, true)
    SetEntityInvincible(petPed, true)
    SetBlockingOfNonTemporaryEvents(petPed, true)

    exports['qb-target']:AddTargetEntity(petPed, {
        options = {
            {
                type = 'client',
                event = 'i13-shops:client:openPetShop',
                label = 'Loomapood',
                icon = 'fas fa-comment-dollar',
            }
        },
        distance = 1.8,
    })
end)

CreateThread(function()
    local models = {
        'mp_m_shopkeep_01',
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = 'client',
                event = 'i13-shops:client:OpenShop',
                icon = 'fas fa-comment-dollar',
                label = 'Pood',
            }
        },
        distance = 2.5,
    })
end)

CreateThread(function()
    local models = {
        's_m_m_gaffer_01',
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = 'client',
                event = 'i13-shops:client:OpenHardwareShop',
                icon = 'fas fa-comment-dollar',
                label = 'Tööriistapood',
            }
        },
        distance = 2.5,
    })
end)

CreateThread(function()
    local models = {
        's_m_m_migrant_01',
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = 'client',
                event = 'i13-shops:client:OpenAlkoShop',
                icon = 'fas fa-comment-dollar',
                label = 'Alkopood',
            }
        },
        distance = 2.5,
    })
end)

CreateThread(function()
    local models = {
        's_m_m_ammucountry',
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = 'client',
                event = 'i13-shops:client:OpenAmmunationShop',
                icon = 'fas fa-comment-dollar',
                label = 'Relvapood',
            }
        },
        distance = 2.5,
    })
end)

CreateThread(function()
    local models = {
        's_m_m_doctor_01',
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = 'client',
                event = 'i13-shops:client:OpenPharmacyShop',
                icon = 'fas fa-comment-dollar',
                label = 'Apteek',
            }
        },
        distance = 2.5,
    })
end)

CreateThread(function()
    local models = {
        's_m_m_autoshop_02',
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = 'client',
                event = 'i13-shops:client:OpenPartsShop',
                icon = 'fas fa-comment-dollar',
                label = 'Autoosad',
                job = 'mechanic',
            }
        },
        distance = 2.5,
    })
end)