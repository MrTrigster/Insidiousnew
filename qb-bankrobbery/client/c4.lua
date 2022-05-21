local QBCore = exports['qb-core']:GetCoreObject()

blackoutIsActive = false

local function doExplode()
    vector3(2474.44, 1465.0, 36.2)
    AddExplosion(2474.44, 1465.0, 36.2, 2, 0.0, true, false, 0.0)
end

RegisterNetEvent('i13-bankrobbery:client:useC4', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local loc = nil
    local station = nil
    if CurrentCops >= Config.MinimumThermitePolice then
        if #(pos - Config.PowerStations[1].coords) < 2.0 then
            if Config.PowerStations[1].hit == false then
                loc = vector4(2474.3, 1464.32, 36.2, 179.64)
                station = 1
            else
                QBCore.Functions.Notify('See on juba õhku lastud', 'error')
                return
            end
        elseif #(pos - Config.PowerStations[2].coords) < 2.0 then
            if Config.PowerStations[2].hit == false then
                loc = vector4(2058.74, 3692.04, 34.59, 121.1)
                station = 2
            else
                QBCore.Functions.Notify('See on juba õhku lastud', 'error')
                return
            end
        elseif #(pos - Config.PowerStations[3].coords) < 2.0 then
            if Config.PowerStations[3].hit == false then
                loc = vector4(711.80, 165.47, 80.75, 337.41)
                station = 3
            else
                QBCore.Functions.Notify('See on juba õhku lastud', 'error')
                return
            end
        else
            return
        end

        SetEntityHeading(ped, loc.w)
        RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
        RequestModel('hei_p_m_bag_var22_arm_s')
        while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') and not HasModelLoaded('hei_p_m_bag_var22_arm_s') do
            Wait(50)
        end
        Wait(100)
        local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
        local c4Scene = NetworkCreateSynchronisedScene(loc.x, loc.y, loc.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
        local bag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), loc.x, loc.y, loc.z,  true,  true, false)
        SetEntityCollision(bag, false, true)
        NetworkAddPedToSynchronisedScene(ped, c4Scene, 'anim@heists@ornate_bank@thermal_charge', 'thermal_charge', 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bag, c4Scene, 'anim@heists@ornate_bank@thermal_charge', 'bag_thermal_charge', 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(c4Scene)
        Wait(1500)
        local x, y, z = table.unpack(GetEntityCoords(ped))
        local bomb = CreateObject(GetHashKey('prop_bomb_01_s'), x, y, z + 0.2,  true,  true, true)
        SetEntityCollision(bomb, false, true)
        AttachEntityToEntity(bomb, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 270.0, 90.0, true, true, false, true, 1, true)
        Wait(4000)
        DeleteObject(bag)
        DetachEntity(bomb, 1, 1)
        FreezeEntityPosition(bomb, true)
        ClearPedTasks(ped)

        TriggerServerEvent("QBCore:Server:RemoveItem", "c4", 1)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["c4"], "remove")

        QBCore.Functions.Notify('C4 Lendab õhku 15 sekundi pärast', 'success')
        Wait(15000)
        AddExplosion(loc.x, loc.y, loc.z, 2, 0.0, true, false, 0.5)
        TriggerServerEvent('i13-bankrobbery:server:powerExplosion', loc)
        DeleteObject(bomb)
        if station == 1 then
            Config.PowerStations[1].hit = true
        elseif station == 2 then
            Config.PowerStations[2].hit = true
        elseif station == 3 then
            Config.PowerStations[3].hit = true
        end
        TriggerServerEvent('i13-bankrobbery:server:c4alert', station)
        TriggerServerEvent('i13-bankrobbery:server:powerstationHit')
    else
        QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke. Vaja ('..Config.MinimumThermitePolice..')', 'error')
    end
end)

RegisterNetEvent('i13-bankrobbery:client:powerExplosion', function(loc)
    AddExplosion(loc.x, loc.y, loc.z, 2, 0.0, true, false, 0.5)
end)

RegisterNetEvent('i13-bankrobbery:client:resetPower', function(state)
    for k,v in pairs(Config.PowerStations) do
        Config.PowerStations[k].hit = state
    end
end)

RegisterNetEvent('i13-bankrobbery:client:blackoutActive', function(state)
    blackoutIsActive = state
end)