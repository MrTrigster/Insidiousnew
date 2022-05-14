local QBCore = exports['qb-core']:GetCoreObject()
local textShown = false

local function listenBankControls()
    textShown = true
    CreateThread(function()
        while textShown do
            if IsControlJustReleased(0, 38) then
                TriggerEvent('i13-banking:client:bank:openUI')
                textShown = false
            end
            Wait(1)
        end  
    end)
end

CreateThread(function()
    local fleeca1 = BoxZone:Create(vector3(149.45, -1040.37, 29.34), 1.0, 6.4, {
        name="fleeca1",
        heading=340,
        --debugPoly=true,
        minZ=28.34,
        maxZ=30.94
    })

    fleeca1:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenBankControls()
            exports['qb-drawtext']:DrawText('[E] - Pank', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local fleeca2 = BoxZone:Create(vector3(313.81, -278.69, 53.92), 1.0, 6.4, {
        name="fleeca2",
        heading=340,
        --debugPoly=true,
        minZ=53.12,
        maxZ=55.72
    })

    fleeca2:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenBankControls()
            exports['qb-drawtext']:DrawText('[E] - Pank', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local fleeca3 = BoxZone:Create(vector3(-351.36, -49.56, 49.04), 1.0, 6.4, {
        name="fleeca3",
        heading=341,
        --debugPoly=true,
        minZ=48.04,
        maxZ=50.64
    })

    fleeca3:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenBankControls()
            exports['qb-drawtext']:DrawText('[E] - Pank', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local fleeca4 = BoxZone:Create(vector3(-1213.17, -330.75, 37.67), 1.0, 6.4, {
        name="fleeca4",
        heading=27,
        --debugPoly=true,
        minZ=36.67,
        maxZ=39.47
    })

    fleeca4:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenBankControls()
            exports['qb-drawtext']:DrawText('[E] - Pank', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local fleeca5 = BoxZone:Create(vector3(-2962.78, 482.42, 15.69), 1.0, 6.4, {
        name="fleeca5",
        heading=268,
        --debugPoly=true,
        minZ=14.69,
        maxZ=17.29
    })

    fleeca5:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenBankControls()
            exports['qb-drawtext']:DrawText('[E] - Pank', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local fleeca6 = BoxZone:Create(vector3(1175.53, 2706.62, 38.17), 1.0, 6.4, {
        name="fleeca6",
        heading=0,
        --debugPoly=true,
        minZ=37.17,
        maxZ=39.77
    })

    fleeca6:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenBankControls()
            exports['qb-drawtext']:DrawText('[E] - Pank', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local paletoZone = BoxZone:Create(vector3(-112.84, 6469.7, 31.63), 1.0, 6.4, {
        name="paletoZone",
        heading=315,
        --debugPoly=true,
        minZ=30.63,
        maxZ=33.23
    })

    paletoZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenBankControls()
            exports['qb-drawtext']:DrawText('[E] - Pank', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local pacificZone = BoxZone:Create(vector3(247.35, 223.0, 106.29), 1.0, 4.5, {
        name="pacificZone",
        heading=340,
        --debugPoly=true,
        minZ=105.29,
        maxZ=107.89
    })

    pacificZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenBankControls()
            exports['qb-drawtext']:DrawText('[E] - Pank', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)
end)