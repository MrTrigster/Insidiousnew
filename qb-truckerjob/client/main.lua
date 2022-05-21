local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local JobsDone = 0
local LocationsDone = {}
local CurrentLocation = nil
local CurrentBlip = nil
local hasBox = false
local isWorking = false
local currentCount = 0
local CurrentPlate = nil
local selectedVeh = nil
local TruckVehBlip = nil
local ThreadAlreadyRan = false
local jobStarted = false
local jobVeh = nil

-- Functions

local function hasDoneLocation(locationId)
    local retval = false
    if LocationsDone ~= nil and next(LocationsDone) ~= nil then
        for k, v in pairs(LocationsDone) do
            if v == locationId then
                retval = true
            end
        end
    end
    return retval
end

local function getNextClosestLocation()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = 0
    local dist = nil

    for k, _ in pairs(Config.Locations["stores"]) do
        if current ~= 0 then
            if #(pos - vector3(Config.Locations["stores"][k].coords.x, Config.Locations["stores"][k].coords.y, Config.Locations["stores"][k].coords.z)) < dist then
                if not hasDoneLocation(k) then
                    current = k
                    dist = #(pos - vector3(Config.Locations["stores"][k].coords.x, Config.Locations["stores"][k].coords.y, Config.Locations["stores"][k].coords.z))
                end
            end
        else
            if not hasDoneLocation(k) then
                current = k
                dist = #(pos - vector3(Config.Locations["stores"][k].coords.x, Config.Locations["stores"][k].coords.y, Config.Locations["stores"][k].coords.z))
            end
        end
    end

    return current
end

local function getNewLocation()
    local location = getNextClosestLocation()
    if location ~= 0 then
        CurrentLocation = {}
        CurrentLocation.id = location
        CurrentLocation.dropcount = math.random(1, 3)
        CurrentLocation.store = Config.Locations["stores"][location].name
        CurrentLocation.x = Config.Locations["stores"][location].coords.x
        CurrentLocation.y = Config.Locations["stores"][location].coords.y
        CurrentLocation.z = Config.Locations["stores"][location].coords.z

        CurrentBlip = AddBlipForCoord(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)
        SetBlipColour(CurrentBlip, 3)
        SetBlipRoute(CurrentBlip, true)
        SetBlipRouteColour(CurrentBlip, 3)
    else
        QBCore.Functions.Notify("Kõik punktid läbitud, mine tagasi jaama")
        if CurrentBlip ~= nil then
            RemoveBlip(CurrentBlip)
	        ClearAllBlipRoutes()
            CurrentBlip = nil
        end
    end
end

local function isTruckerVehicle(vehicle)
    local retval = false
    for k, v in pairs(Config.Vehicles) do
        if GetEntityModel(vehicle) == GetHashKey(k) then
            retval = true
        end
    end
    return retval
end

local function DrawText3D(x, y, z, text)
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

local function RemoveTruckerBlips()
    if TruckVehBlip ~= nil then
        RemoveBlip(TruckVehBlip)
	ClearAllBlipRoutes()
        TruckVehBlip = nil
    end

    if CurrentBlip ~= nil then
        RemoveBlip(CurrentBlip)
	ClearAllBlipRoutes()
        CurrentBlip = nil
    end
end

-- Events

RegisterNetEvent('i13-trucker:client:SpawnVehicle', function()
    local vehicleInfo = selectedVeh
    local coords = Config.Locations["vehicle"].coords
    local ped = PlayerPedId()
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "PAKK"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = QBCore.Functions.GetPlate(veh)
        jobVeh = veh
        getNewLocation()
    end, coords, true)
    jobStarted = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CurrentLocation = nil
    CurrentBlip = nil
    hasBox = false
    isWorking = false
    JobsDone = 0

    -- RunWorkThread()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    RemoveTruckerBlips()
    CurrentLocation = nil
    CurrentBlip = nil
    hasBox = false
    isWorking = false
    JobsDone = 0
end)

RegisterNetEvent('i13-trucker:client:TakeOutVehicle', function(data)
    if not jobStarted then
        local vehicleInfo = 'speedo'
        TriggerServerEvent('i13-trucker:server:DoBail', true, vehicleInfo)
        selectedVeh = vehicleInfo
    else
        QBCore.Functions.Notify('Sa juba alustasid töötamist', 'error')
    end
end)

RegisterNetEvent('i13-trucker:client:returnVehicle', function()
    if jobStarted then
        if DoesEntityExist(jobVeh) then
            DeleteVehicle(jobVeh)
            jobVeh = nil
            TriggerServerEvent('i13-trucker:server:DoBail', false)
        else
            QBCore.Functions.Notify('Sõiduk on kadunud/katki või sa ei ole seda väljastanud', 'error')
        end
    else
        QBCore.Functions.Notify('Sa ei ole tööd alustanud', 'error')
    end
end)

RegisterNetEvent('i13-trucker:client:getPaid', function()
    if JobsDone > 0 then
        TriggerServerEvent("i13-trucker:server:011011100", JobsDone)
        jobStarted = false
        JobsDone = 0
        if #LocationsDone == #Config.Locations["stores"] then
            LocationsDone = {}
        end
        if CurrentBlip ~= nil then
            RemoveBlip(CurrentBlip)
            ClearAllBlipRoutes()
            CurrentBlip = nil
        end
        if DoesEntityExist(jobVeh) then
            DeleteVehicle(jobVeh)
            jobVeh = nil
            TriggerServerEvent('i13-trucker:server:DoBail', false)
        end
    else
        QBCore.Functions.Notify("Sa ei ole veel tööd teinud", "error")
    end
end)

CreateThread(function()
    local TruckerBlip = AddBlipForCoord(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z)
    SetBlipSprite(TruckerBlip, 479)
    SetBlipDisplay(TruckerBlip, 4)
    SetBlipScale(TruckerBlip, 0.9)
    SetBlipAsShortRange(TruckerBlip, true)
    SetBlipColour(TruckerBlip, 81)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["main"].label)
    EndTextCommandSetBlipName(TruckerBlip)
end)

CreateThread(function()
    local pedModel = `s_m_m_lathandy_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local pos = vector4(153.05, -3213.88, 5.9, 41.79)

    truckerPed = CreatePed(4, pedModel, pos.x, pos.y, pos.z - 1, pos.w, false, true)
    FreezeEntityPosition(truckerPed, true)
    SetEntityInvincible(truckerPed, true)
    SetBlockingOfNonTemporaryEvents(truckerPed, true)
    TaskStartScenarioInPlace(truckerPed, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    exports['qb-target']:AddTargetEntity(truckerPed, {
        options = {
            {
                type = 'client',
                event = 'i13-trucker:client:TakeOutVehicle',
                icon = 'fas fa-sign-in-alt',
                label = 'Alusta Pakivedu',
            },
            {
                type = 'client',
                event = 'i13-trucker:client:returnVehicle',
                icon = 'fas fa-sign-in-alt',
                label = 'Tagasta Sõiduk',
            },
            {
                type = 'client',
                event = 'i13-trucker:client:getPaid',
                icon = 'fas fa-dollar-sign',
                label = 'Võta Palgatšekk',
            },
        },
        distance = 1.5,
    })
end)
CreateThread(function()
    local alreadyInRange = false
    local text = nil

    while true do
        local sleep = 1000
        local inRange = false
        local pos = GetEntityCoords(PlayerPedId())

        if CurrentLocation ~= nil  and currentCount < CurrentLocation.dropcount then
            if #(pos - vector3(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)) < 40.0 and not IsPedInAnyVehicle(PlayerPedId()) then
                sleep = 5
                if not hasBox then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                    if isTruckerVehicle(vehicle) and CurrentPlate == QBCore.Functions.GetPlate(vehicle) then
                        local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                        if #(pos - vector3(trunkpos.x, trunkpos.y, trunkpos.z)) < 1.5 and not isWorking then
                            -- DrawText3D(trunkpos.x, trunkpos.y, trunkpos.z, "~g~E~w~ - Võta Kaup")
                            inRange = true
                            text = '[E] - Võta Kaup'
                            if IsControlJustReleased(0, 38) then
                                isWorking = true
                                QBCore.Functions.Progressbar("work_carrybox", "Võtab kaubaga kasti...", 2000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "anim@gangops@facility@servers@",
                                    anim = "hotwire",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    isWorking = false
                                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                    TriggerEvent('animations:client:EmoteCommandStart', {"box"})
                                    hasBox = true
                                end, function() -- Cancel
                                    isWorking = false
                                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                    QBCore.Functions.Notify("Canceled", "error")
                                end)
                            end
                        end
                    end
                elseif hasBox then
                    if #(pos - vector3(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)) < 1.5 and not isWorking then
                        -- DrawText3D(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z, "~g~E~w~ - Toimeta Kohale")
                        inRange = true
                        text = '[E] - Toimeta Kohale'
                        if IsControlJustReleased(0, 38) then
                            isWorking = true
                            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                            Wait(500)
                            TriggerEvent('animations:client:EmoteCommandStart', {"bumbin"})
                            QBCore.Functions.Progressbar("work_dropbox", "Toimetab kaupa kohale...", 2000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                isWorking = false
                                ClearPedTasks(PlayerPedId())
                                hasBox = false
                                currentCount = currentCount + 1
                                if currentCount == CurrentLocation.dropcount then
                                    LocationsDone[#LocationsDone+1] = CurrentLocation.id
                                    TriggerServerEvent("i13-shops:server:RestockShopItems", CurrentLocation.store)
                                    QBCore.Functions.Notify("Kõik kohale toimetatud, mine järgmisse punkti")
                                    if CurrentBlip ~= nil then
                                        RemoveBlip(CurrentBlip)
                                        ClearAllBlipRoutes()
                                        CurrentBlip = nil
                                    end
                                    CurrentLocation = nil
                                    currentCount = 0
                                    JobsDone = JobsDone + 1
                                    getNewLocation()
                                end
                            end, function() -- Cancel
                                isWorking = false
                                ClearPedTasks(PlayerPedId())
                                QBCore.Functions.Notify("Katkestatud", "error")
                            end)
                        end
                    end
                end

                if inRange and not alreadyInRange then
                    alreadyInRange = true
                    exports['qb-drawtext']:DrawText(text, 'left')
                end

                if not inRange and alreadyInRange then
                    alreadyInRange = false
                    exports['qb-drawtext']:HideText()
                end

            end
        end
        Wait(sleep)
    end
end)