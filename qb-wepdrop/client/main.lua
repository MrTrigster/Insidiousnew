local QBCore = exports['qb-core']:GetCoreObject()
local pilot, aircraft, parachute, crate, pickup, blip, soundID
local requiredModels = {"p_cargo_chute_s", "ex_prop_adv_case_sm", "cuban800", "s_m_m_pilot_02", "h4_prop_h4_box_ammo_02a"}
local RequiredCops = 2
local canDrop = true

-- Crate Drop function
function CrateDrop(planeSpawnDistance, dropCoords)
    CreateThread(function()
        -- SetTimeout(1 * 60 * 1000, function()            
	        QBCore.Functions.Notify("Piloot jõuab umbes 5 minuti pärast", "success")					                      
            SetTimeout(5 * 60 * 1000, function()
                for i = 1, #requiredModels do
                    RequestModel(GetHashKey(requiredModels[i]))
                    while not HasModelLoaded(GetHashKey(requiredModels[i])) do
                        Wait(0)
                    end
                end
                RequestAnimDict("p_cargo_chute_s")
                while not HasAnimDictLoaded("p_cargo_chute_s") do
                    Wait(0)
                end                         
                local rHeading = math.random(0, 360) + 0.0
                local planeSpawnDistance = (planeSpawnDistance and tonumber(planeSpawnDistance) + 0.0) or 400.0
                local theta = (rHeading / 180.0) * 3.14
                local rPlaneSpawn = vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(math.cos(theta) * planeSpawnDistance, math.sin(theta) * planeSpawnDistance, -500.0)
                local dx = dropCoords.x - rPlaneSpawn.x
                local dy = dropCoords.y - rPlaneSpawn.y
                local heading = GetHeadingFromVector_2d(dx, dy)
                aircraft = CreateVehicle(GetHashKey("cuban800"), rPlaneSpawn, heading, true, true)
                SetEntityHeading(aircraft, heading)
                SetVehicleDoorsLocked(aircraft, 2)
                SetEntityDynamic(aircraft, true)
                ActivatePhysics(aircraft)
                SetVehicleForwardSpeed(aircraft, 30.0)
                SetHeliBladesFullSpeed(aircraft)
                SetVehicleEngineOn(aircraft, true, true, false)
                ControlLandingGear(aircraft, 3)
                OpenBombBayDoors(aircraft)
                SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)
                pilot = CreatePedInsideVehicle(aircraft, 1, GetHashKey("s_m_m_pilot_02"), -1, true, true)
                SetBlockingOfNonTemporaryEvents(pilot, true)
                SetPedRandomComponentVariation(pilot, false)
                SetPedKeepTask(pilot, true)
                SetPlaneMinHeightAboveTerrain(aircraft, 50)
                TaskVehicleDriveToCoord(pilot, aircraft, vector3(dropCoords.x, dropCoords.y, dropCoords.z) + vector3(0.0, 0.0, 500.0), 60.0, 0, GetHashKey("cuban800"), 262144, 15.0, -1.0) -- to the dropsite, could be replaced with a task sequence
                local droparea = vector2(dropCoords.x, dropCoords.y)
                local planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
                while not IsEntityDead(pilot) and #(planeLocation - droparea) > 5.0 do
                    Wait(100)
                    planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
                end
                if IsEntityDead(pilot) then 
                    QBCore.Functions.Notify("Lennuk hävines, vedu ebaõnnestus", "error")
                    return
                end
                TaskVehicleDriveToCoord(pilot, aircraft, 0.0, 0.0, 500.0, 60.0, 0, GetHashKey("cuban800"), 262144, -1.0, -1.0)
                SetEntityAsNoLongerNeeded(pilot) 
                SetEntityAsNoLongerNeeded(aircraft)      
                local crateSpawn = vector3(dropCoords.x, dropCoords.y, GetEntityCoords(aircraft).z - 5.0)

                QBCore.Functions.Notify("Drop off tehtud, hoia silmad taeva poole")   

                crate = CreateObject(GetHashKey("h4_prop_h4_box_ammo_02a"), crateSpawn, true, true, true)
                SetEntityLodDist(crate, 1000)
                SetEntityInvincible(crate, true)
                SetDamping(crate, 2, 0.1)
                SetEntityVelocity(crate, 0.0, 0.0, -0.1)
                parachute = CreateObject(GetHashKey("p_cargo_chute_s"), crateSpawn, true, true, true)
                SetEntityLodDist(parachute, 1000)
                SetEntityVelocity(parachute, 0.0, 0.0, -0.1)
                AttachEntityToEntity(parachute, crate, 0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                local playerPos = GetEntityCoords(PlayerPedId())
                local crateCoords = GetEntityCoords(crate)

                -- DetachEntity(parachute, true, true)
                -- DeleteEntity(parachute)

                for i = 1, #requiredModels do
                    Wait(0)
                    SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
                end
                exports['qb-target']:AddTargetModel(`h4_prop_h4_box_ammo_02a`, {
                    options = {
                        {
                            type = 'client',
                            event = 'i13-wepdrop:client:getItems',
                            label = 'Võta Asjad',
                            icon = 'fas fa-hand',
                        }
                    },
                    distance = 2.0,
                })
                -- TriggerServerEvent("i13-wepdrop:server:recieveItems")            
            end)
        -- end)  
    end)
end

RegisterNetEvent('drop:client:dropFalse', function()
    canDrop = false
end)

RegisterNetEvent('drop:client:dropTrue', function()
    canDrop = true
end)

-- Create the AirDrop
RegisterNetEvent("i13-wepdrop:client:CreateDrop", function(roofCheck, planeSpawnDistance)
    if canDrop then
        local playerCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, 0.0)
        local chance = math.random(1, 100)
        QBCore.Functions.Progressbar('call_wepdrop', 'Teeb kõne...', 8000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'cellphone@',
            anim = 'cellphone_call_listen_base',
            flags = 50,
        }, {}, {}, function()
            QBCore.Functions.TriggerCallback("i13-wepdrop:server:getCops", function(CurrentCops)
                if CurrentCops >= RequiredCops then
                    TriggerEvent("i13-wepdrop:client:StartDrop", roofCheck or false, planeSpawnDistance or 400.0, {["x"] = playerCoords.x, ["y"] = playerCoords.y, ["z"] = playerCoords.z})
                    -- if chance >= 70 then
                    --     local data = {displayCode = '???', description = 'Tundmatu Õhusõiduk', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'M'}
                    --     local dispatchData = {dispatchData = data, caller = 'Pangaalarm', coords = vector3(261.95, 223.11, 106.28)}
                    --     TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                    -- end
                    TriggerServerEvent('QBCore:Server:RemoveItem', 'dropphone', 1)
                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['dropphone'], 'remove')
                    TriggerServerEvent('drop:server:startCooldown')
                else
                    QBCore.Functions.Notify("Linnas ei ole piisavalt politseinikke ("..CurrentCops.."/"..RequiredCops..")", "error")
                end    
            end)
        end, function()
            QBCore.Functions.Notify('Katkestatud', 'error')
        end)
    else
        QBCore.Functions.Notify('Tellimust ei saa hetkel täita', 'error')
    end
end)

-- Start the AirDrop
RegisterNetEvent("i13-wepdrop:client:StartDrop", function(roofCheck, planeSpawnDistance, dropCoords)
    CreateThread(function()          
        if dropCoords.x and dropCoords.y and dropCoords.z and tonumber(dropCoords.x) and tonumber(dropCoords.y) and tonumber(dropCoords.z) then            
        else
            dropCoords = {0.0, 0.0, 72.0}            
        end
        RequestWeaponAsset(GetHashKey("weapon_flare"))
        while not HasWeaponAssetLoaded(GetHashKey("weapon_flare")) do
            Wait(0)
        end
        ShootSingleBulletBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(PlayerPedId()) - vector3(0.0001, 0.0001, 0.0001), 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0)

        if roofCheck and roofCheck ~= "false" then
            local ray = StartShapeTestRay(vector3(dropCoords.x, dropCoords.y, dropCoords.z) + vector3(0.0, 0.0, 500.0), vector3(dropCoords.x, dropCoords.y, dropCoords.z), -1, -1, 0)
            local _, hit, impactCoords = GetShapeTestResult(ray)
            if hit == 0 or (hit == 1 and #(vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(impactCoords)) < 10.0) then             
                CrateDrop(planeSpawnDistance, dropCoords)
            else            
                return
            end
        else            
            CrateDrop(planeSpawnDistance, dropCoords)
        end
    end)
end)

RegisterNetEvent('i13-wepdrop:client:getItems', function()
    TriggerServerEvent('i13-wepdrop:server:recieveItems')
    DeleteEntity(crate)
    DeleteEntity(parachute)
    exports['qb-target']:RemoveTargetModel('h4_prop_h4_box_ammo_02a', 'test')
end)

-- On resource stop do things
AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        SetEntityAsMissionEntity(pilot, false, true)
        DeleteEntity(pilot)
        SetEntityAsMissionEntity(aircraft, false, true)
        DeleteEntity(aircraft)
        DeleteEntity(parachute)
        DeleteEntity(crate)
        RemoveBlip(blip)
        StopSound(soundID)
        ReleaseSoundId(soundID)
        for i = 1, #requiredModels do
            Wait(0)
            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
        end
    end
end)

CreateThread(function()
    local pedModel = `g_m_y_mexgang_01`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local pos = vector4(-114.04, 6369.91, 31.52, 222.07)

    ped = CreatePed(4, pedModel, pos.x, pos.y, pos.z - 1, pos.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_LEANING', 0, true)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('dropphoneman', vector3(-114.04, 6369.91, 31.52), 0.7, 0.7, {
        name = 'dropphoneman',
        heading = 45,
        debugPoly = false,
        minZ = 30.52,
        maxZ = 32.32
    }, {
        options = {
            {
                type = 'server',
                event = 'i13-wepdrop:server:getDropPhone',
                label = 'Võta Kontakt 100 INC',
                icon = 'fas fa-copy',
                item = 'emptydropphone',
            }
        },
        distance = 2.0,
    })
end)