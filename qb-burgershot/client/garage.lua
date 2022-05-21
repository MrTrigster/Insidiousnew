PlayerData = {}
local pedspawned = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(Player)
    	PlayerData =  QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
     	PlayerData.job = job
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
	PlayerData = val
end)

-- CreateThread(function()
-- 	while true do
-- 		Wait(1000)
-- 		for k, v in pairs(Config.GaragePedLocations) do
-- 			local pos = GetEntityCoords(PlayerPedId())	
-- 			local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
			
-- 			if dist < 40 and not pedspawned then
-- 				TriggerEvent('i13-burgershot:spawn:ped', v.coords)
-- 				pedspawned = true
-- 			end
-- 			if dist >= 35 then
-- 				pedspawned = false
-- 				DeletePed(npc)
-- 			end
-- 		end
-- 	end
-- end)

-- RegisterNetEvent('i13-burgershot:spawn:ped')
-- AddEventHandler('i13-burgershot:spawn:ped',function(coords)
-- 	local hash = `ig_floyd`

-- 	RequestModel(hash)
-- 	while not HasModelLoaded(hash) do 
-- 		Wait(10)
-- 	end

--     	pedspawned = true
-- 	npc = CreatePed(5, hash, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
-- 	FreezeEntityPosition(npc, true)
--     SetEntityInvincible(npc, true)
--     SetBlockingOfNonTemporaryEvents(npc, true)
-- 	loadAnimDict("amb@world_human_cop_idles@male@idle_b") 
-- 	TaskPlayAnim(npc, "amb@world_human_cop_idles@male@idle_b", "idle_e", 8.0, 1.0, -1, 17, 0, 0, 0, 0)
-- end)

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(5)
    end
end

RegisterNetEvent('i13-burgershot:garage')
AddEventHandler('i13-burgershot:garage', function(bs)
    local vehicle = bs.vehicle
    local coords = vector4(-1172.861, -888.4072, 13.940833, 40.516719)
        if PlayerData.job.name == "burgershot" then
            if vehicle == 'stalion2' then		
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "BURGER"..tostring(math.random(1000, 9999)))
                    exports['LegacyFuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.w)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            end
        else
            QBCore.Functions.Notify('Sa ei ole Burger Shoti töötaja', 'error')
        end
end)

RegisterNetEvent('i13-burgershot:storecar')
AddEventHandler('i13-burgershot:storecar', function()
    QBCore.Functions.Notify('Töö auto garaazi pandud')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    NetworkFadeOutEntity(car, true,false)
    Wait(2000)
    QBCore.Functions.DeleteVehicle(car)
end)

RegisterNetEvent('i13-menu:BurgerShotGarage', function()
    exports['qb-menu']:openMenu({
        {
            header = "| BurgerShot Garaaz |",
            txt = ""
        },
        {
            header = "• Stallion",
            txt = "Declasse Burger Shot Stallion",
            params = {
                event = "i13-burgershot:garage",
                args = {
                    vehicle = 'stalion2',
                }
            }
        },
        {
            header = "• Pane Auto Garaazi",
            txt = "Pane Auto Tagasi Garaazi",
            params = {
                event = "i13-burgershot:storecar",
                args = {
                    
                }
            }
        },
    })
end)

-- CreateThread(function()
--     local models = {
--         'ig_floyd',
--     }
--     exports['qb-target']:AddTargetModel(models, {
--         options = {
--             {
--                 type = "client",
-- 				event = "i13-menu:BurgerShotGarage",
-- 				icon = "fas fa-car",
-- 				label = "Burgershot Garaaz",
--                 job = "burgershot",
--             }
--         },
--         distance = 2.5,
--     })
-- end)