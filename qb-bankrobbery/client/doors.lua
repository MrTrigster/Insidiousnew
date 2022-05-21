local QBCore = exports['qb-core']:GetCoreObject()
local closestBank = nil

RegisterNetEvent('i13-bankrobbery:clearTimeoutDoors', function(bankId)
    if bankId == 'pacific' then
        local pacificDoor = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
        if pacificDoor ~= 0 then
            SetEntityHeading(pacificDoor, Config.BigBanks['pacific']['heading'].closed)
        end
        Config.BigBanks['pacific']['isOpened'] = false
    elseif bankId == 'paleto' then
        local paletoDoor = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
        if paletoDoor ~= 0 then
            SetEntityHeading(paletoDoor, Config.BigBanks['paleto']['heading'].closed)
        end
        Config.BigBanks['paleto']['isOpened'] = false
    else
        local fleecaDoor = GetClosestObjectOfType(Config.SmallBanks[bankId]['coords']['x'], Config.SmallBanks[bankId]['coords']['y'], Config.SmallBanks[bankId]['coords']['z'], 5.0, Config.SmallBanks[bankId]['object'], false, false, false)
        if fleecaDoor ~= 0 then
            SetEntityHeading(fleecaDoor, Config.SmallBanks[bankId]['heading'].closed)
        end
        Config.SmallBanks[bankId]['isOpened'] = false
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        local FleecaDist

        local PaletoDist = #(pos - Config.BigBanks['paleto']['coords'])
        local PacificDist = #(pos - Config.BigBanks['pacific']['coords'][2])
        if QBCore ~= nil then
            for k,v in pairs(Config.SmallBanks) do
                FleecaDist = #(pos - Config.SmallBanks[k]['coords'])
                if FleecaDist < 15 then
                    closestBank = k
                    inRange = true
                end
            end

            if PaletoDist < 15 then
                inRange = true
                if Config.BigBanks['paleto']['isOpened'] then
                    local paletoDoor = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
                    if paletoDoor ~= 0 then
                        SetEntityHeading(paletoDoor, Config.BigBanks['paleto']['heading'].open)
                    end
                else
                    local paletoDoor = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
                    if paletoDoor ~= 0 then
                        SetEntityHeading(paletoDoor, Config.BigBanks['paleto']['heading'].closed)
                    end
                end
            end

            if PacificDist < 50 then
                inRange = true
                if Config.BigBanks['pacific']['isOpened'] then
                    local pacificDoor = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
                    if pacificDoor ~= 0 then
                        SetEntityHeading(pacificDoor, Config.BigBanks['pacific']['heading'].open)
                    end
                else
                    local pacificDoor = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
                    if pacificDoor ~= 0 then
                        SetEntityHeading(pacificDoor, Config.BigBanks['pacific']['heading'].closed)
                    end
                end
            end

            if FleecaDist < 15 then
                inRange = true
                if Config.SmallBanks[closestBank]['isOpened'] then
                    local fleecaDoor = GetClosestObjectOfType(Config.SmallBanks[closestBank]['coords']['x'], Config.SmallBanks[closestBank]['coords']['x'], Config.SmallBanks[closestBank]['coords']['x'], 5.0, Config.SmallBanks[closestBank]['object'], false, false, false)
                    if fleecaDoor ~= 0 then
                        SetEntityHeading(fleecaDoor, Config.SmallBanks[closestBank]['heading'].open)
                    end
                else
                    local fleecaDoor = GetClosestObjectOfType(Config.SmallBanks[closestBank]['coords']['x'], Config.SmallBanks[closestBank]['coords']['x'], Config.SmallBanks[closestBank]['coords']['x'], 5.0, Config.SmallBanks[closestBank]['object'], false, false, false)
                    if fleecaDoor ~= 0 then
                        SetEntityHeading(fleecaDoor, Config.SmallBanks[closestBank]['heading'].closed)
                    end
                end
            end

            if not inRange then
                Wait(5000)
                closestBank = nil
            end
        end
        Wait(1000)
    end
end)