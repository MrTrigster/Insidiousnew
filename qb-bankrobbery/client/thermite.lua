local QBCore = exports['qb-core']:GetCoreObject()
local currentGate = 0

RegisterNetEvent('qb-bankrobbery:client:useThermite', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if #(pos - Config.BigBanks['pacific']['thermite'][1]['coords']) < 2.0 then
        currentThermiteGate = Config.BigBanks['pacific']['thermite'][1]['doorId']
    elseif #(pos - Config.BigBanks['pacific']['thermite'][2]['coords']) < 2.0 then
        currentThermiteGate = Config.BigBanks['pacific']['thermite'][2]['doorId']
    elseif #(pos - Config.BigBanks['pacific']['thermite'][3]['coords']) < 2.0 then
        currentThermiteGate = Config.BigBanks['pacific']['thermite'][3]['doorId']
    end

    if currentThermiteGate ~= 0 then
        if CurrentCops >= Config.MinimumThermitePolice then

            currentGate = currentThermiteGate
            if currentGate == Config.BigBanks['pacific']['thermite'][1]['doorId'] then
                if Config.BigBanks['pacific']['thermite'][1]['isOpened'] == false then
                    loc = vector4(257.40, 220.20, 106.35, 336.48)
                    ptfx = vector3(257.39, 221.20, 106.29)
                    oldmodel = "hei_v_ilev_bk_gate_pris"
                    newmodel = "hei_v_ilev_bk_gate_molten"
                    rotplus = 0.0
                else
                    QBCore.Functions.Notify('Uks on juba sulatatud', 'error')
                    return
                end
            elseif currentGate == Config.BigBanks['pacific']['thermite'][2]['doorId'] then
                if Config.BigBanks['pacific']['thermite'][2]['isOpened'] == false then
                    loc = vector4(252.95, 220.70, 101.76, 160)
                    ptfx = vector3(252.985, 221.70, 101.72)
                    oldmodel = "hei_v_ilev_bk_safegate_pris"
                    newmodel = "hei_v_ilev_bk_safegate_molten"
                    rotplus = 0.0
                else
                    QBCore.Functions.Notify('Uks on juba sulatatud', 'error')
                    return
                end    
            elseif currentGate == Config.BigBanks['pacific']['thermite'][3]['doorId'] then
                if Config.BigBanks['pacific']['thermite'][3]['isOpened'] == false then
                    loc = vector4(261.65, 215.60, 101.76, 252)
                    ptfx = vector3(261.68, 216.63, 101.75)
                    oldmodel = "hei_v_ilev_bk_safegate_pris"
                    newmodel = "hei_v_ilev_bk_safegate_molten"
                    rotplus = 0.0
                else
                    QBCore.Functions.Notify('Uks on juba sulatatud', 'error')
                    return
                end     
            end

            RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
            RequestModel("hei_p_m_bag_var22_arm_s")
            RequestNamedPtfxAsset("scr_ornate_heist")
            while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
                Wait(50)
            end
            SetEntityHeading(ped, loc.w)
            Wait(100)
            local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
            local thermiteScene = NetworkCreateSynchronisedScene(loc.x, loc.y, loc.z, rotx, roty, rotz + rotplus, 2, false, false, 1065353216, 0, 1.3)
            local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), loc.x, loc.y, loc.z,  true,  true, false)
            SetEntityCollision(bag, false, true)
            NetworkAddPedToSynchronisedScene(ped, thermiteScene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(bag, thermiteScene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
            NetworkStartSynchronisedScene(thermiteScene)
            Wait(1500)
            local x, y, z = table.unpack(GetEntityCoords(ped))
            local bomb = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.2,  true,  true, true)
            SetEntityCollision(bomb, false, true)
            AttachEntityToEntity(bomb, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
            Wait(4000)
            DeleteObject(bag)
            DetachEntity(bomb, 1, 1)
            FreezeEntityPosition(bomb, true)

            TriggerServerEvent("QBCore:Server:RemoveItem", "thermite", 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["thermite"], "remove")

            exports["memorygame"]:thermiteminigame(9, 2, 2, 7,
    		function() -- success
				TriggerServerEvent('qb-bankrobbery:server:thermiteFX', currentGate)
                SetPtfxAssetNextCall("scr_ornate_heist")
                local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                NetworkStopSynchronisedScene(thermiteScene)

                TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
                TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
                Wait(2000)
                ClearPedTasks(ped)
                Wait(2000)
                DeleteObject(bomb)
                --TriggerServerEvent('qb-bankrobbery:server:meltGate', loc, oldmodel, newmodel)
                Wait(9000)
                StopParticleFxLooped(effect, 0)

                if currentGate == Config.BigBanks['pacific']['thermite'][1]['doorId'] then
                    TriggerServerEvent('qb-doorlock:server:updateState', 4, false, false, false, true)
                    Config.BigBanks['pacific']['thermite'][1]['isOpened'] = true
                elseif currentGate == Config.BigBanks['pacific']['thermite'][2]['doorId'] then
                    TriggerServerEvent('qb-doorlock:server:updateState', 2, false, false, false, true)
                    Config.BigBanks['pacific']['thermite'][2]['isOpened'] = true
                elseif currentGate == Config.BigBanks['pacific']['thermite'][3]['doorId'] then
                    TriggerServerEvent('qb-doorlock:server:updateState', 3, false, false, false, true)
                    Config.BigBanks['pacific']['thermite'][3]['isOpened'] = true
                end

    		end,
    		function() -- failure
				QBCore.Functions.Notify('Ebaõnnestus, thermite läks katki..', 'error')
                DeleteObject(bomb)
                ClearPedTasks(ped)
    		end)
        else
            QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke. Vaja ('..Config.MinimumThermitePolice..')', 'error')
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:client:thermiteFX', function(gate)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Wait(1)
    end

    if gate == Config.BigBanks['pacific']['thermite'][1]['doorId'] then
        ptfx = vector3(257.39, 221.20, 106.29)
    elseif gate == Config.BigBanks['pacific']['thermite'][2]['doorId'] then
        ptfx = vector3(252.985, 221.70, 101.72)
    elseif gate == Config.BigBanks['pacific']['thermite'][3]['doorId'] then
        ptfx = vector3(261.68, 216.63, 101.75)
    end
    
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(13000)
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('qb-bankrobbery:client:meltGate', function(loc, oldmodel, newmodel)
    CreateModelSwap(loc.x, loc.y, loc.z, 5, GetHashKey(oldmodel), GetHashKey(newmodel), 1)
end)

RegisterNetEvent('qb-bankrobbery:client:fixPacificThermiteDoors', function(state)
    Config.BigBanks['pacific']['thermite'][1]['isOpened'] = state
    Config.BigBanks['pacific']['thermite'][2]['isOpened'] = state
    Config.BigBanks['pacific']['thermite'][3]['isOpened'] = state
end)