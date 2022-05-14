local QBCore = exports['qb-core']:GetCoreObject()

isLoggedIn = false
PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

local SpawnedPlants = {}
local InteractedPlant = nil
local HarvestedPlants = {}
local canHarvest = true
local closestPlant = nil
local isDoingAction = false
local IsSearching = false

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function CanPlantSeedHere(pos)
    local canPlant = true

    for i = 1, #Config.Plants do
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true) < 1.3 then
            canPlant = false
        end
    end

    return canPlant
end

function GetPlantZ(stage)
    if stage == 1 then
        return 1.0
    else
        return 3.5
    end
end

function DestroyPlant()
    local plant = GetClosestPlant()
    local hasDone = false

    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end

    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local ped = GetPlayerPed(-1)
        isDoingAction = true
        TriggerServerEvent('i13-weed:plantHasBeenHarvested', plant.id)

        RequestAnimDict('amb@prop_human_bum_bin@base')
        while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
            Wait(0)
        end

        TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
        FreezeEntityPosition(ped, true)
        QBCore.Functions.Progressbar("destroying_weed", "Hävitab...", 5000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('i13-weed:destroyPlant', plant.id)
            isDoingAction = false
            canHarvest = true
            FreezeEntityPosition(ped, false)
            ClearPedTasksImmediately(ped)
        end)
    else
        QBCore.Functions.Notify("Error", "error")
    end
end

function HarvestWeedPlant()
    local plant = GetClosestPlant()
    local hasDone = false

    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end

    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local ped = GetPlayerPed(-1)
        isDoingAction = true
        TriggerServerEvent('i13-weed:plantHasBeenHarvested', plant.id)

        RequestAnimDict('amb@prop_human_bum_bin@base')
        while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
            Wait(0)
        end

        TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
        FreezeEntityPosition(ped, true)
        QBCore.Functions.Progressbar("harvesting_weed", "Korjab...", 5000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('i13-weed:harvestWeed', plant.id)
            isDoingAction = false
            canHarvest = true
            FreezeEntityPosition(ped, false)
            ClearPedTasksImmediately(ped)
        end)
    else
        QBCore.Functions.Notify("Error", "error")
    end
end

function RemovePlantFromTable(plantId)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            table.remove(Config.Plants, k)
        end
    end
end

function GetClosestPlant()
    local dist = 1000
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local plant = {}

    for i = 1, #Config.Plants do
        local xd = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)
        if xd < dist then
            dist = xd
            plant = Config.Plants[i]
        end
    end

    return plant
end

local function waterWeedPlant()
    local entity = nil
    local plant = GetClosestPlant()
    local ped = GetPlayerPed(-1)
    isDoingAction = true

    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end

    TaskTurnPedToFaceEntity(GetPlayerPed(-1), entity, -1)

    RequestAnimDict('amb@prop_human_bum_bin@base')
    while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
        Wait(0)
    end

    TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    QBCore.Functions.Progressbar("watering_weed", "Kallab vett...", 2000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        FreezeEntityPosition(ped, false)
        TriggerServerEvent('i13-weed:server:waterPlant', plant.id)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        isDoingAction = false
    end)
end

local function fertilizerWeedPlant()
    local entity = nil
    local plant = GetClosestPlant()
    local ped = GetPlayerPed(-1)
    isDoingAction = true

    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end

    TaskTurnPedToFaceEntity(GetPlayerPed(-1), entity, -1)

    RequestAnimDict('amb@prop_human_bum_bin@base')
    while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
        Wait(0)
    end

    TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
    FreezeEntityPosition(ped, false)
    QBCore.Functions.Progressbar("fertilizing_weed", "Väetab...", 2000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        FreezeEntityPosition(ped, false)
        TriggerServerEvent('i13-weed:server:feedPlant', plant.id)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        isDoingAction = false
    end)
end

RegisterNetEvent('i13-weed:weedActions', function()
    for k,v in pairs(Config.Plants) do
        if not isDoingAction and not v.beingHarvested and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            if PlayerJob.name == 'police' then
                local plant = GetClosestPlant()
                if v.id == plant.id then
                    exports['qb-menu']:openMenu({
                        {
                            header = ''..v.type..' | Kasv: '..v.growth..'% | Kvaliteet: '..v.quality..'',
                            isMenuHeader = true,
                        },
                        {
                            header = 'Hävita',
                            txt = 'Hävita taim',
                            params = {
                                event = 'i13-weed:client:destroyWeed',
                            }
                        },
                    })
                end
            else
                if v.growth < 100 then
                    local plant = GetClosestPlant()
                    if v.id == plant.id then
                        exports['qb-menu']:openMenu({
                            {
                                header = ''..v.type..' | Kasv: '..v.growth..'% | Kvaliteet: '..v.quality..'',
                                isMenuHeader = true,
                            },
                            {
                                header = 'Vesi: '..v.thirst..'%',
                                txt = 'Anna taimele vett',
                                params = {
                                    event = 'i13-weed:client:giveWaterWeed',
                                }
                            },
                            {
                                header = 'Väetis: '..v.hunger..'%',
                                txt = 'Anna taimele väetist',
                                params = {
                                    event = 'i13-weed:client:giveFertilizerWeed',
                                }
                            },
                        })
                    end
                else
                    local plant = GetClosestPlant()
                    if v.id == plant.id then
                        exports['qb-menu']:openMenu({
                            {
                                header = ''..v.type..' | Kasv: '..v.growth..'% | Kvaliteet: '..v.quality..'',
                                isMenuHeader = true,
                            },
                            {
                                header = 'Korja',
                                txt = 'Korja valminud saak',
                                params = {
                                    event = 'i13-weed:client:harvestReadyWeed',
                                }
                            },
                        })
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('i13-weed:client:destroyWeed', function()
    DestroyPlant()
end)

RegisterNetEvent('i13-weed:client:giveWaterWeed', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
            waterWeedPlant()
        else
            QBCore.Functions.Notify('Sul ei ole veepudelit', 'error')
        end
    end, 'water_bottle')
end)

RegisterNetEvent('i13-weed:client:giveFertilizerWeed', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
            fertilizerWeedPlant()
        else
            QBCore.Functions.Notify('Sul ei ole väetist', 'error')
        end
    end, 'fertilizer')
end)

RegisterNetEvent('i13-weed:client:harvestReadyWeed', function()
    if canHarvest then
        HarvestWeedPlant()
    end
end)

RegisterNetEvent('i13-weed:client:removeWeedObject', function(plant)
    for i = 1, #SpawnedPlants do
        local o = SpawnedPlants[i]
        if o.id == plant then
            SetEntityAsMissionEntity(o.obj, false)
            FreezeEntityPosition(o.obj, false)
            DeleteObject(o.obj)
        end
    end
end)

RegisterNetEvent('i13-weed:client:updateWeedData', function(data)
    Config.Plants = data
end)

RegisterNetEvent('i13-weed:client:plantNewSeed', function(type, itemname)
    local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, -0.35)

    if CanPlantSeedHere(pos) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        QBCore.Functions.Progressbar("planting_weed", "Istutab...", math.random(1000, 2000), false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('i13-weed:server:plantNewSeed', type, pos, itemname)
        end)
    else
        QBCore.Functions.Notify("Liiga lähedal teisele taimele", "error")
    end
end)

RegisterNetEvent('i13-weed:client:plantSeedConfirm', function()
    RequestAnimDict("pickup_object")
    while not HasAnimDictLoaded("pickup_object") do
        Wait(7)
    end
    TaskPlayAnim(GetPlayerPed(-1), "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false)
    Wait(1800)
    ClearPedTasks(GetPlayerPed(-1))
end)

CreateThread(function()
    while true do
    Wait(150)

    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local inRange = false

    for i = 1, #Config.Plants do
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)

        -- if Config.Plants[i].growth < 100 then
            if dist < 50.0 then
                inRange = true
                local hasSpawned = false
                local needsUpgrade = false
                local upgradeId = nil
                local tableRemove = nil
    
                for z = 1, #SpawnedPlants do
                    local p = SpawnedPlants[z]
    
                    if p.id == Config.Plants[i].id then
                        hasSpawned = true
                        if p.stage ~= Config.Plants[i].stage then
                            needsUpgrade = true
                            upgradeId = p.id
                            tableRemove = z
                        end
                    end
                end
    
                if not hasSpawned then
                    local hash = GetHashKey(Config.WeedStages[Config.Plants[i].stage])
                    RequestModel(hash)
                    local data = {}
                    data.id = Config.Plants[i].id
                    data.stage = Config.Plants[i].stage
    
                    while not HasModelLoaded(hash) do
                        Wait(10)
                        RequestModel(hash)
                    end
    
                    data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z - GetPlantZ(Config.Plants[i].stage), false, false, false)
                    SetEntityAsMissionEntity(data.obj, true)
                    FreezeEntityPosition(data.obj, true)
                    table.insert(SpawnedPlants, data)
                    hasSpawned = false
                end
    
                if needsUpgrade then
                    for o = 1, #SpawnedPlants do
                        local u = SpawnedPlants[o]
    
                        if u.id == upgradeId then
                            SetEntityAsMissionEntity(u.obj, false)
                            FreezeEntityPosition(u.obj, false)
                            DeleteObject(u.obj)
    
                            local hash = GetHashKey(Config.WeedStages[Config.Plants[i].stage])
                            RequestModel(hash)
                            local data = {}
                            data.id = Config.Plants[i].id
                            data.stage = Config.Plants[i].stage
    
                            while not HasModelLoaded(hash) do
                                Wait(10)
                                RequestModel(hash)
                            end
    
                            data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z - GetPlantZ(Config.Plants[i].stage), false, false, false) 
                            SetEntityAsMissionEntity(data.obj, true)
                            FreezeEntityPosition(data.obj, true)
                            table.remove(SpawnedPlants, o)
                            table.insert(SpawnedPlants, data)
                            needsUpgrade = false
                        end
                    end
                end
            end
        -- end
    end
    if not InRange then
        Wait(5000)
    end
    end

end)

--[[CreateThread(function()
    while true do
        Wait(0)
            local InRange = false
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)

            for k, v in pairs(Config.Plants) do
                if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 1.3 and not isDoingAction and not v.beingHarvested and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                    if PlayerJob.name == 'police' then
                        local plant = GetClosestPlant()
                        DrawText3D(v.x, v.y, v.z, 'Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '% - Growth: ' ..  v.growth .. '% -  Quality: ' .. v.quality)
                        DrawText3D(v.x, v.y, v.z - 0.18, '~b~G~w~ - Destroy Plant')
                        if IsControlJustReleased(0, Keys["G"]) then
                            if v.id == plant.id then
                                DestroyPlant()
                            end
                        end
                    else
                        if v.growth < 100 then
                            local plant = GetClosestPlant()
                            DrawText3D(v.x, v.y, v.z, 'Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '% - Growth: ' ..  v.growth .. '% -  Quality: ' .. v.quality)
                            DrawText3D(v.x, v.y, v.z - 0.18, '~b~G~w~ - Water      ~y~H~w~ - Feed')
                            if IsControlJustReleased(0, Keys["G"]) then
                                if v.id == plant.id then
                                    TriggerServerEvent('orp:server:checkPlayerHasThisItem', 'water_bottle', 'i13-weed:client:waterPlant', true)
                                end
                            elseif IsControlJustReleased(0, Keys["H"]) then
                                if v.id == plant.id then
                                    TriggerServerEvent('orp:server:checkPlayerHasThisItem', 'fertilizer', 'i13-weed:client:feedPlant', true)
                                end
                            end
                        else
                            DrawText3D(v.x, v.y, v.z, '[Quality: ' .. v.quality .. ']')
                            DrawText3D(v.x, v.y, v.z - 0.18, '~g~E~w~ - Harvest')
                            if IsControlJustReleased(0, Keys["E"]) and canHarvest then
                                local plant = GetClosestPlant()
                                if v.id == plant.id then
                                    HarvestWeedPlant()
                                end
                            end
                        end
                    end
                end
            end
    end
end) ]]

--[[CreateThread(function()
    while true do
        Wait(0)
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local InRange = false

            for k, v in pairs(Config.SeedLocations) do
                if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.5 then
                    InRange = true
                end
            end

            if InRange and not IsSearching and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                DrawText3D(pos.x, pos.y, pos.z, '~y~G~w~ - Search')
                if IsControlJustReleased(0, Keys["G"]) then
                    IsSearching = true
                    RequestAnimDict('amb@prop_human_bum_bin@base')
                    while not HasAnimDictLoaded('amb@prop_human_bum_bin@base') do
                        Wait(0)
                    end

                    TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                    FreezeEntityPosition(ped, true)
                    QBCore.Functions.Progressbar("searching_seed", "Searching...", 10000, false, false, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function() -- Done
                        FreezeEntityPosition(ped, false)
                        IsSearching = false
                        ClearPedTasksImmediately(ped)
                    end)

                    if math.random(1, 10) == 7 then
                        TriggerServerEvent('i13-weed:server:giveShittySeed')
                    end
                end
            else
                Wait(3000)
            end
    end
end) ]]

CreateThread(function()
    local models = {
        'bkr_prop_weed_01_small_01c',
        'bkr_prop_weed_med_01a',
        'bkr_prop_weed_lrg_01a',
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = 'client',
                event = 'i13-weed:weedActions',
                icon = 'fas fa-cannabis',
                label = 'Kanepitaime Tegevused',
            }
        },
        distance = 1.5
    })
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('weedShop', vector3(-1169.52, -1572.11, 4.66), 0.8, 1.0, {
        name = 'weedShop',
        heading = 35,
        debugPoly = false,
        minZ = 4.41,
        maxZ = 4.96
    }, {
        options = {
            {
                type = 'client',
                event = 'i13-shops:client:OpenWeedShop',
                label = 'Osta Seemneid',
                icon = 'fas fa-cannabis',
            }
        },
        distance = 1.5,
    })
end)