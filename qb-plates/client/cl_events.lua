local QBCore = exports['qb-core']:GetCoreObject()
local inProgress = inProgress

RegisterNetEvent('pe-fake-plate:setPlate', function(netId, originalPlate, fakePlate, plateType)
    if NetworkDoesEntityExistWithNetworkId(netId) then
        local vehicle = NetToVeh(netId)
        if fakePlate ~= nil and originalPlate ~= nil then
            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                if not inProgress then
                    inProgress = true
                    QBCore.Functions.Progressbar('set_plate', "Paigaldab numbrimärki...", math.random(4000, 10000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                        anim = "machinic_loop_mechandplayer",
                        flags = 1,
                    }, {}, {}, function()
                        if plateType == 'fake' then
                            SetVehicleNumberPlateText(vehicle, fakePlate)
                            TriggerServerEvent('plateSuccess', originalPlate, fakePlate, plateType)
                            TriggerEvent('vehiclekeys:client:SetOwner', fakePlate)
                        elseif plateType == 'return' then
                            SetVehicleNumberPlateText(vehicle, originalPlate)
                            TriggerServerEvent('plateSuccess', originalPlate, fakePlate, plateType)
                        end
                        StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                        inProgress = false
                    end, function()
                        StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                        inProgress = false
                    end)
                else
                    QBCore.Functions.Notify('Tegevus juba pooleli', 'error')
                end
            else
                QBCore.Functions.Notify('Välju enne sõidukist', 'error')
                TriggerServerEvent('pe-fake-plate:disableBool', source)
            end
        else
            print("Triggered without args")
            -- Should be impossible to do.
        end
    else
        print("Tried to access invalid network ID")
    end
end)