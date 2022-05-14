local QBCore = exports['qb-core']:GetCoreObject()
local firstAlarm = false
local smashing = false
local hacked = false

-- Functions

local function DrawText3Ds(x, y, z, text)
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

local function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(3)
    end
end

local function validWeapon()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.WhitelistedWeapons) do
        if pedWeapon == k then
            return true
        end
    end
    return false
end

local function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

local function smashVitrine(k)
    local animDict = "missheist_jewel"
    local animName = "smash_case"
    local ped = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
    local pedWeapon = GetSelectedPedWeapon(ped)
    if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
    elseif math.random(1, 100) <= 5 and IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
        QBCore.Functions.Notify("Sul oli kindas auk, sa jätsid sõrmejälje klaasile", "error")
    end
    smashing = true
    QBCore.Functions.Progressbar("smash_vitrine", "Korjab juveele...", Config.WhitelistedWeapons[pedWeapon]["timeOut"], false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('i13-jewellery:server:setVitrineState', "isOpened", true, k)
        TriggerServerEvent('i13-jewellery:server:setVitrineState', "isBusy", false, k)
        TriggerServerEvent('i13-jewellery:server:vitrineReward')
        if not firstAlarm then
            --TriggerServerEvent('police:server:policeJeweleryAlert', 'Juveelipoe Rööv<br>Kaamerad: 31, 32, 33, 34') --camera 31, 32, 33, 34
            -- local data = {displayCode = '10-72', description = 'Juveelipoerööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Vangelico Juveelipood'}
            -- local dispatchData = {dispatchData = data, caller = 'Poe Alarm', coords = vector3(-630.5, -237.13, 38.08)}
            -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
            exports['qb-dispatch']:VangelicoRobbery()
            TriggerServerEvent('i13-jewellery:server:log')
            TriggerServerEvent('i13-jewellery:server:setTimeout')
            firstAlarm = true
        end
        smashing = false
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end, function() -- Cancel
        TriggerServerEvent('i13-jewellery:server:setVitrineState', "isBusy", false, k)
        smashing = false
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end)
    TriggerServerEvent('i13-jewellery:server:setVitrineState', "isBusy", true, k)

    CreateThread(function()
        while smashing do
            loadAnimDict(animDict)
            TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Wait(500)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
            loadParticle()
            StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
            Wait(2500)
        end
    end)
end

-- Events

RegisterNetEvent('i13-jewellery:client:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
end)

RegisterNetEvent('i13-jewellery:client:setFirstAlarm', function(state)
    firstAlarm = state
end)

RegisterNetEvent('i13-jewellery:client:setHackStatus', function(state)
    hacked = state
    TriggerServerEvent('nui_doorlock:server:updateState', 'main_door', true, false, false, true)
end)

RegisterNetEvent('i13-jewellery:client:hackJewelery', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(status)
        if status then
            if not hacked then
                TriggerServerEvent('QBCore:Server:RemoveItem', 'electronickit', 1)
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['electronickit'], 'remove')
                QBCore.Functions.Progressbar('hack_gate', 'Ühendab seadet...', math.random(5000, 10000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = 'anim@gangops@facility@servers@',
                    anim = 'hotwire',
                    flags = 0,
                }, {}, {}, function() -- Done
                    StopAnimTask(PlayerPedId(), 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                    local minigame = exports['hackingminigame']:Open()
                    if minigame == true then
                        hacked = true
                        -- TriggerServerEvent('nui_doorlock:server:updateState', 'main_door', false, false, false, true)
                        TriggerServerEvent('i13-doorlock:server:updateState', 'vangelico_doors-vangelico_main', false, false, false, true)
                        local chance = math.random(1, 100)
                        if chance <= 25 then
                            -- local data = {displayCode = '10-72', description = 'Juveelipood', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Juveelipoe turvalukk välja lülitatud'}
                            -- local dispatchData = {dispatchData = data, caller = 'Turvasüsteem', coords = vector3(-630.5, -237.13, 38.08)}
                            -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                            exports['qb-dispatch']:VangelicoRobbery()
                        end
                        TriggerServerEvent('i13-jewellery:server:hackAlert')
                        QBCore.Functions.Notify('Turvalukk eemaldatud', 'success')
                    else
                        QBCore.Functions.Notify('Ebaõnnestus', 'error')
                    end
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                    QBCore.Functions.Notify('Katkestatud', 'error')
                end)
            else
                QBCore.Functions.Notify('Turvalukk on juba eemaldatud', 'error')
            end
        else
            QBCore.Functions.Notify('Sul on midagi puudu', 'error')
        end
    end, 'electronickit')
end)

-- Threads

CreateThread(function()
    Dealer = AddBlipForCoord(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"])

    SetBlipSprite (Dealer, 617)
    SetBlipDisplay(Dealer, 4)
    SetBlipScale  (Dealer, 0.7)
    SetBlipAsShortRange(Dealer, true)
    SetBlipColour(Dealer, 3)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Vangelico Juveelipood")
    EndTextCommandSetBlipName(Dealer)
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        inRange = false
        if LocalPlayer.state.isLoggedIn then
            PlayerData = QBCore.Functions.GetPlayerData()
            for case,_ in pairs(Config.Locations) do
                local dist = #(pos - vector3(Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"]))
                local storeDist = #(pos - vector3(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"]))
                if dist < 30 then
                    inRange = true

                    if dist < 0.6 then
                        if not Config.Locations[case]["isBusy"] and not Config.Locations[case]["isOpened"] then
                            DrawText3Ds(Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"], '[E] Lõhu Klaas')
                            if IsControlJustPressed(0, 38) then
                                QBCore.Functions.TriggerCallback('i13-jewellery:server:getCops', function(cops)
                                    if cops >= Config.RequiredCops then
                                        if validWeapon() then
                                            smashVitrine(case)
                                        else
                                            QBCore.Functions.Notify('Sul ei ole õiget relva', 'error')
                                        end
                                    else
                                        QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke, ('.. Config.RequiredCops ..') Vaja', 'error')
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end

        if not inRange then
            Wait(2000)
        end

        Wait(3)
    end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('jeweleryhack', vector3(-624.4, -243.29, 55.66), 0.4, 0.5, {
        name = 'jeweleryhack',
        heading = 28,
        debugPoly = false,
        minZ = 54.66,
        maxZ = 55.66
    }, {
        options = {
            {
                type = 'client',
                event = 'i13-jewellery:client:hackJewelery',
                icon = 'fas fa-bolt',
                label = 'Eemalda Turvalukk',
            }
        },
        distance = 1.5,
    })
end)