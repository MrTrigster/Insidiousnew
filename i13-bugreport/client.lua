local QBCore = exports['qb-core']:GetCoreObject()
local display = false

RegisterCommand('bug', function(source)
    SetDisplay(not display)
end)

RegisterNUICallback('main', function(data)
    SendLog(data.text)
    SetDisplay(false)
end)

RegisterNUICallback('error', function(data)
    SendError(data.error)
    SetDisplay(false)
end)

RegisterNUICallback('exit', function(data)
    SetDisplay(false)
end)

Citizen.CreateThread(function()
    local waitTime = 0
    while true do
        Citizen.Wait(waitTime)

        if display == true then
            DisableControlAction(0, 1, display) -- LookLeftRight
            DisableControlAction(0, 2, display) -- LookUpDown
            DisableControlAction(0, 142, display) -- MeleeAttackAlternate
            DisableControlAction(0, 18, display) -- Enter
            DisableControlAction(0, 322, display) -- ESC
            DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
            
            waitTime = 0
        else
            waitTime = 50
        end
    end
end)

-- Functions

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = 'ui',
        status = bool,
    })
end

function SendLog(str)
    TriggerServerEvent('bugreport:sendToLog', str)
end

function SendError(data)
    QBCore.Functions.Notify(''..data, 'error')
end