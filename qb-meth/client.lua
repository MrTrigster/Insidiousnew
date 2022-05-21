local QBCore = exports['qb-core']:GetCoreObject()

local started = false
local progress = 0
local pause = false
local quality = 0

RegisterNetEvent('i13-methcar:stop', function()
	LastVehicle = QBCore.Functions.GetClosestVehicle()
	started = false
	progress = 0
	QBCore.Functions.Notify("Tootmine lõpetatud", "error")
	FreezeEntityPosition(LastVehicle, false)
end)

RegisterNetEvent('i13-methcar:startprod', function()
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	started = true
	pause = false
	FreezeEntityPosition(CurrentVehicle, true)
	QBCore.Functions.Notify("Alustasid tootmist", "success")
end)

RegisterNetEvent('i13-methcar:smoke', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_bzgas_smoke", posx, posy, posz + 1.6, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.9)
		Wait(60000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

-------------------------------------------------------EVENTS NEGATIVE
RegisterNetEvent('i13-methcar:boom', function()
	playerPed = (PlayerPedId())
	local pos = GetEntityCoords((PlayerPedId()))
	pause = false
	Wait(500)
	started = false
	Wait(500)
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	TriggerServerEvent('i13-methcar:blow', pos.x, pos.y, pos.z)
	TriggerEvent('i13-methcar:stop')
end)

RegisterNetEvent('i13-methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2, 15, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Wait(6000)
	StopParticleFxLooped(fire, 0)	
end)

RegisterNetEvent('i13-methcar:drugged', function()
	local pos = GetEntityCoords((PlayerPedId()))
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur((PlayerPedId()), true)
	SetPedMovementClipset((PlayerPedId()), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk((PlayerPedId()), true)
	quality = quality - 3
	pause = false
	Wait(90000)
	ClearTimecycleModifier()
	TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('i13-methcar:q-1police', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	-- local data = {displayCode = '10-37', description = 'Kahtlane Hais', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Teatati kahtlasest tossavast sõidukist'}
  	-- local dispatchData = {dispatchData = data, caller = 'Kohalik', coords = pos}
  	-- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
	exports['qb-dispatch']:CookingMeth()
	-- TriggerServerEvent('police:server:policeAlert', 'Person reports stange smell!')
	TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('i13-methcar:q-1', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('i13-methcar:q-3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 3
	pause = false
	TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('i13-methcar:q-5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 5
	pause = false
	TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('i13-methcar:q5shit', function()
	local pos = GetEntityCoords((PlayerPedId()))
	local chance = math.random(1, 100)
	if chance >= 50 then
		QBCore.Functions.Notify('Suutsid kinni hoida', "success")
		quality = quality + 5
		pause = false
		TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
	else
		QBCore.Functions.Notify('Sa ei suutnud sitta kinni hoida ja läksid õue sitale', "error")
		quality = quality - 5
		pause = false
	-- 	local data = {displayCode = '10-37', description = 'Kahtlane Hais', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Teatati kahtlasest tossavast sõidukist'}
  	-- 	local dispatchData = {dispatchData = data, caller = 'Kohalik', coords = pos}
  	-- 	TriggerServerEvent('wf-alerts:svNotify', dispatchData)
	  	exports['qb-dispatch']:CookingMeth()
		TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
	end
end)

-------------------------------------------------------EVENTS POSITIVE
RegisterNetEvent('i13-methcar:q2', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 2
	pause = false
	TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('i13-methcar:q3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 3
	pause = false
	TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('i13-methcar:q5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('i13-methcar:gasmask', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	SetPedPropIndex(playerPed, 1, 26, 7, true)
	quality = quality + 2
	pause = false
	TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('i13-methcar:cook', function()
	local pos = GetEntityCoords((PlayerPedId()))
	playerPed = (PlayerPedId())
	local CurrentVehicle = QBCore.Functions.GetClosestVehicle()
	if IsVehicleSeatFree(CurrentVehicle, 3) and IsVehicleSeatFree(CurrentVehicle, -1) and IsVehicleSeatFree(CurrentVehicle, 0) and IsVehicleSeatFree(CurrentVehicle, 1)and IsVehicleSeatFree(CurrentVehicle, 2) then
		TaskWarpPedIntoVehicle(PlayerPedId(), CurrentVehicle, 3)
		SetVehicleDoorOpen(CurrentVehicle, 2)
		Wait(300)
		TriggerServerEvent('i13-methcar:start')
		TriggerServerEvent('i13-methcar:make', pos.x,pos.y,pos.z)
		TriggerEvent("evidence:client:SetStatus", "chemicals", 300)
		Wait(1000)
		quality = 0
	else
		QBCore.Functions.Notify('Keegi on autos sees', "error")
	end
end)

---------EVENTS------------------------------------------------------

RegisterNetEvent('i13-methcar:proses', function()
	--
	--   EVENT 1
	--
	if progress > 9 and progress < 11 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Gaasitoru lekib, mida sa teed?",
				txt = "Vali variant all. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Paranda Teibiga",
				params = {
					event = "i13-methcar:q-3",
					args = {
						message = "See vist aitas, ma arvan?!"
					}
				}
			},
			{
				header = "🔴 Ära Tee Midagi",
				params = {
					event = "i13-methcar:boom"
				}
			},
			{
				header = "🔴 Vaheta Toru",
				params = {
					event = "i13-methcar:q5",
					args = {
						message = "Vahetamine oli parim valik"
					}
				}
			},
		})
	end
	--
	--   EVENT 2
	--
	if progress > 19 and progress < 21 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Sa kallasid kogemata atsetooni põrandale, mida sa teed?",
				txt = "Vali vastus all. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Ava Aken",
				params = {
					event = "i13-methcar:q-1police",
					args = {
						message = "Tegid akna lahti, auto ümbrus haiseb"
					}
				}
			},
			{
				header = "🔴 Hinga Sisse",
				params = {
					event = "i13-methcar:drugged"
				}
			},
			{
				header = "🔴 Pane Gaasimask Pähe",
				params = {
					event = "i13-methcar:gasmask",
					args = {
						message = "Hea valik"
					}
				}
			},
		})
	end
	--
	--   EVENT 3
	--
	if progress > 29 and progress < 31 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Tootmine läheb liiga kiirelt, mida sa teed?",
				txt = "Vali vastus all. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Tõsta Temperatuuri",
				params = {
					event = "i13-methcar:q5",
					args = {
						message = "Kõrgem temperatuur tekitas ideaalse tasakaalu!"
					}
				}
			},
			{
				header = "🔴 Tõsta Survet",
				params = {
					event = "i13-methcar:q-3",
					args = {
						message = "Surve kõikus rohkelt"
					}
				}
			},
			{
				header = "🔴 Langeta Survet",
				params = {
					event = "i13-methcar:q-5",
					args = {
						message = "See oli kõige halvem otsus"
					}
				}
			},
		})
	end
	--
	--   EVENT 4
	--
	if progress > 39 and progress < 41 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Sa lisasid liiga palju atsetooni, mida sa teed?",
				txt = "Vali vastus all. Progres: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Ära Tee Midagi",
				params = {
					event = "i13-methcar:q-5",
					args = {
						message = "Meth haiseb nagu puhas atsetoon"
					}
				}
			},
			{
				header = "🔴 Kasuta Kõrt, Et See Välja Imeda",
				params = {
					event = "i13-methcar:drugged"
				}
			},
			{
				header = "🔴 Lisa Liitiumi Sabiliseerimiseks",
				params = {
					event = "i13-methcar:q5",
					args = {
						message = "Tark otsus!"
					}
				}
			},
		})
	end
	--
	--   EVENT 5
	--
	if progress > 49 and progress < 51 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Sa leidsid sinist värvi, kas lisad selle?",
				txt = "Vali vastus all. Progres: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Lisa värvi",
				params = {
					event = "i13-methcar:q5",
					args = {
						message = "Inimestele kindlasti meeldib see!"
					}
				}
			},
			{
				header = "🔴 Pane ära",
				params = {
					event = "i13-methcar:q-1",
					args = {
						message = "Sa ei ole väga loov, ega ju?"
					}
				}
			},
		})
	end
	--
	--   EVENT 6
	--
	if progress > 59 and progress < 61 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Filter on sitane, mida sa teed?",
				txt = "Vali vastus all. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Puhu See Kompressoriga Välja",
				params = {
					event = "i13-methcar:q-5",
					args = {
						message = "Seda paska läks igalepoole"
					}
				}
			},
			{
				header = "🔴 Vaheta Filter",
				params = {
					event = "i13-methcar:q5",
					args = {
						message = "Vahetamine oli kõige targem otsus!"
					}
				}
			},
			{
				header = "🔴 Puhasta Seda Harjaga",
				params = {
					event = "i13-methcar:q-1",
					args = {
						message = "See aitas, aga mitte väga"
					}
				}
			},
		})
	end
	--
	--   EVENT 7
	--
	if progress > 69 and progress < 71 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Sa kallasid kogemata atsetooni põrandale, mida sa teed?",
				txt = "Vali vastus all. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Hinga Sisse",
				params = {
					event = "i13-methcar:drugged"
				}
			},
			{
				header = "🔴 Pane Gaasimask pähe",
				params = {
					event = "i13-methcar:gasmask",
					args = {
						message = "Tark otsus"
					}
				}
			},
			{
				header = "🔴 Ava Aken",
				params = {
					event = "i13-methcar:q-1police",
					args = {
						message = "Tegid akna lahti, auto ümbrus haiseb"
					}
				}
			},
		})
	end
	--
	--   EVENT 8
	--
	if progress > 79 and progress < 81 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Gaasitoru lekib, mida sa teed?",
				txt = "Vali vastus all. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Ära Tee Midagi",
				params = {
					event = "i13-methcar:boom"
				}
			},
			{
				header = "🔴 Paranda Teibiga",
				params = {
					event = "i13-methcar:q-3",
					args = {
						message = "See vist aitas, ma arvan?!"
					}
				}
			},
			{
				header = "🔴 Vaheta Toru",
				params = {
					event = "i13-methcar:q5",
					args = {
						message = "Vahetamine oli parim valik"
					}
				}
			},
		})
	end
	--
	--   EVENT 9
	--
	if progress > 89 and progress < 91 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Sul on räige sitahäda, mida sa teed?",
				txt = "Vali vastus all. Progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Ürita Kinni Hoida",
				params = {
					event = "i13-methcar:q5shit",
				}
			},
			{
				header = "🔴 Mine Välja Sitale",
				params = {
					event = "i13-methcar:q-1police",
					args = {
						message = "Keegi nägi sind"
					}
				}
			},
			{
				header = "🔴 Situ Sisse",
				params = {
					event = "i13-methcar:q-5",
					args = {
						message = "Kõik haiseb sita järele!"
					}
				}
			},
		})
	end
	--
	--   DONE
	--	
	if progress > 99 and progress < 101 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Valmis!",
				txt = "" .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "🔴 Pakenda Meth",
				params = {
					event = "i13-methcar:done",
					args = {
						message = ""
					}
				}
			}
		})
	end
end)

RegisterNetEvent('i13-methcar:done', function()
	quality = quality + 5
	started = false
	TriggerEvent('i13-methcar:stop')
	TriggerServerEvent('i13-methcar:finish', quality)
	SetPedPropIndex(playerPed, 1, 0, 0, true)
end)

-----THREADS------------------------------------------------------------------------------

CreateThread(function()
	while true do
		Wait(250)
		if started == true then
			if pause == false and IsPedInAnyVehicle(playerPed) then
				Wait(250)
				progress = progress +  1
				quality = quality + 1
				QBCore.Functions.Notify('Tootmine: ' .. progress .. '%')
				TriggerEvent('i13-methcar:proses')
				Wait(2000)
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(1000)
		if IsPedInAnyVehicle((PlayerPedId())) then
		else
			if started then
				playerPed = (PlayerPedId())
				CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
				pause = true
				started = false
				TriggerEvent('i13-methcar:stop')
				SetPedPropIndex(playerPed, 1, 0, 0, true)
				FreezeEntityPosition(CurrentVehicle, false)
			end
		end
	end
end)

CreateThread(function()
	exports['qb-target']:AddBoxZone('methShop', vector3(457.58, 5571.94, 781.18), 0.8, 3.0, {
		name = 'methShop',
		heading = 90,
		debugPoly = false,
		minZ = 780.18,
		maxZ = 783.58
	}, {
		options = {
			{
				type = 'client',
				event = 'i13-shops:client:OpenMethShop',
				label = 'Osta Asju',
				icon = 'fas fa-flask',
			}
		},
		distance = 1.5,
	})
end)