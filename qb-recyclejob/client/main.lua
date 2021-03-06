local QBCore = exports['qb-core']:GetCoreObject()
local carryPackage = nil
local packagePos = nil
local onDuty = false
local shopPeds = {}

-- Functions

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function ScrapAnim()
    local time = 5
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end

local function DrawText3D(x, y, z, text)
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

local function GetRandomPackage()
    local randSeed = math.random(1, #Config["delivery"].pickupLocations)
    packagePos = {}
    packagePos.x = Config["delivery"].pickupLocations[randSeed].x
    packagePos.y = Config["delivery"].pickupLocations[randSeed].y
    packagePos.z = Config["delivery"].pickupLocations[randSeed].z
end

local function PickupPackage()
    local pos = GetEntityCoords(PlayerPedId(), true)
    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Wait(7)
    end
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    local model = `prop_cs_cardbox_01`
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    local object = CreateObject(model, pos.x, pos.y, pos.z, true, true, true)
    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
    carryPackage = object
end

local function DropPackage()
    ClearPedTasks(PlayerPedId())
    DetachEntity(carryPackage, true, true)
    DeleteObject(carryPackage)
    carryPackage = nil
end

-- Threads

CreateThread(function()
    local alreadyInRange = false
    local text = nil

    local RecycleBlip = AddBlipForCoord(Config['delivery'].outsideLocation.x, Config['delivery'].outsideLocation.y, Config['delivery'].outsideLocation.z)
    SetBlipSprite(RecycleBlip, 365)
    SetBlipColour(RecycleBlip, 2)
    SetBlipScale(RecycleBlip, 0.8)
    SetBlipAsShortRange(RecycleBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Taaskasutuskeskus")
    EndTextCommandSetBlipName(RecycleBlip)


    local RecyclingSeller = AddBlipForCoord(-572.46, -1632.74, 19.41)
    SetBlipSprite (RecyclingSeller, 365)
    SetBlipColour(RecyclingSeller, 2)
    SetBlipScale  (RecyclingSeller, 0.8)
    SetBlipAsShortRange(RecyclingSeller, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Materjalide Kaupmees")
    EndTextCommandSetBlipName(RecyclingSeller)

    while true do
        Wait(0)
        local inRange = false
        local pos = GetEntityCoords(PlayerPedId(), true)

        if #(pos - vector3(Config['delivery'].outsideLocation.x, Config['delivery'].outsideLocation.y, Config['delivery'].outsideLocation.z)) < 1.3 then
            -- DrawText3D(Config['delivery'].outsideLocation.x, Config['delivery'].outsideLocation.y, Config['delivery'].outsideLocation.z + 1, "~g~E~w~ - To Enter")
            text = '[E] - Sisene Taaskasutuskeskusesse'
            inRange = true
            if IsControlJustReleased(0, 38) then
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Config['delivery'].insideLocation.x, Config['delivery'].insideLocation.y, Config['delivery'].insideLocation.z)
                DoScreenFadeIn(500)
            end
        end

		if #(pos - vector3(Config['delivery'].insideLocation.x, Config['delivery'].insideLocation.y, Config['delivery'].insideLocation.z)) < 1.3 then
			-- DrawText3D(Config['delivery'].insideLocation.x, Config['delivery'].insideLocation.y, Config['delivery'].insideLocation.z + 1, "~g~E~w~ - To Go Outside")
            text = '[E] - Mine V??lja'
            inRange = true
			if IsControlJustReleased(0, 38) then
				DoScreenFadeOut(500)
				while not IsScreenFadedOut() do
					Wait(10)
				end
				SetEntityCoords(PlayerPedId(), Config['delivery'].outsideLocation.x, Config['delivery'].outsideLocation.y, Config['delivery'].outsideLocation.z + 1)
				DoScreenFadeIn(500)
			end
		end

        -- if #(pos - vector3(1049.15, -3100.63, -39.95)) < 15 and not IsPedInAnyVehicle(PlayerPedId(), false) and carryPackage == nil then
        --     DrawMarker(2, 1049.15, -3100.63, -39.20, 0.9, 0, 0, 0, 0, 0, 0.2001, 0.2001, 0.2001, 255, 255, 255, 255, 0, 0, 0, 0)
        --     if #(pos - vector3(1049.15, -3100.63, -39.95)) < 1.3 then
        --         if onDuty then
        --             DrawText3D(1049.15, -3100.63, -38.95, "~g~E~w~ - Clock Out")
        --         else
        --             DrawText3D(1049.15, -3100.63, -38.95, "~g~E~w~ -  Clock In")
        --         end
        --         if IsControlJustReleased(0, 38) then
        --             onDuty = not onDuty
        --             if onDuty then
        --                 QBCore.Functions.Notify("You Have Been Clocked In", "success")
        --             else
        --                 QBCore.Functions.Notify("You Have Clocked Out", "error")
        --             end
        --         end
        --     end
        -- end

        if inRange and not alreadyInRange then
            exports['qb-drawtext']:DrawText(text, 'left')
            alreadyInRange = true
        end

        if not inRange and alreadyInRange then
            exports['qb-drawtext']:HideText()
            alreadyInRange = false
        end
    end
end)

CreateThread(function()
    local alreadyInRange = false
    local text = nil

    for k, pickuploc in pairs(Config['delivery'].pickupLocations) do
        local model = GetHashKey(Config['delivery'].warehouseObjects[math.random(1, #Config['delivery'].warehouseObjects)])
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(0) end
        local obj = CreateObject(model, pickuploc.x, pickuploc.y, pickuploc.z, false, true, true)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
    end

    while true do
        Wait(5)
        local inRange = false
        if onDuty then
            if packagePos ~= nil then
                local pos = GetEntityCoords(PlayerPedId(), true)
                if carryPackage == nil then
                    if #(pos - vector3(packagePos.x, packagePos.y, packagePos.z)) < 2.3 then
                        -- DrawText3D(packagePos.x,packagePos.y,packagePos.z+ 1, "~g~E~w~ - Pack Package")
                        text = '[E] - V??ta Pakk'
                        inRange = true
                        if IsControlJustReleased(0, 38) then
                            QBCore.Functions.Progressbar("pickup_reycle_package", "V??tab pakki...", Config.PickupTime, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function()
                                ClearPedTasks(PlayerPedId())
                                PickupPackage()
                            end)
                        end
                    else
                        DrawText3D(packagePos.x, packagePos.y, packagePos.z + 1, "Pakk")
                    end
                else
                    if #(pos - vector3(Config['delivery'].dropLocation.x, Config['delivery'].dropLocation.y, Config['delivery'].dropLocation.z)) < 2.0 then
                        -- DrawText3D(Config['delivery'].dropLocation.x, Config['delivery'].dropLocation.y, Config['delivery'].dropLocation.z, "~g~E~w~ - Anna Pakk ??le")
                        text = '[E] - Anna Pakk ??le'
                        inRange = true
                        if IsControlJustReleased(0, 38) then
                            DropPackage()
                            ScrapAnim()
                            QBCore.Functions.Progressbar("deliver_reycle_package", "Pakib lahti...", Config.TurnInTime, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                                TriggerServerEvent('i13-recycle:server:getItem')
                                GetRandomPackage()
                            end)
                        end
                    else
                        DrawText3D(Config['delivery'].dropLocation.x, Config['delivery'].dropLocation.y, Config['delivery'].dropLocation.z, "Anna ??le")
                    end
                end
            else
                GetRandomPackage()
            end

            if inRange and not alreadyInRange then
                exports['qb-drawtext']:DrawText(text, 'left')
                alreadyInRange = true
            end

            if not inRange and alreadyInRange then
                exports['qb-drawtext']:HideText()
                alreadyInRange = false
            end
        end
    end
end)

CreateThread(function()
    local pedModel = `s_m_y_xmech_02`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local loc = vector4(-572.4, -1632.1, 19.41, 168.63)

    recyclePed = CreatePed(4, pedModel, loc.x, loc.y, loc.z - 1, loc.w, false, true)
    FreezeEntityPosition(recyclePed, true)
    SetEntityInvincible(recyclePed, true)
    SetBlockingOfNonTemporaryEvents(recyclePed, true)

	exports['qb-target']:AddTargetEntity(recyclePed, { 
        options = {
            { 
                event = "i13-recyclejob:SellItems", 
                icon = "fas fa-certificate", 
                label = "Vaheta Materjale", 
            },	
        },
		distance = 2.0,
	})

    exports['qb-target']:AddBoxZone('recycleDuty', vector3(1048.37, -3100.66, -39.0), 0.5, 0.5, {
        name = 'recycleDuty',
        heading = 0,
        debugPoly = false,
        minZ = -39.4,
        maxZ = -38.7
    }, {
        options = {
            {
                type = 'client',
                event = 'i13-recyclejob:client:toggleDuty',
                label = 'Alusta/L??peta T????tamine',
                icon = 'fas fa-clipboard',
            }
        },
        distance = 2.0,
    })
end)

RegisterNetEvent('i13-recyclejob:client:toggleDuty', function()
    onDuty = not onDuty
    if onDuty then
        QBCore.Functions.Notify("Kirjutasid ennast t????le", "success")
    else
        QBCore.Functions.Notify("Kirjutasid ennast t????lt v??lja", "success")
    end
end)

RegisterNetEvent('i13-recyclejob:SellAll')
AddEventHandler('i13-recyclejob:SellAll', function(data)
	if data == -2 then
		exports['qb-menu']:closeMenu()
		return
	end
    QBCore.Functions.Progressbar("trade_materials", "Vahetab materjale...", Config.TradeAllTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('i13-recyclejob:SellAll', data)
    end)
	TriggerEvent('i13-recycle:SellItems')
end)

RegisterNetEvent('i13-recyclejob:SellOne')
AddEventHandler('i13-recyclejob:SellOne', function(data)
	if data == -2 then
		exports['qb-menu']:closeMenu()
		return
	end
    QBCore.Functions.Progressbar("trade_materials2", "Vahetab materjale...", Config.TradeOneTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('i13-recyclejob:SellOne', data)
    end)
	TriggerEvent('i13-recycle:SellItems')
end)

-- MENUS - SELL ITEMS MENU
RegisterNetEvent('i13-recyclejob:SellItems', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "Vaheta siin materjale", isMenuHeader = true }, 
		{ header = "??? Sulge", txt = "", params = { event = "i13-recycle:Sell", args = -2 } },
		{ header = "Metal Scrap", txt = "", params = { event = "i13-recyclejob:SellItems:MetalScrap", } },
        { header = "Raud", txt = "", params = { event = "i13-recyclejob:SellItems:Iron", } },
        { header = "Teras", txt = "", params = { event = "i13-recyclejob:SellItems:Steel", } },
        { header = "Alumiinium", txt = "", params = { event = "i13-recyclejob:SellItems:Aluminum", } },
        { header = "Vask", txt = "", params = { event = "i13-recyclejob:SellItems:Copper", } },
        { header = "Plastik", txt = "", params = { event = "i13-recyclejob:SellItems:Plastic", } },
        { header = "Klaas", txt = "", params = { event = "i13-recyclejob:SellItems:Glass", } },
        { header = "Kumm", txt = "", params = { event = "i13-recyclejob:SellItems:Rubber", } },
        { header = "M???? Sularaha Vastu", txt = "", params = { event = "i13-recyclejob:SellItems:Cash", } },
	})
end)
-- METAL SCRAP
RegisterNetEvent('i13-recyclejob:SellItems:MetalScrap', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "Vaheta Metal Scrap'i vastu", isMenuHeader = true }, 
		{ header = "", txt = "??? Tagasi", params = { event = "i13-recyclejob:SellItems", } },
        { header = "Metal Scrap", txt = "Vahet K??IK Metal Scrap'i vastu", params = { event = "i13-recyclejob:SellAll", args = 1 } },
		{ header = "Metal Scrap", txt = "Vaheta ??KS "..Config.ItemPrices["metalscrap"].price.. " Metal Scrap'i vastu", params = { event = "i13-recyclejob:SellOne", args = 2 } },
	})
end)
-- IRON
RegisterNetEvent('i13-recyclejob:SellItems:Iron', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "Vaheta Raua vastu", isMenuHeader = true }, 
		{ header = "", txt = "??? Tagasi", params = { event = "i13-recyclejob:SellItems", } },
        { header = "Raud", txt = "Vaheta K??IK Raua vastu", params = { event = "i13-recyclejob:SellAll", args = 3 } },
		{ header = "Raud", txt = "Vaheta ??KS "..Config.ItemPrices["iron"].price.. " Raua vastu", params = { event = "i13-recyclejob:SellOne", args = 4 } },
	})
end)
-- STEEL
RegisterNetEvent('i13-recyclejob:SellItems:Steel', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "Vaheta Terase vastu", isMenuHeader = true }, 
		{ header = "", txt = "??? Tagasi", params = { event = "i13-recyclejob:SellItems", } },
        { header = "Teras", txt = "Vaheta K??IK Terase vastu", params = { event = "i13-recyclejob:SellAll", args = 5 } },
		{ header = "Teras", txt = "Vaheta ??KS "..Config.ItemPrices["steel"].price.. " Terase vastu", params = { event = "i13-recyclejob:SellOne", args = 6 } },
	})
end)
-- ALUMINUM
RegisterNetEvent('i13-recyclejob:SellItems:Aluminum', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "Vaheta Alumiiniumi vastu", isMenuHeader = true }, 
		{ header = "", txt = "??? Tagasi", params = { event = "i13-recyclejob:SellItems", } },
        { header = "Alumiinium", txt = "Vaheta K??IK Alumiiniumi vastu", params = { event = "i13-recyclejob:SellAll", args = 7 } },
		{ header = "Alumiinium", txt = "Vaheta ??KS "..Config.ItemPrices["aluminum"].price.. " Alumiinium vastu", params = { event = "i13-recyclejob:SellOne", args = 8 } },
	})
end)
-- COPPER
RegisterNetEvent('i13-recyclejob:SellItems:Copper', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "Vaheta Vase vastu", isMenuHeader = true }, 
		{ header = "", txt = "??? Tagasi", params = { event = "i13-recyclejob:SellItems", } },
        { header = "Vask", txt = "Vaheta K??IK Vase vastu", params = { event = "i13-recyclejob:SellAll", args = 9 } },
		{ header = "Vask", txt = "Vaheta ??KS "..Config.ItemPrices["copper"].price.. " Vase vastu", params = { event = "i13-recyclejob:SellOne", args = 10 } },
	})
end)
-- PLASTIC
RegisterNetEvent('i13-recyclejob:SellItems:Plastic', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "Vaheta Plastiku vastu", isMenuHeader = true }, 
		{ header = "", txt = "??? Tagasi", params = { event = "i13-recyclejob:SellItems", } },
        { header = "Plastik", txt = "Vaheta K??IK Plastiku vastu", params = { event = "i13-recyclejob:SellAll", args = 11 } },
		{ header = "Plastik", txt = "Vaheta ??KS "..Config.ItemPrices["plastic"].price.. " Plastiku vastu", params = { event = "i13-recyclejob:SellOne", args = 12 } },
	})
end)
-- GLASS
RegisterNetEvent('i13-recyclejob:SellItems:Glass', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "Vaheta Klaasi vastu", isMenuHeader = true }, 
		{ header = "", txt = "??? Tagasi", params = { event = "i13-recyclejob:SellItems", } },
        { header = "Klaas", txt = "Vaheta K??IK Klaasi vastu", params = { event = "i13-recyclejob:SellAll", args = 13 } },
		{ header = "Klaas", txt = "Vaheta ??KS "..Config.ItemPrices["glass"].price.. " Klaasi vastu", params = { event = "i13-recyclejob:SellOne", args = 14 } },
	})
end)
-- RUBBER
RegisterNetEvent('i13-recyclejob:SellItems:Rubber', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "Vaheta Kummi vastu", isMenuHeader = true }, 
		{ header = "", txt = "??? Tagasi", params = { event = "i13-recyclejob:SellItems", } },
        { header = "Kumm", txt = "Vaheta K??IK Kummi vastu", params = { event = "i13-recyclejob:SellAll", args = 15 } },
		{ header = "Kumm", txt = "Vaheta ??KS "..Config.ItemPrices["rubber"].price.. " Kummi vastu", params = { event = "i13-recyclejob:SellOne", args = 16 } },
	})
end)
-- CASH
RegisterNetEvent('i13-recyclejob:SellItems:Cash', function()
    exports['qb-menu']:openMenu({
		{ header = "Materjalide Vahetus", txt = "M???? Materjale Sularaha vastu", isMenuHeader = true }, 
		{ header = "", txt = "??? Tagasi", params = { event = "i13-recyclejob:SellItems", } },
        { header = "Sularaha", txt = "M???? K??IK Materjalid Sularaha vastu", params = { event = "i13-recyclejob:SellAll", args = 17 } },
	})
end)