local QBCore = exports['qb-core']:GetCoreObject()
local BackEngineVehicles = { -- Used from qb-vehicle failure <3
'ninef',
'adder',
'vagner',
't20',
'infernus',
'zentorno',
'reaper',
'comet2',
'comet3',
'jester',
'jester2',
'cheetah',
'cheetah2',
'prototipo',
'turismor',
'pfister811',
'ardent',
'nero',
'nero2',
'tempesta',
'vacca',
'bullet',
'osiris',
'entityxf',
'turismo2',
'fmj',
're7b',
'tyrus',
'italigtb',
'penetrator',
'monroe',
'ninef2',
'stingergt',
'surfer',
'surfer2',
'comet3',
'xa21',
}

isLoggedIn = true
PlayerJob = {}

local onDuty = false

local modZone = {
    vector2(154.48, -3051.36),
    vector2(120.85, -3051.68),
    vector2(120.88, -3007.13),
    vector2(153.41, -3007.04),
}
local inModZone = false

local bones = {
    'bonnet',
    'boot'
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        -- if PlayerData.job.onduty then
        --     if PlayerData.job.name == Config.Job then
        --         TriggerServerEvent("QBCore:ToggleDuty")
        --     end
        -- end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)


local function saveVehicle()
    local plyPed = PlayerPedId()
    local veh = QBCore.Functions.GetClosestVehicle()
    local vehicleMods = {
        mods = {},
    }
    vehicleMods.mods[11] = GetVehicleMod(veh,11)
    vehicleMods.mods[12] = GetVehicleMod(veh,12)
    vehicleMods.mods[13] = GetVehicleMod(veh,13)
    vehicleMods.mods[15] = GetVehicleMod(veh,15)
    vehicleMods.mods[18] = IsToggleModOn(veh, 18)

local myCar = QBCore.Functions.GetVehicleProperties(veh)
    TriggerServerEvent('updateVehicle',myCar)
end

function IsBackEngine(vehModel)
    for _, model in pairs(BackEngineVehicles) do
        if GetHashKey(model) == vehModel then
            return true
        end
    end
    return false
end

local function createModZone()
    local zone = PolyZone:Create(modZone, {
        name = 'modZone',
        debugPoly = false,
        minZ = 6.04,
        maxZ = 10.7
    })

    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inModZone = true
            -- print('in mod zone')
        else
            inModZone = false
            -- print('out of mod zone')
        end
    end)
end

--- PARTS CRAFTING ---
-- ENGINE
RegisterNetEvent('craft:engine1')
AddEventHandler("craft:engine1", function()
    QBCore.Functions.Progressbar("craft_engine1", "Ehitab Mootorit...", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,10)
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("craft:engine1")
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify("Ebaõnnestus", "error")
        ClearPedTasks(playerPed)
        end
    end)
end)

RegisterNetEvent('craft:engine2')
AddEventHandler("craft:engine2", function()
    QBCore.Functions.Progressbar("craft_engine2", "Ehitab Mootorit...", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("craft:engine2")
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify("Ebaõnnestus", "error")
        ClearPedTasks(playerPed)
        end
    end)
end)

RegisterNetEvent('craft:engine3')
AddEventHandler("craft:engine3", function()
    QBCore.Functions.Progressbar("craft_engine3", "Ehitab Mootorit...", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(4,9)
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("craft:engine3")
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify("Ebaõnnestus", "error")
        ClearPedTasks(playerPed)
        end
    end)
end)

RegisterNetEvent('craft:engine4')
AddEventHandler("craft:engine4", function()
    QBCore.Functions.Progressbar("craft_engine4", "Ehitab Mootorit...", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(4,8)
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("craft:engine4")
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify("Ebaõnnestus", "error")
        ClearPedTasks(playerPed)
        end
    end)
end)

-- BRAKES
RegisterNetEvent('craft:brake0')
AddEventHandler("craft:brake0", function()
    QBCore.Functions.Progressbar("craft_brake0", "Ehitab Pidureid...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(1,30)
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("craft:brake0")
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify("Ebaõnnestus", "error")
        ClearPedTasks(playerPed)
        end
    end)
end)

RegisterNetEvent('craft:brake1')
AddEventHandler("craft:brake1", function()
    QBCore.Functions.Progressbar("craft_brake1", "Ehitab Pidureid...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(1,30)
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("craft:brake1")
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify("Ebaõnnestus", "error")
        ClearPedTasks(playerPed)
        end
    end)
end)

-- TURBO
RegisterNetEvent('craft:turbo0')
AddEventHandler("craft:turbo0", function()
    QBCore.Functions.Progressbar("craft_turbo0", "Ehitab Turbo...", 11000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(1,30)
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("craft:turbo0")
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify("Ebaõnnestus", "error")
        ClearPedTasks(playerPed)
        end
    end)
end)

RegisterNetEvent('craft:turbo1')
AddEventHandler("craft:turbo1", function()
    QBCore.Functions.Progressbar("craft_turbo1", "Ehitab Turbo...", 11000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(1,30)
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("craft:turbo1")
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify("Ebaõnnestus", "error")
        ClearPedTasks(playerPed)
        end
    end)
end)

--- REPAIR KITS ---
RegisterNetEvent('craft:repairkit')
AddEventHandler("craft:repairkit", function()
    QBCore.Functions.Progressbar("craft_repairkit", "Ehitab Repair Kit'i...", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,10)
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("craft:repairkit")
        ClearPedTasks(playerPed)
    else
        QBCore.Functions.Notify("Ebaõnnestus", "error")
        ClearPedTasks(playerPed)
        end
    end)
end)

--- PARTS INSTALLATION ---
-- ENGINE
RegisterNetEvent('qb-mechanicparts:E0')
AddEventHandler('qb-mechanicparts:E0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
--     local trunkpos = false
    engine = GetVehicleMod(veh, 11)
        if PlayerJob.name == Config.Job then
            if onDuty then
                  if engine ~= -1 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
-- 			    trunkpos = true
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                                QBCore.Functions.Progressbar("Gas_Engine", "Paigaldab Mod'i...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, -1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "engine0", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine0"], "remove")
                                    QBCore.Functions.Notify("Stock Engine Edukalt Paigaldatud", "success")
                                end)
-- 				if trunkpos then
-- 					SetVehicleDoorShut(vehicle, 5, false)
-- 				else
-- 					SetVehicleDoorShut(vehicle, 4, false)
-- 				end
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stock Engine Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)
RegisterNetEvent('qb-mechanicparts:E1')
AddEventHandler('qb-mechanicparts:E1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    engine = GetVehicleMod(veh, 11)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if engine ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Gas_Engine", "Paigaldab Mod'i...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, 0, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "engine1", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine1"], "remove")
                                    QBCore.Functions.Notify("Engine Upgrade C Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Engine Upgrade C Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:E2')
AddEventHandler('qb-mechanicparts:E2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    engine = GetVehicleMod(veh, 11)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if engine ~= 1 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Gas_Engine", "Paigaldab Mod'i...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, 1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "engine2", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine2"], "remove")
                                    QBCore.Functions.Notify("Engine Upgrade B Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Engine Upgrade B Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:E3')
AddEventHandler('qb-mechanicparts:E3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    engine = GetVehicleMod(veh, 11)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if engine ~= 2 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Gas_Engine", "Paigaldab Mod'i...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, 2, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "engine3", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine3"], "remove")
                                    QBCore.Functions.Notify("Engine Upgrade A Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Engine Upgrade A Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)


RegisterNetEvent('qb-mechanicparts:E4')
AddEventHandler('qb-mechanicparts:E4', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    engine = GetVehicleMod(veh, 11)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if engine ~= 3 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Gas_Engine", "Paigaldab Mod'i...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, 3, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "engine4", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine4"], "remove")
                                    QBCore.Functions.Notify("Engine Upgrade S Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Engine Upgrade S Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

--brakes
RegisterNetEvent('qb-mechanicparts:B0')
AddEventHandler('qb-mechanicparts:B0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    brake = GetVehicleMod(veh, 12)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if brake ~= -1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Brakes", "Paigaldab Mod'i...", 8500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 12, -1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "brake0", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["brake0"], "remove")
                                    QBCore.Functions.Notify("Stock Brakes Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stock Brakes Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:B1')
AddEventHandler('qb-mechanicparts:B1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    brake = GetVehicleMod(veh, 12)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if brake ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Brakes", "Paigaldab Mod'i...", 8500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 12, 0, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "brake1", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["brake1"], "remove")
                                    QBCore.Functions.Notify("Brake Upgrade B Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Brakes Upgrade B Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:B2')
AddEventHandler('qb-mechanicparts:B2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    brake = GetVehicleMod(veh, 12)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if brake ~= 1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Brakes", "Paigaldab Mod'i...", 8500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 12, 1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "brake2", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["brake2"], "remove")
                                    QBCore.Functions.Notify("Brakes Upgrade A Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Brakes Upgrade A Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:B3')
AddEventHandler('qb-mechanicparts:B3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    brake = GetVehicleMod(veh, 12)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if brake ~= 2 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Brakes", "Paigaldab Mod'i...", 8500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 12, 2, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "brake3", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["brake3"], "remove")
                                    QBCore.Functions.Notify("Brakes Upgrade S Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Brakes Upgrade S Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

-- --Transmission
RegisterNetEvent('qb-mechanicparts:T0')
AddEventHandler('qb-mechanicparts:T0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    transmission = GetVehicleMod(veh, 13)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if transmission ~= -1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Transmission", "Paigaldab Mod'i...", 9250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 13, -1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "transmission0", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["transmission0"], "remove")
                                    QBCore.Functions.Notify("Stock Transmission Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stock Transmission Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:T1')
AddEventHandler('qb-mechanicparts:T1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    transmission = GetVehicleMod(veh, 13)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if transmission ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Transmission", "Paigaldab Mod'i...", 9250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 13, 0, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "transmission1", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["transmission1"], "remove")
                                    QBCore.Functions.Notify("Transmission Upgrade B Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Transmission Upgrade B Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:T2')
AddEventHandler('qb-mechanicparts:T2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    transmission = GetVehicleMod(veh, 13)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if transmission ~= 1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Transmission", "Paigaldab Mod'i...", 9250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 13, 1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "transmission2", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["transmission2"], "remove")
                                    QBCore.Functions.Notify("Transmission Upgrade A Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Transmission Upgrade A Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:T3')
AddEventHandler('qb-mechanicparts:T3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    transmission = GetVehicleMod(veh, 13)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if transmission ~= 2 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Transmission", "Paigaldab Mod'i...", 9250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 13, 2, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "transmission3", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["transmission3"], "remove")
                                    QBCore.Functions.Notify("Transmission Upgrade S Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Transmission Upgrade S Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

-- --Suspension
RegisterNetEvent('qb-mechanicparts:S0')
AddEventHandler('qb-mechanicparts:S0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(veh, 15)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if suspension ~= -1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Paigaldab Mod'i...", 9000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, -1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "suspension0", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension0"], "remove")
                                    QBCore.Functions.Notify("Stock Suspension Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stock Suspension Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:S1')
AddEventHandler('qb-mechanicparts:S1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(veh, 15)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if suspension ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Paigaldab Mod'i...", 9000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, 0, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "suspension1", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension1"], "remove")
                                    QBCore.Functions.Notify("Suspension Upgrade C Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Suspension Upgrade C Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:S2')
AddEventHandler('qb-mechanicparts:S2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(veh, 15)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if suspension ~= 1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Paigaldab Mod'i...", 9000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, 1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "suspension2", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension2"], "remove")
                                    QBCore.Functions.Notify("Suspension Upgrade B Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Suspension Upgrade B Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:S3')
AddEventHandler('qb-mechanicparts:S3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(veh, 15)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if suspension ~= 2 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Paigaldab Mod'i...", 9000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, 2, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "suspension3", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension3"], "remove")
                                    QBCore.Functions.Notify("Suspension Upgrade A Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Suspension Upgrade A Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:S4')
AddEventHandler('qb-mechanicparts:S4', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(veh, 15)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if suspension ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Paigaldab Mod'i...", 9000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, 3, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "suspension4", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension4"], "remove")
                                    QBCore.Functions.Notify("Suspension Upgrade S Edukalt Paigaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Suspension Upgrade S Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

-- --Suspension
RegisterNetEvent('qb-mechanicparts:Turbo0')
AddEventHandler('qb-mechanicparts:Turbo0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    turbo = IsToggleModOn(veh, 18)
    print(turbo)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if turbo == 1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Turbo", "Eemaldab Turbo...", 9250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 18, false)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "turbo0", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["turbo0"], "remove")
                                    QBCore.Functions.Notify("Turbo Edukalt Eemaldatud", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Turbo Juba Eemaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:Turbo1')
AddEventHandler('qb-mechanicparts:Turbo1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    turbo = IsToggleModOn(veh, 18)
    print(turbo)
        if PlayerJob.name == Config.Job then
            if onDuty then
                if turbo == false then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Turbo", "Paigaldab Turbo...", 9500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 18, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("QBCore:Server:RemoveItem", "turbo1", 1)
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["turbo1"], "remove")
                                    QBCore.Functions.Notify("Turbo Edukalt Paigaldatud", "success")
                                    

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Turbo Juba Paigaldatud", "error")
                end
            else
                QBCore.Functions.Notify("Sa pead olema On Duty", "error")
            end
        else
            QBCore.Functions.Notify("Sa ei saa seda teha", "error")
        end
end)



-------------------------USING QB MENU FOR BELOW-------------------------
---------YOU MUST CONVERT TO WHAT YOUR USING IF NOT USING QB MENU--------
-------------------------------------------------------------------------

RegisterNetEvent('craft:mechanicparts', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Osade Menu",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Mootori Osad",
            txt = " Vaata mootori osasid ",
            params = {
                event = "craft:engines",
            }
        },
        {
            id = 3,
            header = "Piduri Osad",
            txt = " Vaata piduri osasid ",
            params = {
                event = "craft:brakes",
            }
        },
        {
            id = 4,
            header = "Käigukasti Osad",
            txt = " Vaata käigukasti osasid ",
            params = {
                event = "craft:transmissions",
            }
        },
        {
            id = 5,
            header = "Vedrustuse Osad",
            txt = " Vaata vedrustuse osasid ",
            params = {
                event = "craft:suspensions",
            }
        },
        {
            id = 6,
            header = "Turbo",
            txt = " Vaata turbo osasid ",
            params = {
                event = "craft:turbos",
            }
        },
        {
            id = 7,
            header = "Tööriistad & Varustus",
            txt = " Vaata tööriistu ja varustust ",
            params = {
                event = "craft:repairkit1",
            }
        },
        {
            id = 8,
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)



RegisterNetEvent('craft:engines', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Mootori Osad",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock Engine",
            txt = " 3x Metalscrap | 2x Rubber | 1x Iron | 2x Plastic ",
            params = {
                event = "craft:engine0",
            }
        },
        {
            id = 3,
            header = "Engine Upgrade C",
            txt = " 3x Metalscrap | 2x Rubber | 1x Iron | 2x Plastic ",
            params = {
                event = "craft:engine1",
            }
        },
        {
            id = 4,
            header = "Engine Upgrade B",
            txt = " 4x Metalscrap | 2x Rubber | 1x Iron | 2x Plastic ",
            params = {
                event = "craft:engine2",
            }
        },
        {
            id = 5,
            header = "Engine Upgrade A",
            txt = " 4x Metalscrap | 2x Rubber | 1x Iron | 3x Plastic ",
            params = {
                event = "craft:engine3",
            }
        },
        {
            id = 6,
            header = "Engine Upgrade S",
            txt = " 4x Metalscrap | 2x Rubber | 1x Iron | 3x Plastic | 3x Aluminum ",
            params = {
                event = "craft:engine4",
            }
        },
        {
            id = 7,
            header = "Tagasi",
            txt = "Tagasi peamenüüsse",
            params = {
                event = "craft:mechanicparts",
            }
        },
        {
            id = 8,
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },

    })
end)

RegisterNetEvent('craft:brakes', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Brake Modifications",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock Brakes",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:brake0",
            }
        },
        {
            id = 3,
            header = "Brake Upgrade B",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:brake1",
            }
        },
        {
            id = 4,
            header = "Brake Upgrade C",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:brake2",
            }
        },
        {
            id = 5,
            header = "Brake Upgrade D",
            txt = "3x Rubber | 2x Iron | 2x Metalscrap",
            params = {
                event = "craft:brake3",
            }
        },
        {
            id = 6,
            header = "Brake Upgrade S",
            txt = "3x Rubber | 2x Iron | 2x Metalscrap",
            params = {
                event = "craft:brake4",
            }
        },
        {
            id = 7,
            header = "Tagasi",
            txt = "Back to Tagasi",
            params = {
                event = "craft:mechanicparts",
            }
        },
        {
            id = 8,
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)



--------------- HAVENT MESSED WITH THE REQUIREMENTS DISPLAYED FOR BELOW ------------------
RegisterNetEvent('craft:transmissions', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Transmission Modifications",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock Transmission",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:transmission0",
            }
        },
        {
            id = 3,
            header = "Transmission Upgrade B",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:transmission1",
            }
        },
        {
            id = 4,
            header = "Transmission Upgrade C",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:transmission2",
            }
        },
        {
            id = 5,
            header = "Transmission Upgrade D",
            txt = "3x Rubber | 2x Iron | 2x Metalscrap",
            params = {
                event = "craft:transmission3",
            }
        },
        {
            id = 6,
            header = "Transmission Upgrade S",
            txt = "3x Rubber | 2x Iron | 2x Metalscrap",
            params = {
                event = "craft:transmission4",
            }
        },
        {
            id = 7,
            header = "Tagasi",
            txt = "Back to Tagasi",
            params = {
                event = "craft:mechanicparts",
            }
        },
        {
            id = 8,
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)

RegisterNetEvent('craft:suspensions', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Suspension Modifications",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock Suspension",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:suspension0",
            }
        },
        {
            id = 3,
            header = "Suspension Upgrade B",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:suspension1",
            }
        },
        {
            id = 4,
            header = "Suspension Upgrade C",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:suspension2",
            }
        },
        {
            id = 5,
            header = "Suspension Upgrade D",
            txt = "3x Rubber | 2x Iron | 2x Metalscrap",
            params = {
                event = "craft:suspension3",
            }
        },
        {
            id = 6,
            header = "Suspension Upgrade S",
            txt = "3x Rubber | 2x Iron | 2x Metalscrap",
            params = {
                event = "craft:suspension4",
            }
        },
        {
            id = 7,
            header = "<-- Tagasi",
            txt = "Tagasi peamenüüsse",
            params = {
                event = "craft:mechanicparts",
            }
        },
        {
            id = 8,
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)

RegisterNetEvent('craft:turbos', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Turbos",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock (N/A)",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:turbo0",
            }
        },
        {
            id = 3,
            header = "Turbo",
            txt = "2x Rubber | 1x Iron | 2x Metalscrap",
            params = {
                event = "craft:turbo1",
            }
        },
        {
            id = 4,
            header = "Tagasi",
            txt = "Back to Tagasi",
            params = {
                event = "craft:mechanicparts",
            }
        },
        {
            id = 5,
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)

RegisterNetEvent('craft:repairkit1', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Tools & Equipment",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Repair Kit",
            txt = "4x MetalScrap | 2x Rubber | 3x Plastic | 2x aluminum | 2x Steel",
            params = {
                event = "craft:repairkit",
            }
        },
        {
            id = 3,
            header = "Tagasi",
            txt = "Back to Tagasi",
            params = {
                event = "craft:mechanicparts",
            }
        },
        {
            id = 4,
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)
-------------------------------------- ONLY EDIT UNDER HERE / ABOVE WORKS AS IT SHOULD
RegisterNetEvent('craft:vehmenu', function()
    local ped = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local plate = QBCore.Functions.GetPlate(vehicle)

    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Sõiduk: " .. plate,
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Seisund",
            txt = "Vaata sõiduki seisundit",
            params = {
                event = "craft:vehstatus",
            }
        },
        {
            id = 3,
            header = "Sõiduki Osad",
            txt = "Vaata sõiduki osasid",
            params = {
                event = "craft:vehmods",
            }
        },
        {
            id = 4,
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    })
end)

RegisterNetEvent('craft:vehmods', function()
    local ped = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local plate = QBCore.Functions.GetPlate(vehicle)
    local statusList = exports['qb-mechanicjob']:GetVehicleStatusList(plate)
    local fuel = exports['LegacyFuel']:GetFuel(vehicle)
    local turbo = "N/A"
    if IsToggleModOn(vehicle, 18) == 1 then
        turbo = "Turbo"
    end

    local engine = "Stock"
    local engineMod = GetVehicleMod(vehicle, 11)
    if engineMod > -1 then
        if engineMod == -1 then
            engine = "Stock"
        elseif engineMod == 0 then    
            engine = "C Class"
        elseif engineMod == 1 then
            engine = "B Class"
        elseif engineMod == 2 then
            engine = "A Class"
        elseif engineMod == 3 then
            engine = "S Class"
        end
    end

    local brakes = "Stock"
    local brakesMod = GetVehicleMod(vehicle, 12)
    if brakesMod > -1 then
        if brakesMod == -1 then
            brakes = "Stock"
        elseif brakesMod == 0 then
            brakes = "B Class"    
        elseif brakesMod == 1 then
            brakes = "A Class"
        elseif brakesMod == 2 then
            brakes = "S Class"
        end  
    end

    local transmission = "Stock"
    local transMod = GetVehicleMod(vehicle, 13)
    if transMod > 0 then
        if transMod == 0 then
            transmission = "Stock"
        elseif transMod == 0 then    
            transmission = "B Class"
        elseif transMod == 1 then
            transmission = "A Class"
        elseif transMod == 2 then
            transmission = "S Class"
        end   
    end

    local suspension = "Stock"
    local susMod = GetVehicleMod(vehicle, 15)
    if susMod > -1 then
        if susMod == -1 then
            suspension = "Stock"
        elseif susMod == 0 then
            suspension = "C Class"    
        elseif susMod == 1 then
            suspension = "B Class"
        elseif susMod == 2 then
            suspension = "A Class"
        elseif susMod == 3 then
            suspension = "S Class"
        end 
    end

    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Sõiduk: " .. plate,
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Mootor: ".. engine,
            txt = "",
            isMenuHeader = true
        },
        {
            id = 3,
            header = "Käigukast: ".. transmission,
            txt = "",
            isMenuHeader = true
        },
        {
            id = 4,
            header = "Vedrustus: ".. suspension,
            txt = "",
            isMenuHeader = true
        },
        {
            id = 5,
            header = "Pidurid: ".. brakes,
            txt = "",
            isMenuHeader = true
        },
        {
            id = 6,
            header = "Turbo: ".. turbo,
            txt = "",
            isMenuHeader = true
        },
        {
            id = 7,
            header = "<-- Tagasi",
            txt = "",
            params = {
                event = "craft:vehmenu",
            }
        },
    })
end)

-- VEHICLE HEALTH/STATUS
RegisterNetEvent('craft:vehstatus', function()

    local statusList = exports['qb-mechanicjob']:GetVehicleStatusList(plate)
    fuel = exports['LegacyFuel']:GetFuel(vehicle)
    vehicle = QBCore.Functions.GetClosestVehicle()
    plate = GetVehicleNumberPlateText(vehicle)
    engineHealth = GetVehicleEngineHealth(vehicle)
    vehTemp = GetVehicleEngineTemperature(vehicle)
    bodyHealth = GetVehicleBodyHealth(vehicle)
    fuelHealth = exports['LegacyFuel']:GetFuel(vehicle)
    tankHealth = GetVehiclePetrolTankHealth(vehicle)

    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Kütusetase",
            txt = "Status: " .. math.ceil(fuelHealth) .. ".0% / 100.0%",
        },
        {
            id = 2,
            header = "Mootor",
            txt = "Status: " .. math.ceil(engineHealth / 10) .. "% / 100.0%",
        },
        {
            id = 3,
            header = "Kere",
            txt = "Status: " .. math.ceil(bodyHealth / 10) .. "% / 100.0%",
        },
        {
            id = 4,
            header = "Mootori Temp.",
            txt = "Status: " .. math.ceil(vehTemp) .. "° C",
        }, 

        {
            id = 5,
            header = "<-- Tagasi",
            txt = "Tagasi peamenüüsse",
            params = {
                event = "craft:vehmenu",
            }
        },
        {
            id = 6,
            header = "Sulge Menu",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    })
end)

CreateThread(function()
    exports['qb-target']:AddTargetBone(bones, {
        options = {
            {
                type = "client",
                event = "craft:vehmenu",
                icon = "fas fa-wrench",
                label = "Sõiduki Menu",
                job = 'mechanic',
                canInteract = function()
                    if inModZone then
                        return true
                    else
                        return false
                    end
                end,
            }
        },
        distance = 1.5,
    })
end)

createModZone()