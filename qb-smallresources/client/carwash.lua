local QBCore = exports['qb-core']:GetCoreObject()

local washingVehicle = false

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

RegisterNetEvent('i13-carwash:client:washCar', function()
    local PlayerPed = PlayerPedId()
    local PedVehicle = GetVehiclePedIsIn(PlayerPed)
    washingVehicle = true
    QBCore.Functions.Progressbar("search_cabin", "Autot pestakse...", math.random(4000, 8000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        SetVehicleDirtLevel(PedVehicle)
        SetVehicleUndriveable(PedVehicle, false)
        WashDecalsFromVehicle(PedVehicle, 1.0)
        washingVehicle = false
    end, function() -- Cancel
        QBCore.Functions.Notify("Pesemine Katkestatud", "error")
        washingVehicle = false
    end)
end)

CreateThread(function()
    local alreadyInRange = false
    local text = nil
    while true do
        local inRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        local PedVehicle = GetVehiclePedIsIn(PlayerPed)
        local Driver = GetPedInVehicleSeat(PedVehicle, -1)
        local dirtLevel = GetVehicleDirtLevel(PedVehicle)
        if IsPedInAnyVehicle(PlayerPed) then
            for k, v in pairs(Config.CarWash) do
                local dist = #(PlayerPos - vector3(Config.CarWash[k]["coords"]["x"], Config.CarWash[k]["coords"]["y"], Config.CarWash[k]["coords"]["z"]))
                if dist <= 10 then
                    -- inRange = true
                    if dist <= 7.5 then
                        if Driver == PlayerPed then
                            if not washingVehicle then
                                text = '[E] - Autopesula ($'..Config.DefaultPrice..')'
                                inRange = true
                                -- DrawText3Ds(Config.CarWash[k]["coords"]["x"], Config.CarWash[k]["coords"]["y"], Config.CarWash[k]["coords"]["z"], '~g~E~w~ - Autopesula ($'..Config.DefaultPrice..')')
                                if IsControlJustPressed(0, 38) then
                                    if dirtLevel > Config.DirtLevel then
                                        TriggerServerEvent('i13-carwash:server:washCar')
                                    else
                                        QBCore.Functions.Notify("Auto on juba puhas", 'error')
                                    end
                                end
                            else
                                DrawText3Ds(Config.CarWash[k]["coords"]["x"], Config.CarWash[k]["coords"]["y"], Config.CarWash[k]["coords"]["z"], 'Autopesula ei ole saadaval')
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

        if not inRange then
            Wait(5000)
        end
        Wait(3)
    end
end)

CreateThread(function()
    for k, v in pairs(Config.CarWash) do
        carWash = AddBlipForCoord(Config.CarWash[k]["coords"]["x"], Config.CarWash[k]["coords"]["y"], Config.CarWash[k]["coords"]["z"])
        SetBlipSprite (carWash, 100)
        SetBlipDisplay(carWash, 4)
        SetBlipScale  (carWash, 0.75)
        SetBlipAsShortRange(carWash, true)
        SetBlipColour(carWash, 37)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.CarWash[k]["label"])
        EndTextCommandSetBlipName(carWash)
    end
end) 