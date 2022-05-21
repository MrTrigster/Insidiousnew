local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while true do
        Wait(Config.Wait)
        TriggerServerEvent('i13-paycheck:Register')
        print('paycheck')
    end
end)

RegisterNetEvent('i13-paycheck:targetcollect')
AddEventHandler('i13-paycheck:targetcollect', function()
    TriggerServerEvent('i13-paycheck:Collect')
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('paychecks', vector3(242.46, 225.62, 106.29), 0.4, 3.5, {
        name = 'paychecks',
        heading = 340,
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "i13-paycheck:targetcollect",
                icon = "fas fa-money-check-alt",
                label = "Võta Palgatšekk",
            },
        },           
        distance = 2.0
    })
end)

CreateThread(function()
    local pedModel = `a_m_y_business_02`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector3(241.93, 226.86, 106.29)
    local pedHeading = 158.86

    ped = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, pedHeading, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
end)