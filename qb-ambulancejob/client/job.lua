local statusCheckPed = nil
local PlayerJob = {}
local onDuty = false
local currentGarage = 1

-- Functions

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
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

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "AMBU"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['LegacyFuel']:SetFuel(veh, 100.0)

        SetVehicleModKit(veh, 0)
        ToggleVehicleMod(veh, 18, true)
        SetVehicleMod(veh, 13, 2, false)
        SetVehicleMod(veh, 12, 2, false)
        SetVehicleMod(veh, 11, 2, false)

        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end

function MenuGarage()
    local vehicleMenu = {
        {
            header = "Kiirabi Sõidukid",
            isMenuHeader = true
        }
    }

    local authorizedVehicles = Config.AuthorizedVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "ambulance:client:TakeOutVehicle",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Sulge Menu",
        txt = "",
        params = {
            event = "i13-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

-- Events

RegisterNetEvent('ambulance:client:TakeOutVehicle', function(data)
    local vehicle = data.vehicle
    TakeOutVehicle(vehicle)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    TriggerServerEvent("hospital:server:SetDoctor")
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    exports.spawnmanager:setAutoSpawn(false)
    local ped = PlayerPedId()
    local player = PlayerId()
    TriggerServerEvent("hospital:server:SetDoctor")
    CreateThread(function()
        Wait(5000)
        SetEntityMaxHealth(ped, 200)
        SetEntityHealth(ped, 200)
        SetPlayerHealthRechargeMultiplier(player, 0.0)
        SetPlayerHealthRechargeLimit(player, 0.0)
    end)
    CreateThread(function()
        Wait(1000)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            onDuty = PlayerData.job.onduty
            SetPedArmour(PlayerPedId(), PlayerData.metadata["armor"])
            if (not PlayerData.metadata["inlaststand"] and PlayerData.metadata["isdead"]) then
                deathTime = Laststand.ReviveInterval
                OnDeath()
                DeathTimer()
            elseif (PlayerData.metadata["inlaststand"] and not PlayerData.metadata["isdead"]) then
                SetLaststand(true, true)
            else
                TriggerServerEvent("hospital:server:SetDeathStatus", false)
                TriggerServerEvent("hospital:server:SetLaststandStatus", false)
            end
        end)
    end)
end)

RegisterNetEvent('hospital:client:SetDuty', function()
    onDuty = not onDuty
    TriggerServerEvent('hospital:server:LogDuty', onDuty)
    TriggerServerEvent("hospital:server:SetDoctor")
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent('hospital:client:CheckStatus', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 5.0 then
        local playerId = GetPlayerServerId(player)
        statusCheckPed = GetPlayerPed(player)
        QBCore.Functions.TriggerCallback('hospital:GetPlayerStatus', function(result)
            if result then
                for k, v in pairs(result) do
                    if k ~= "BLEED" and k ~= "WEAPONWOUNDS" then
                        statusChecks[#statusChecks+1] = {bone = Config.BoneIndexes[k], label = v.label .." (".. Config.WoundStates[v.severity] ..")"}
                    elseif result["WEAPONWOUNDS"] then
                        for k, v in pairs(result["WEAPONWOUNDS"]) do
                            TriggerEvent('chat:addMessage', {
                                template = '<div class="chat-message emergency"><b>Status :</b> {0}</div>',
                                args = { WeaponDamageList[v] }
                            })
                        end
                    elseif result["BLEED"] > 0 then
                        TriggerEvent('chat:addMessage', {
                            template = '<div class="chat-message emergency"><b>Status :</b> On {0}</div>',
                            args = { Config.BleedingStates[v].label }
                        })
                    else
                        QBCore.Functions.Notify('Isik on terve', 'success')
                    end
                end
                isStatusChecking = true
                statusCheckTime = Config.CheckTime
            end
        end, playerId)
    else
        QBCore.Functions.Notify('Kedagi pole lähedal', 'error')
    end
end)

RegisterNetEvent('hospital:client:RevivePlayer', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                QBCore.Functions.Progressbar("hospital_revive", "Elustab isikut...", 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify("Isik edukalt elustatud")
                    TriggerServerEvent("hospital:server:RevivePlayer", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify("Ebaõnnestus", "error")
                end)
            else
                QBCore.Functions.Notify("Kedagi pole lähedal", "error")
            end
        else
            QBCore.Functions.Notify("Sul on vaja First Aid Kit\'i", "error")
        end
    end, 'firstaid')
end)

RegisterNetEvent('hospital:client:TreatWounds', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                QBCore.Functions.Progressbar("hospital_healwounds", "Ravib vigastusi...", 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify("Sa abistasid isikut")
                    TriggerServerEvent("hospital:server:TreatWounds", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    QBCore.Functions.Notify("Ebaõnnestus", "error")
                end)
            else
                QBCore.Functions.Notify("Kedagi pole lähedal", "error")
            end
        else
            QBCore.Functions.Notify("Sul on vaja Bandage", "error")
        end
    end, 'bandage')
end)

RegisterNetEvent('hospital:client:openArmory', function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
end)

RegisterNetEvent('hospital:client:openStash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "emsstash_gear", {
        maxweight = 4000000,
        slots = 500,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "emsstash_gear")
end)

-- Threads

CreateThread(function()
    while true do
        Wait(10)
        if isStatusChecking then
            for k, v in pairs(statusChecks) do
                local x,y,z = table.unpack(GetPedBoneCoords(statusCheckPed, v.bone))
                DrawText3D(x, y, z, v.label)
            end
        end
        if isHealingPerson then
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, healAnimDict, healAnim, 3) then
                loadAnimDict(healAnimDict)
                TaskPlayAnim(ped, healAnimDict, healAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
    end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('emsduty', vector3(307.51, -595.29, 43.28), 0.4, 0.5, {
        name = 'emsduty',
        heading = 70,
        debugPoly = false,
        minZ = 43.03,
        maxZ = 43.63
    }, {
        options = {
            {
                type = 'client',
                event = 'hospital:client:SetDuty',
                label = 'On Duty / Off Duty',
                icon = 'fas fa-clipboard-list',
                job = 'ambulance'
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone('emsarmory', vector3(306.56, -602.43, 43.28), 0.6, 2.1, {
        name = 'emsarmory',
        heading = 340,
        debugPoly = false,
        minZ = 42.28,
        maxZ = 44.63
    }, {
        options = {
            {
                type = 'client',
                event = 'hospital:client:openArmory',
                label = 'Varustuse Kapp',
                icon = 'fas fa-box',
                job = 'ambulance'
            },
            {
                type = 'client',
                event = 'hospital:client:openStash',
                label = 'Ava Kapp',
                icon = 'fas fa-box',
                job = 'ambulance'
            }
        },
        distance = 1.5,
    })
end)