local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while true do
        if QBCore ~= nil then
            Wait(Config.Interval * 60000)
            TriggerServerEvent("i13-durability:server:ItemQuality")
        end
    end
end)