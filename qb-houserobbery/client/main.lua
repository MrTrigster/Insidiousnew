local QBCore = exports['qb-core']:GetCoreObject()
local inside = false
local currentHouse = nil
local closestHouse
local inRange
local lockpicking = false
local houseObj = {}
local POIOffsets = nil
local usingAdvanced = false
local requiredItemsShowed = false
local requiredItems = {}
local CurrentCops = 0
local openingDoor = false
local SucceededAttempts = 0
local NeededAttempts = 4

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

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function openHouseAnim()
    loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Wait(400)
    ClearPedTasks(PlayerPedId())
end

local function enterRobberyHouse(house)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    Wait(250)
    local coords = { x = Config.Houses[house]["coords"]["x"], y = Config.Houses[house]["coords"]["y"], z= Config.Houses[house]["coords"]["z"] - Config.MinZOffset}
    if Config.Houses[house]["tier"] == 1 then
        data = exports['qb-interior']:CreateHouseRobbery(coords)
    end
    Wait(100)
    houseObj = data[1]
    POIOffsets = data[2]
    inside = true
    currentHouse = house
    Wait(500)
    -- TriggerEvent('qb-weathersync:client:DisableSync')
    TriggerEvent('qb-weathersync:client:DisableShellSync')
end

local function leaveRobberyHouse(house)
    local ped = PlayerPedId()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    Wait(250)
    DoScreenFadeOut(250)
    Wait(500)
    exports['qb-interior']:DespawnInterior(houseObj, function()
        TriggerEvent('qb-weathersync:client:EnableSync')
        Wait(250)
        DoScreenFadeIn(250)
        SetEntityCoords(ped, Config.Houses[house]["coords"]["x"], Config.Houses[house]["coords"]["y"], Config.Houses[house]["coords"]["z"] + 0.5)
        SetEntityHeading(ped, Config.Houses[house]["coords"]["h"])
        inside = false
        currentHouse = nil
    end)
end

local function PoliceCall()
    local chance = 75
    if GetClockHours() >= 1 and GetClockHours() <= 6 then
        chance = 25
    end
    if math.random(1, 100) <= chance then
        -- local data = {displayCode = '10-72', description = 'Majarööv', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Kahtlustatav Majarööv'}
        -- local dispatchData = {dispatchData = data, caller = 'Maja Alarm', coords = GetEntityCoords(PlayerPedId())}
        -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
        exports['qb-dispatch']:HouseRobbery()
    end
end

local function LockpickDoorAnim()
    openingDoor = true
    CreateThread(function()
        while true do
            if openingDoor then
                TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            else
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                break
            end
            Wait(1000)
        end
    end)
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

local function searchCabin(cabin)
    local ped = PlayerPedId()
    if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
        local pos = GetEntityCoords(PlayerPedId())
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    LockpickDoorAnim()
    TriggerServerEvent('qb-houserobbery:server:SetBusyState', cabin, currentHouse, true)
    FreezeEntityPosition(ped, true)
    IsLockpicking = true
    local seconds = math.random(9, 14)
    local circles = math.random(3, 5)
    local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
    if success then
        openingDoor = false
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('qb-houserobbery:server:searchCabin', cabin, currentHouse)
        Config.Houses[currentHouse]["furniture"][cabin]["searched"] = true
        TriggerServerEvent('qb-houserobbery:server:SetBusyState', cabin, currentHouse, false)
        SucceededAttempts = 0
        FreezeEntityPosition(ped, false)
        SetTimeout(500, function()
            IsLockpicking = false
        end)
    else
        openingDoor = false
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('qb-houserobbery:server:SetBusyState', cabin, currentHouse, false)
        QBCore.Functions.Notify('Ebaõnnestus', "error")
        SucceededAttempts = 0
        FreezeEntityPosition(ped, false)
        SetTimeout(500, function()
            IsLockpicking = false
        end)
    end
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-houserobbery:server:GetHouseConfig', function(HouseConfig)
        Config.Houses = HouseConfig
    end)
end)

RegisterNetEvent('qb-houserobbery:client:ResetHouseState', function(house)
    Config.Houses[house]["opened"] = false
    for k, v in pairs(Config.Houses[house]["furniture"]) do
        v["searched"] = false
    end
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('qb-houserobbery:client:enterHouse', function(house)
    enterRobberyHouse(house)
end)

RegisterNetEvent('qb-houserobbery:client:setHouseState', function(house, state)
    Config.Houses[house]["opened"] = state
end)

RegisterNetEvent('qb-houserobbery:client:setCabinState', function(house, cabin, state)
    Config.Houses[house]["furniture"][cabin]["searched"] = state
end)

RegisterNetEvent('qb-houserobbery:client:SetBusyState', function(cabin, house, bool)
    Config.Houses[house]["furniture"][cabin]["isBusy"] = bool
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced)
    local hours = GetClockHours()
    if hours >= Config.MinimumTime or hours <= Config.MaximumTime then
        usingAdvanced = isAdvanced
        if usingAdvanced then
            if closestHouse ~= nil then
                if CurrentCops >= Config.MinimumHouseRobberyPolice then
                    if not Config.Houses[closestHouse]["opened"] then
                        local seconds = math.random(8, 14)
                        local circles = math.random(8, 12)
                        local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
                        if success then
                            TriggerServerEvent('qb-houserobbery:server:enterHouse', closestHouse)
                            QBCore.Functions.Notify('Muukimine õnnestus', 'success')
                            PoliceCall()
                            TriggerServerEvent('qb-durability:server:RemoveItemQuality', 5, 'advancedlockpick')
                        else
                            PoliceCall()
                            QBCore.Functions.Notify('Ebaõnnestus', "error")
                            TriggerServerEvent('qb-durability:server:RemoveItemQuality', 5, 'advancedlockpick')
                            if math.random(1, 100) <= 20 then
                                TriggerServerEvent("QBCore:Server:RemoveItem", "advancedlockpick", 1)
                                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["advancedlockpick"], "remove")
                                QBCore.Functions.Notify('Advanced Lockpick läks katki')
                            end
                        end
                        if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
                            local pos = GetEntityCoords(PlayerPedId())
                            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                        end
                    else
                        QBCore.Functions.Notify('Uks on juba avatud', "error")
                    end
                else
                    QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke', "error")
                end
            end
        else
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if closestHouse ~= nil then
                    if result then
                        if CurrentCops >= Config.MinimumHouseRobberyPolice then
                            if not Config.Houses[closestHouse]["opened"] then
                                local seconds = math.random(7, 12)
                                local circles = math.random(10, 14)
                                local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
                                if success then
                                    TriggerServerEvent('qb-houserobbery:server:enterHouse', closestHouse)
                                    QBCore.Functions.Notify('Muukimine õnnestus', 'success')
                                    PoliceCall()
                                    TriggerServerEvent('qb-durability:server:RemoveItemQuality', 5, 'lockpick')
                                else
                                    PoliceCall()
                                    QBCore.Functions.Notify('Ebaõnnestus', "error")
                                    TriggerServerEvent('qb-durability:server:RemoveItemQuality', 5, 'lockpick')
                                    if math.random(1, 100) <= 40 then
                                        TriggerServerEvent("QBCore:Server:RemoveItem", "lockpick", 1)
                                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["lockpick"], "remove")
                                        QBCore.Functions.Notify('Lockpick läks katki')
                                    end
                                end
                                if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
                                    local pos = GetEntityCoords(PlayerPedId())
                                    TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                end
                            else
                                QBCore.Functions.Notify('Uks on juba avatud', "error")
                            end
                        else
                            QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke', "error")
                        end
                    else
                        QBCore.Functions.Notify('Sul on Kruvikeerajakomplekt puudu', "error")
                    end
                end
            end, "screwdriverset")
        end
    end
end)

-- Threads

CreateThread(function()
    Wait(500)
    local alreadyInRange = false
    local text = nil
    while true do
        inRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        closestHouse = nil
        if QBCore ~= nil then
            local hours = GetClockHours()
            if hours >= Config.MinimumTime or hours <= Config.MaximumTime then
                if not inside then
                    for k, v in pairs(Config.Houses) do
                        dist = #(PlayerPos - vector3(Config.Houses[k]["coords"]["x"], Config.Houses[k]["coords"]["y"], Config.Houses[k]["coords"]["z"]))
                        if dist <= 1.5 then
                            closestHouse = k
                            if CurrentCops >= Config.MinimumHouseRobberyPolice then
                                if Config.Houses[k]["opened"] then
                                    inRange = true
                                    text = '[E] - Sisene'
                                    -- DrawText3Ds(Config.Houses[k]["coords"]["x"], Config.Houses[k]["coords"]["y"], Config.Houses[k]["coords"]["z"], '~g~E~w~ - Sisene')
                                    if IsControlJustPressed(0, 38) then
                                        enterRobberyHouse(k)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if inRange and not alreadyInRange then
                exports['qb-drawtext']:DrawText(text, 'left')
                alreadyInRange = true
            end

            if not inRange and alreadyInRange then
                exports['qb-drawtext']:HideText()
                alreadyInRange = false
            end

            if inside then 
                Wait(1000) 
            end
            if not inRange then
                Wait(1000)
            end
        end
        Wait(5)
    end
end)

CreateThread(function()
    local alreadyInRange = false
    local text = nil
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false

        if inside then
            if #(pos - vector3(Config.Houses[currentHouse]["coords"]["x"] + POIOffsets.exit.x, Config.Houses[currentHouse]["coords"]["y"] + POIOffsets.exit.y, Config.Houses[currentHouse]["coords"]["z"] - Config.MinZOffset + POIOffsets.exit.z)) < 1.5 then
                inRange = true
                text = '[E] - Välju'
                -- DrawText3Ds(Config.Houses[currentHouse]["coords"]["x"] + POIOffsets.exit.x, Config.Houses[currentHouse]["coords"]["y"] + POIOffsets.exit.y, Config.Houses[currentHouse]["coords"]["z"] - Config.MinZOffset + POIOffsets.exit.z, '~g~E~w~ - Välju')
                if IsControlJustPressed(0, 38) then
                    leaveRobberyHouse(currentHouse)
                end
            end

            for k, v in pairs(Config.Houses[currentHouse]["furniture"]) do
                if #(pos - vector3(Config.Houses[currentHouse]["coords"]["x"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["x"], Config.Houses[currentHouse]["coords"]["y"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["y"], Config.Houses[currentHouse]["coords"]["z"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["z"] - Config.MinZOffset)) < 1 then
                    if not Config.Houses[currentHouse]["furniture"][k]["searched"] then
                        if not Config.Houses[currentHouse]["furniture"][k]["isBusy"] then
                            inRange = true
                            text = '[E] - '..Config.Houses[currentHouse]["furniture"][k]["text"]
                            -- DrawText3Ds(Config.Houses[currentHouse]["coords"]["x"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["x"], Config.Houses[currentHouse]["coords"]["y"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["y"], Config.Houses[currentHouse]["coords"]["z"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["z"] - Config.MinZOffset, '~g~E~w~ - '..Config.Houses[currentHouse]["furniture"][k]["text"])
                            if not IsLockpicking then
                                if IsControlJustReleased(0, 38) then
                                    searchCabin(k)
                                end
                            end
                        else
                            DrawText3Ds(Config.Houses[currentHouse]["coords"]["x"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["x"], Config.Houses[currentHouse]["coords"]["y"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["y"], Config.Houses[currentHouse]["coords"]["z"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["z"] - Config.MinZOffset, 'Otsib..')
                        end
                    else
                        DrawText3Ds(Config.Houses[currentHouse]["coords"]["x"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["x"], Config.Houses[currentHouse]["coords"]["y"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["y"], Config.Houses[currentHouse]["coords"]["z"] + Config.Houses[currentHouse]["furniture"][k]["coords"]["z"] - Config.MinZOffset, 'Tühi..')
                    end
                end
            end
        end

        if inRange and not alreadyInRange then
            exports['qb-drawtext']:DrawText(text, 'left')
            alreadyInRange = true
        end

        if not inRange and alreadyInRange then
            exports['qb-drawtext']:HideText()
            alreadyInRange = false
        end

        if not inside then
            Wait(5000)
        end
        Wait(3)
    end
end)

-- Util Command (can be commented out - used for setting new spots in the config)

RegisterCommand('gethroffset', function()
    local coords = GetEntityCoords(PlayerPedId())
    local houseCoords = vector3(
        Config.Houses[currentHouse]["coords"]["x"],
        Config.Houses[currentHouse]["coords"]["y"],
        Config.Houses[currentHouse]["coords"]["z"] - Config.MinZOffset
    )
    if inside then
        local xdist = coords.x - houseCoords.x
        local ydist = coords.y - houseCoords.y
        local zdist = coords.z - houseCoords.z
        print('X: '..xdist)
        print('Y: '..ydist)
        print('Z: '..zdist)
    end
end)
