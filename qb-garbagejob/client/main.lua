local QBCore = exports['qb-core']:GetCoreObject()
local playerJob = nil
local garbageVehicle = nil
local hasBag = false
local currentStop = 0
local deliveryBlip = nil
local isWorking = false
local amountOfBags = 0
local garbageObject = nil
local endBlip = nil
local garbageBlip = nil
local canTakeBag = true
local currentStopNum = 0
local payCoords = vector3(Config.Locations["paycheck"].coords.x, Config.Locations["paycheck"].coords.y, Config.Locations["paycheck"].coords.z)
local vehCoords = vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)

-- Handlers

local function setupClient()
    garbageVehicle = nil
    hasBag = false
    currentStop = 0
    deliveryBlip = nil
    isWorking = false
    amountOfBags = 0
    garbageObject = nil
    endBlip = nil
    currentStopNum = 0
    garbageBlip = AddBlipForCoord(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z)
    SetBlipSprite(garbageBlip, 318)
    SetBlipDisplay(garbageBlip, 4)
    SetBlipScale(garbageBlip, 0.9)
    SetBlipAsShortRange(garbageBlip, true)
    SetBlipColour(garbageBlip, 81)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["main"].label)
    EndTextCommandSetBlipName(garbageBlip)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    setupClient()
end)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        if garbageObject ~= nil then
            DeleteEntity(garbageObject)
            garbageObject = nil
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        setupClient()
    end
end)

-- Functions

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

local function DrawText3D2(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x,coords.y,coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function LoadAnimation(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Wait(10) end
end

local function BringBackCar()
    DeleteVehicle(garbageVehicle)
    if endBlip ~= nil then
        RemoveBlip(endBlip)
    end
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
    garbageVehicle = nil
    hasBag = false
    currentStop = 0
    deliveryBlip = nil
    isWorking = false
    amountOfBags = 0
    garbageObject = nil
    endBlip = nil
    currentStopNum = 0
end

local function SetRouteBack()
    local inleverpunt = Config.Locations["vehicle"]
    endBlip = AddBlipForCoord(inleverpunt.coords.x, inleverpunt.coords.y, inleverpunt.coords.z)
    exports['qb-target']:RemoveZone('trashcans')
    SetBlipSprite(endBlip, 1)
    SetBlipDisplay(endBlip, 2)
    SetBlipScale(endBlip, 1.0)
    SetBlipAsShortRange(endBlip, false)
    SetBlipColour(endBlip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].name)
    EndTextCommandSetBlipName(endBlip)
    SetBlipRoute(endBlip, true)
end

local function AnimCheck()
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            if hasBag then
                if not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 3) then
                    ClearPedTasksImmediately(ped)
                    LoadAnimation('missfbi4prepp1')
                    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                end
            else
                break
            end
            Wait(200)
        end
    end)
end

local function TakeAnim()
    local ped = PlayerPedId()
    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    garbageObject = CreateObject(`prop_cs_rub_binbag_01`, 0, 0, 0, true, true, true)
    AttachEntityToEntity(garbageObject, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)
    AnimCheck()
end

local function DeliverAnim()
    local ped = PlayerPedId()
    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_throw_garbage_man', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, GetEntityHeading(garbageVehicle))
    canTakeBag = false
    SetTimeout(1250, function()
        DetachEntity(garbageObject, 1, false)
        DeleteObject(garbageObject)
        TaskPlayAnim(ped, 'missfbi4prepp1', 'exit', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
        FreezeEntityPosition(ped, false)
        garbageObject = nil
        canTakeBag = true
    end)
end

local function SetGarbageRoute()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local CurrentLocation = Config.Locations["trashcan"][currentStop]
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
    exports['qb-target']:AddBoxZone("trashcans", vector3(CurrentLocation.pz), CurrentLocation.length, CurrentLocation.width, {
        name = "trashcans",
        heading = CurrentLocation.heading,
        debugPoly = false,
        minZ = CurrentLocation.minZ,
        maxZ = CurrentLocation.maxZ,
        }, {
            options = {
                {
                    type = "client",
                    event = "garbage:takeBag",
                    icon = "fas fa-sign-in-alt",
                    label = "Haara Prügikott",
                },
            },
            distance = 2.5
    })
    deliveryBlip = AddBlipForCoord(CurrentLocation.coords.x, CurrentLocation.coords.y, CurrentLocation.coords.z)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["trashcan"][currentStop].name)
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)
end

local function IsWearingVest()
    local vest = GetPedDrawableVariation(PlayerPedId(), 8)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if vest ~= nil and vest == 59 then
            retval = false
        end
    else
        if vest ~= nil and vest == 36 then
            retval = false
        end
    end
    return retval
end

RegisterNetEvent('garbage:takeBag')
AddEventHandler('garbage:takeBag', function()
    if currentStop ~= 0 and deliveryBlip ~= nil then
        if not hasBag and canTakeBag then
            hasBag = true
            TakeAnim()
        end
    else
        QBCore.Functions.Notify("Go clock in to collect trash.", 'error')
    end
end)

RegisterNetEvent('garbage:putTrashTruck')
AddEventHandler('garbage:putTrashTruck', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if not IsWearingVest() then
        if hasBag then
            LoadAnimation('missfbi4prepp1')
            if DoesEntityExist(garbageVehicle) then
                QBCore.Functions.Progressbar("deliverbag", "Viskab kotti prügiautosse..", 2000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    hasBag = false
                    -- Looks if you have delivered all bags
                    if (amountOfBags - 1) == 0 then
                        QBCore.Functions.TriggerCallback('garbagejob:server:NextStop', function(hasMoreStops, nextStop, newBagAmount)
                            if hasMoreStops and nextStop ~= 0 then
                                -- Here he puts your next location and you are not finished working yet.
                                currentStop = nextStop
                                currentStopNum = currentStopNum + 1
                                amountOfBags = newBagAmount
                                SetGarbageRoute()
                                QBCore.Functions.Notify("Kõik kotid on siit korjatud, mine järgmisse punkti")
                            else
                                if hasMoreStops and nextStop == currentStop then
                                    QBCore.Functions.Notify("Depoos tekkis viga, mine tagasi depoosse!", 'error')
                                    amountOfBags = 0
                                else
                                    -- You are done with work here.
                                    QBCore.Functions.Notify("Kõik punktid tehtud, mine tagasi depoosse", 'success')
                                    isWorking = false
                                    RemoveBlip(deliveryBlip)
                                    SetRouteBack()
                                    amountOfBags = 0
                                end
                            end
                        end, currentStop, currentStopNum, pos)
                        hasBag = false
                    else
                        -- You haven't delivered all bags here
                        amountOfBags = amountOfBags - 1
                        if amountOfBags > 1 then
                            QBCore.Functions.Notify(""..amountOfBags.." kotti jäänud")
                        else
                            QBCore.Functions.Notify(""..amountOfBags.." kott jäänud")
                        end
                        hasBag = false
                    end

                    DeliverAnim()
                end, function() -- Cancel
                    QBCore.Functions.Notify("Katkestatud", "error")
                end)
            else
                QBCore.Functions.Notify("Sul ei ole prügiautot", "error")
                print("Sul ei ole enam prügiautot, teata adminile!")
                DeliverAnim()
                hasBag = false
            end
        else
            QBCore.Functions.Notify("Sul ei ole prügikotti", "error")
        end
    else
        QBCore.Functions.Notify('Sul ei ole õiget vesti seljas (särk 59 / naistel 36)', 'error')
    end
end)

-- Events

RegisterNetEvent('garbagejob:client:SetWaypointHome', function()
    SetNewWaypoint(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y)
end)

RegisterNetEvent('garbage:paySlip', function()
    TriggerServerEvent('garbagejob:server:PayShift')
end)

RegisterNetEvent('garbage:getTruck')
AddEventHandler('garbage:getTruck', function()
    local ped = PlayerPedId()
    if not IsWearingVest() then
        QBCore.Functions.TriggerCallback('garbagejob:server:NewShift', function(shouldContinue, firstStop, totalBags)
            if shouldContinue then

                local coords = Config.Locations["vehicle"].coords
                QBCore.Functions.SpawnVehicle("trash2", function(veh)
                    TaskWarpPedIntoVehicle(ped, veh, -1) -- hopefully this fixes an issue if something is delayed they'll get crushed
                    SetVehicleEngineOn(veh, true, true)
                    garbageVehicle = veh
                    NetworkRegisterEntityAsNetworked(garbageVehicle)
                    SetVehicleNumberPlateText(veh, "GARB"..tostring(math.random(1000, 9999)))
                    SetEntityHeading(veh, coords.w)
                    exports['LegacyFuel']:SetFuel(veh, 100.0)
                    SetEntityAsMissionEntity(veh, true, true)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                    exports['qb-target']:AddTargetEntity(garbageVehicle, {
                        options = {
                            {
                                type = "client",
                                event = "garbage:putTrashTruck",
                                icon = "fas fa-sign-in-alt",
                                label = "Viska prügikott masinasse",
                            },
                        },
                        distance = 3.0
                    })
                    currentStop = firstStop
                    currentStopNum = 1
                    amountOfBags = totalBags
                    isWorking = true
                    exports['qb-target']:RemoveZone('trashcans')
                    SetGarbageRoute()
                    QBCore.Functions.Notify("Sa maksid $"..Config.TruckPrice.." ettemaksu")
                    QBCore.Functions.Notify("Sa alustasid töötamist asukoht märgitud gps'il")
                    Wait(10)
                end, coords, true)
            else
                QBCore.Functions.Notify("Sul ei ole ettemaksuks piisavalt raha (Vaja $"..Config.TruckPrice..')', 'error')
            end
        end)
    else
        QBCore.Functions.Notify('Sul ei ole õiget varustust', 'error')
    end
end)

RegisterNetEvent('garbage:returnTruck')
AddEventHandler('garbage:returnTruck', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if DoesEntityExist(garbageVehicle) then
        QBCore.Functions.TriggerCallback('garbagejob:server:EndShift', function(endShift)
            if endShift then
                BringBackCar()
                QBCore.Functions.Notify("Prügiauto tagastatud, võta palgatšekk, et saada palk kätte ja ettemaks tagasi")
            else
                QBCore.Functions.Notify("Sa ei ole ettemaksu maksnud sellele")
                currentStopNum = 0
                currentStop = 0
            end
        end, pos)
    else
        QBCore.Functions.Notify("Prügiauto on kadunud/katki või sa ei ole seda väljastanud", "error")
    end
end)

RegisterNetEvent('garbage:finishJob', function()
    if not DoesEntityExist(garbageVehicle) then
        TriggerServerEvent('garbagejob:server:PayShift')
    else
        QBCore.Functions.Notify('Sul on prügiauto tagastamata', 'error')
    end
end)

CreateThread(function()
    local pedModel = `s_m_y_garbage`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local pos = vector4(-349.96, -1569.92, 25.22, 296.46)

    ped = CreatePed(4, pedModel, pos.x, pos.y, pos.z - 1, pos.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
end)

CreateThread(function()
    local models = {
        `s_m_y_garbage`
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                num = 1,
                type = 'client',
                event = 'garbage:getTruck',
                icon = 'fas fa-sign-in-alt',
                label = 'Alusta Prügivedamist',
            },
            {
                num = 2,
                type = 'client',
                event = 'garbage:returnTruck',
                icon = 'fas fa-sign-in-alt',
                label = 'Tagasta Prügiauto',
            },
            {
                num = 3,
                type = 'client',
                event = 'garbage:finishJob',
                icon = 'fas fa-dollar-sign',
                label = 'Võta Palgatšekk',
            },
        },
        distance = 1.5,
    })
end)