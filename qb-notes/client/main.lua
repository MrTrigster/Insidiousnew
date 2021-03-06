local QBCore = exports['qb-core']:GetCoreObject()
local group = Config.Group

-- Check if is decorating --

local IsDecorating = false
local flags = 0

RegisterNetEvent('i13-anticheat:client:ToggleDecorate', function(bool)
  IsDecorating = bool
end)

local isLoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('i13-anticheat:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = false
    IsDecorating = false
    flags = 0
end)

-- Superjump --

CreateThread(function()
	while true do
        Wait(500)

        local ped = PlayerPedId()
        local player = PlayerId()

        if group == Config.Group and isLoggedIn then
            if IsPedJumping(ped) then
                local firstCoord = GetEntityCoords(ped)

                while IsPedJumping(ped) do
                    Wait(0)
                end

                local secondCoord = GetEntityCoords(ped)
                local lengthBetweenCoords = #(firstCoord - secondCoord)

                if (lengthBetweenCoords > Config.SuperJumpLength) then
                    flags = flags + 1
                    TriggerServerEvent("i13-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "** @everyone " ..GetPlayerName(player).. "** is flagged from anticheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Superjump)**")
                end
            end
        end
    end
end)

-- Speedhack --

CreateThread(function()
	while true do
        Wait(500)

        local ped = PlayerPedId()
        local player = PlayerId()
        local speed = GetEntitySpeed(ped)
        local inveh = IsPedInAnyVehicle(ped, false)
        local ragdoll = IsPedRagdoll(ped)
        local jumping = IsPedJumping(ped)
        local falling = IsPedFalling(ped)

        if group == Config.Group and isLoggedIn then
            if not inveh then
                if not ragdoll then
                    if not falling then
                        if not jumping then
                            if speed > Config.MaxSpeed then
                                flags = flags + 1
                                TriggerServerEvent("i13-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "** @everyone " ..GetPlayerName(player).. "** is flagged from anticheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Speedhack)**")
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Invisibility --

CreateThread(function()
    while true do
        Wait(10000)

        local ped = PlayerPedId()
        local player = PlayerId()

        if group == Config.Group and isLoggedIn then
            if not IsDecorating then
                if not IsEntityVisible(ped) then
                    SetEntityVisible(ped, 1, 0)
                    TriggerEvent('QBCore:Notify', "i13-ANTICHEAT: You were invisible and have been made visible again!")
                    TriggerServerEvent("i13-log:server:CreateLog", "anticheat", "Made player visible", "green", "** @everyone " ..GetPlayerName(player).. "** was invisible and has been made visible again by QB-Anticheat")
                end
            end
        end
    end
end)

-- Nightvision --

CreateThread(function()
    while true do
        Wait(2000)

        local ped = PlayerPedId()
        local player = PlayerId()

        if group == Config.Group and isLoggedIn then
            if GetUsingnightvision(true) then
                if not IsPedInAnyHeli(ped) then
                    flags = flags + 1
                    TriggerServerEvent("i13-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "** @everyone " ..GetPlayerName(player).. "** is flagged from anticheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Nightvision)**")
                end
            end
        end
    end
end)

-- Thermalvision --

CreateThread(function()
    while true do
        Wait(2000)

        local ped = PlayerPedId()

        if group == Config.Group and isLoggedIn then
            if GetUsingseethrough(true) then
                if not IsPedInAnyHeli(ped) then
                    flags = flags + 1
                    TriggerServerEvent("i13-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "** @everyone " ..GetPlayerName(player).. "** is flagged from anticheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Thermalvision)**") 
                end
            end
        end
    end
end)

-- Spawned car --

CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()
        local player = PlayerId()
        local veh = GetVehiclePedIsIn(ped)
        local DriverSeat = GetPedInVehicleSeat(veh, -1)
        local plate = QBCore.Functions.GetPlate(veh)

        if isLoggedIn then
            if group == Config.Group then
                if IsPedInAnyVehicle(ped, true) then
                    for _, BlockedPlate in pairs(Config.BlacklistedPlates) do
                        if plate == BlockedPlate then
                            if DriverSeat == ped then
                                DeleteVehicle(veh)
                                TriggerServerEvent("i13-anticheat:server:banPlayer", "Cheating")
                                TriggerServerEvent("i13-log:server:CreateLog", "anticheat", "Cheat detected!", "red", "** @everyone " ..GetPlayerName(player).. "** has been banned for cheating (Sat as driver in spawned vehicle with license plate **"..BlockedPlate..")**")
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Check if ped has weapon in inventory --

CreateThread(function()
    while true do
        Wait(5000)

        if isLoggedIn then

            local PlayerPed = PlayerPedId()
            local player = PlayerId()
            local CurrentWeapon = GetSelectedPedWeapon(PlayerPed)
            local WeaponInformation = QBCore.Shared.Weapons[CurrentWeapon]

            if WeaponInformation["name"] ~= "weapon_unarmed" then
                QBCore.Functions.TriggerCallback('i13-anticheat:server:HasWeaponInInventory', function(HasWeapon)
                    if not HasWeapon then
                        RemoveAllPedWeapons(PlayerPed, false)
                        TriggerServerEvent("i13-log:server:CreateLog", "anticheat", "Weapon removed!", "orange", "** @everyone " ..GetPlayerName(player).. "** had a weapon on them that they did not have in his inventory. QB Anticheat has removed the weapon.")
                    end
                end, WeaponInformation)
            end
        end
    end
end)

-- Max flags reached = ban, log, explosion & break --

CreateThread(function()
    while true do
        Wait(500)
        local player = PlayerId()
        if flags >= Config.FlagsForBan then
            -- TriggerServerEvent("i13-anticheat:server:banPlayer", "Cheating")
            -- AddExplosion(coords, EXPLOSION_GRENADE, 1000.0, true, false, false, true)
            TriggerServerEvent("i13-log:server:CreateLog", "anticheat", "Player banned! (Not really of course, this is a test duuuhhhh)", "red", "** @everyone " ..GetPlayerName(player).. "** Too often has been flagged by the anti-cheat and preemptively banned from the server")
            flags = 0
        end
    end
end)

RegisterNetEvent('i13-anticheat:client:NonRegisteredEventCalled', function(reason, CalledEvent)
    local player = PlayerId()

    TriggerServerEvent('i13-anticheat:server:banPlayer', reason)
    TriggerServerEvent("i13-log:server:CreateLog", "anticheat", "Player banned! (Not really of course, this is a test duuuhhhh)", "red", "** @everyone " ..GetPlayerName(player).. "** has event **"..CalledEvent.."tried to trigger (LUA injector!)")
end)

if Config.Antiresourcestop then

    AddEventHandler("onResourceStop", function(res, source)
            local source = src
            if res == GetCurrentResourceName() then
    print(GetPlayerName(src) .. " Was kicked for stopping " .. res)
    DropPlayer(src, "Stoping Resources.")
                Wait(100)
                CancelEvent()
            end 
    end)
    
end

local function collectAndSendResourceList()
    local resourceList = {}
    for i=0,GetNumResources()-1 do
        resourceList[i+1] = GetResourceByFindIndex(i)
    end
    TriggerServerEvent("qb:server:checkMyResources", resourceList)
end

CreateThread(function()
    while true do
        collectAndSendResourceList()
        Wait(15000)
    end
end)
