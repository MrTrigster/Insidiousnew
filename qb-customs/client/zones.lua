local QBCore = exports['qb-core']:GetCoreObject()
local textShown = false

local function listenTune1Controls()
    textShown = true
    CreateThread(function()
        while textShown do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local tunePos = bennyGarages[1].coords
            local dist = #(pos - tunePos)
            if IsPedInAnyVehicle(ped, false) then
                if not isPlyInBennys then
                    if IsControlJustReleased(1, 38) then
                        if GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
                            TriggerEvent('event:control:bennys', 1)
                        end
                    end
                else
                    disableControls()
                end
            else
                Wait(2000)
            end
            Wait(1)
        end
    end)
end

local function listenTune2Controls()
    textShown = true
    CreateThread(function()
        while textShown do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local tunePos = bennyGarages[2].coords
            local dist = #(pos - tunePos)
            if IsPedInAnyVehicle(ped, false) then
                if not isPlyInBennys then
                    if IsControlJustReleased(1, 38) then
                        if GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
                            TriggerEvent('event:control:bennys', 2)
                        end
                    end
                else
                    disableControls()
                end
            else
                Wait(2000)
            end
            Wait(1)
        end
    end)
end

CreateThread(function()
    local tuneZone = BoxZone:Create(vector3(136.01, -3030.47, 7.04), 6.0, 4.0, {
        name="tuneZone",
        heading=1,
        debugPoly=false,
        minZ=6.04,
        maxZ=9.24
    })

    tuneZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenTune1Controls()
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                exports['qb-drawtext']:DrawText('[E] - Tuuni', 'left')
            end
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local tuneZone2 = BoxZone:Create(vector3(144.97, -3030.52, 7.04), 6.0, 4.0, {
        name="tuneZone2",
        heading=0,
        debugPoly=false,
        minZ=6.04,
        maxZ=9.44
    })

    tuneZone2:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenTune2Controls()
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                exports['qb-drawtext']:DrawText('[E] - Tuuni', 'left')
            end
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)
end)