QBCore = exports['qb-core']:GetCoreObject()

-------------
-- Variables --
-------------
local src = source
local CurrentTest = nil
local LastCheckPoint = -1
local CurrentCheckPoint = 0
local CurrentZoneType   = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    Player = QBCore.Functions.GetPlayerData()
end)

-- Opens qb-menu to select dmv options
function OpenMenu()
    exports['qb-menu']:openMenu({
      {
        header = "Autokool",
        isMenuHeader = true,
      },
      {
        header = "Teooria Test",
        txt = "Alusta teooria test $"..Config.Amount['theoretical'].."",
        params = {
          event = 'i13-dmv:startquiz',
          args = {
            CurrentTest = 'theory'
          }
        }
      }
    })
end

function OpenMenu2()
  exports['qb-menu']:openMenu({
    {
      header = "Autokool",
      isMenuHeader = true,
    },
    {
      header = "Sõidueksam",
      txt = "Alusta sõidueksam $"..Config.Amount['driving'].."",
      params = {
        event = 'i13-dmv:startdriver',
        args = {
          CurrentTest = 'drive'
        }
      }
    },
  })
end

RegisterNetEvent('i13-dmv:drivingSchoolMenu', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local licenseMeta = PlayerData.metadata['licences']
    local permitMeta = PlayerData.metadata['licencepermit']
    if permitMeta['permit'] == true and licenseMeta['driver'] == false then
        OpenMenu2()
    elseif permitMeta['permit'] == false and licenseMeta['driver'] == false then
        OpenMenu()
    else
        QBCore.Functions.Notify('Sa oled eksamid juba sooritanud', 'error')
    end
end)

-- Event to put in qb-menu to start driving test
RegisterNetEvent('i13-dmv:startdriver', function()
        CurrentTest = 'drive'
        DriveErrors = 0
        LastCheckPoint = -1
        CurrentCheckPoint = 0
        IsAboveSpeedLimit = false
        CurrentZoneType = 'residence'
        local prevCoords = GetEntityCoords(PlayerPedId())
        QBCore.Functions.SpawnVehicle(Config.VehicleModels.driver, function(veh)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            exports['LegacyFuel']:SetFuel(veh, 100)
            SetVehicleNumberPlateText(veh, 'AUTOKOOL')
            SetEntityAsMissionEntity(veh, true, true)
            SetEntityHeading(veh, Config.Location['spawn'].w)
            TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
            TriggerServerEvent('i13-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
            LastVehicleHealth = GetVehicleBodyHealth(veh)
            CurrentVehicle = veh
            QBCore.Functions.Notify('Alustasid sõidueksamit')
        end, Config.Location['spawn'], false)
end)



-- Event for qb-menu to run to start quiz
RegisterNetEvent('i13-dmv:startquiz')
AddEventHandler('i13-dmv:startquiz', function ()
    CurrentTest = 'theory'
    SendNUIMessage({
      Wait(10),
      openQuestion = true
    })

    SetTimeout(200, function ()
        SetNuiFocus(true, true)
    end)

end)

-- When stopping/finishing theoritical test
function StopTheoryTest(success) 
    CurrentTest = nil
    SendNUIMessage({
      openQuestion = false
    })
    SetNuiFocus(false)
    if success then
      QBCore.Functions.Notify('Sa läbisid teooriaeksami', 'success')
      TriggerServerEvent('i13-dmv:theorypaymentpassed')
    else
      QBCore.Functions.Notify('Sa kukkusid läbi', 'error')
      TriggerServerEvent('i13-dmv:theorypaymentfailed')
    end
end

--Stop Drive Test
function StopDriveTest(success)
    local playerPed = PlayerPedId()
    local veh = GetVehiclePedIsIn(playerPed)
    if success then
      TriggerServerEvent('i13-dmv:driverpaymentpassed')
      QBCore.Functions.Notify('sa läbisid sõidueksami', 'success')
      QBCore.Functions.DeleteVehicle(veh)
      CurrentTest = nil
    elseif success == false then
      TriggerServerEvent('i13-dmv:driverpaymentfailed')
      QBCore.Functions.Notify('Sa kukkusid läbi', 'error')
      CurrentTest = nil
      RemoveBlip(CurrentBlip)
      QBCore.Functions.DeleteVehicle(veh)
      Wait(1000)
      SetEntityCoords(playerPed, Config.Location['marker'].x+1, Config.Location['marker'].y+1, Config.Location['marker'].z)
    end
  
    CurrentTest     = nil
    CurrentTestType = nil
  
  end

-- Drive test
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    if CurrentTest == 'drive' then
      local marker = Config.Location['marker']
      local playerPed      = PlayerPedId()
      local coords         = GetEntityCoords(playerPed)
      local nextCheckPoint = CurrentCheckPoint + 1
      if Config.CheckPoints[nextCheckPoint] == nil then
        if DoesBlipExist(CurrentBlip) then
          RemoveBlip(CurrentBlip)
        end
        CurrentTest = nil
        StopDriveTest(true)
      else
        if CurrentCheckPoint ~= LastCheckPoint then
          if DoesBlipExist(CurrentBlip) then
            RemoveBlip(CurrentBlip)
          end
          CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
          SetBlipRoute(CurrentBlip, 1)
          LastCheckPoint = CurrentCheckPoint
        end
        local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)
        if distance <= 100.0 then
          DrawMarker(1, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
        end
        if distance <= 3.0 then
          Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
          CurrentCheckPoint = CurrentCheckPoint + 1
        end
      end
    end
  end
end)


-- Speed / Damage control
Citizen.CreateThread(function()
  while true do
      if CurrentTest == 'drive' then
          local playerPed = PlayerPedId()
          if IsPedInAnyVehicle(playerPed,  false) then
              local vehicle      = GetVehiclePedIsIn(playerPed,  false)
              local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
              local tooMuchSpeed = false
              for k,v in pairs(Config.SpeedLimits) do
                  if CurrentZoneType == k and speed > v then
                  tooMuchSpeed = true
                      if not IsAboveSpeedLimit then
                          DriveErrors       = DriveErrors + 1
                          IsAboveSpeedLimit = true
                          QBCore.Functions.Notify('Sa sõidad liiga kiiresti',"error")
                          QBCore.Functions.Notify("Vigu: "..tostring(DriveErrors).."/" ..Config.MaxErrors, "error")
                      end
                  end
              end
              if not tooMuchSpeed then
                  IsAboveSpeedLimit = false
              end
              local health = GetVehicleBodyHealth(vehicle)
              if health < LastVehicleHealth then
                  DriveErrors = DriveErrors + 1
                  QBCore.Functions.Notify('Sa kahjustasid autot', 'error')
                  QBCore.Functions.Notify("Vigu: "..tostring(DriveErrors).."/" ..Config.MaxErrors, "error")
                  LastVehicleHealth = health
              end
              if DriveErrors >= Config.MaxErrors then
                Wait(10)
                StopDriveTest(false)
              end
          end
      end
      Citizen.Wait(2000)
  end
end)


--Page Selections changing to different page of UI for theoritical quiz
RegisterNUICallback('question', function(data, cb)
    SendNUIMessage({
      openSection = 'question'
    })
    cb()
end)

RegisterNUICallback('close', function(data, cb)
    StopTheoryTest(true)
    cb()
end)

RegisterNUICallback('kick', function(data, cb)
    StopTheoryTest(false)
    cb()
end)

--Block UI
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(10)
        if CurrentTest =='theory' then
            local playerPed = GetPlayerPed(-1)

            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
            DisablePlayerFiring(playerPed, true) -- Disable weapon firing
            DisableControlAction(0, 142, true) -- MeleeAttackAlternate
            DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
        end
    end
end)

--Blips
Citizen.CreateThread(function ()
    blip = AddBlipForCoord(Config.Location['blip'].x, Config.Location['blip'].y, Config.Location['blip'].z)
    SetBlipSprite(blip, Config.Blip.Sprite)
    SetBlipDisplay(blip, Config.Blip.Display)
    SetBlipColour(blip, Config.Blip.Color)
    SetBlipScale(blip, Config.Blip.Scale)
    SetBlipAsShortRange(blip, Config.Blip.ShortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.BlipName)
    EndTextCommandSetBlipName(blip)
end)

--Marker
--[[Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        local drive = Config.DriversTest
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(pos,Config.Location['marker'].x, Config.Location['marker'].y, Config.Location['marker'].z, true)
        if dist <= 6.0 then
            local marker ={
                ['x'] = Config.Location['marker'].x,
                ['y'] = Config.Location['marker'].y,
                ['z'] = Config.Location['marker'].z
            }
            DrawText3Ds(marker['x'], marker['y'], marker['z'], "[E] Open Menu")
            if dist <= 1.5 then
              if CurrentTest ~= 'drive' then
                if IsControlJustReleased(0, 46) then
                  QBCore.Functions.TriggerCallback('i13-dmv:server:menu', function (permit)
                      if permit == false then
                          QBCore.Functions.TriggerCallback('i13-dmv:server:menu2', function (license)
                              if license then
                                  if drive then
                                      Wait(10)
                                      OpenMenu2()
                                  end
                              else
                                QBCore.Functions.Notify("You already took your tests! Go to City Hall to buy your License.")
                              end
                          end)
                      else
                        Wait(10)
                        OpenMenu()
                      end
                  end)
                end
              elseif CurrentTest == 'drive' and IsControlJustReleased(0, 46) then
                QBCore.Functions.Notify("You\'re already Taking the Drivers Test.")
              end
            end
        end
    end
end) ]]



-----------------DrawText3Ds Function-------------------
DrawText3Ds = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end
-----------------DrawMissionText Function-------------------
function DrawMissionText(msg, time)
    ClearPrints()
    SetTextEntry_2('STRING')
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, 1)
end
-----------------SetCurrentZoneType Function-------------------
function SetCurrentZoneType(type)
    CurrentZoneType = type
  end

-----------------Ped Spawner-------------------
--[[CreateThread(function ()
  if Config.UseTarget then
    SpawnPed = Config.Ped
    exports['qb-target']:SpawnPed({
      model = SpawnPed,
      coords = vector4(Config.Location['ped'].x, Config.Location['ped'].y, Config.Location['ped'].z, Config.Location['ped'].w),
      minusOne = true,
      freeze = true,
      invincible = true,
      blockevents = true,
      scenario = 'WORLD_HUMAN_CLIPBOARD',
      target = {
        options = {}
      }
    })
  else
    DeletePed(SpawnPed)
  end
  if Config.UseTarget then
    QBCore.Functions.TriggerCallback('i13-dmv:server:menu', function (HasItems1)
      if HasItems1 == false then
          QBCore.Functions.TriggerCallback('i13-dmv:server:menu2', function (HasItems2)
              if HasItems2 then
                exports['qb-target']:AddTargetModel(SpawnPed, {       --Drivers Test Menu
                  options = {
                      {
                        type = "client",
                        event = "i13-dmv:startdriver",
                        icon = 'fas fa-example',
                        label = 'Start Drivers Test $'..Config.Amount['driving'].."",
                      },
                      {
                        type = "client",
                        event = "i13-dmv:startcdl",
                        icon = "fas fa-example",
                        label = 'Start Drivers Test $'..Config.Amount['cdl'].."",
                      }
                  },
                    distance = 2.5,
              })
              else
                QBCore.Functions.Notify("You already took your tests!")
              end
          end)
      else
        exports['qb-target']:AddTargetModel(SpawnPed, {     --Theoretical Test Menu
          options = {
              {
                type = "client",
                event = "i13-dmv:startquiz",
                icon = 'fas fa-example',
                label = 'Start Theoretical Test $'..Config.Amount['theoretical'].."",
              },
          },
            distance = 2.5,
      })
      end
    end)
  end
end) ]]

CreateThread(function()
    local pedModel = `s_m_m_fiboffice_02`

    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(5)
    end

    local pos = vector3(1139.89, -463.08, 66.88)
    local pedHeading = 252.75

    ped = CreatePed(4, pedModel, pos.x, pos.y, pos.z - 1, pedHeading, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    --TaskStartScenarioInPlace(ped, "PROP_HUMAN_STAND_IMPATIENT", 0, true)
end)

CreateThread(function()
    local models = {
        's_m_m_fiboffice_02'
    }
    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                type = 'client',
                event = 'i13-dmv:drivingSchoolMenu',
                icon = 'fas fa-file-invoice-dollar',
                label = 'Autokool',
            },
        },
        distance = 2.5,
    })
end)