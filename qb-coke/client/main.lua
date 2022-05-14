local QBCore = exports['qb-core']:GetCoreObject()
local pilot, plane, cokeDealer, currentDropCoords, landingLocation
local requiredModels = {'g_m_y_pologoon_01', 'cuban800'}
local planeHasSpawned = false
local gotLocation = false
local jobStarted = false
local jobFinished = false

-- Functions

local function startPlaneLanding()
  if landingLocation ~= nil then
    RemoveBlip(landingLocation)
  end

  local chance = math.random(1, 100)
  if chance < 20 then
    exports['qb-dispatch']:CokePlane()
  end

  QBCore.Functions.Notify('Lennuk on maandumas')
  QBCore.Functions.Notify('Võta lennukilt koka')

  for i = 1, #requiredModels do
    RequestModel(GetHashKey(requiredModels[i]))
    while not HasModelLoaded(GetHashKey(requiredModels[i])) do
      Wait(0)
    end
  end


  local landStart = currentDropCoords.landStart
  local landEnd = currentDropCoords.landEnd
  local planeSpawn = currentDropCoords.spawn
  plane = CreateVehicle(GetHashKey('cuban800'), planeSpawn, planeSpawn.w, true, true)
  SetEntityHeading(plane, planeSpawn.w)
  SetVehicleDoorsLocked(plane, 2)
  SetEntityDynamic(plane, true)
  ActivatePhysics(plane, true)
  SetVehicleForwardSpeed(plane, 40.0)
  -- SetHeliBladesFullSpeed(plane)
  SetVehicleEngineOn(plane, true, true, false)
  ControlLandingGear(plane, 0)
  pilot = CreatePedInsideVehicle(plane, 1, GetHashKey('g_m_y_pologoon_01'), -1, true, true)
  SetBlockingOfNonTemporaryEvents(pilot, true)
  SetPedRandomComponentVariation(pilot, true)
  TaskPlaneLand(pilot, plane, landStart.x, landStart.y, landStart.z, landEnd.x, landEnd.y, landEnd.z)
  planeHasSpawned = true

  CreateThread(function()
    exports['qb-target']:AddTargetEntity(plane, {
      options = {
        {
          type = 'client',
          event = 'i13-coke:client:grabCoke',
          label = 'Võta Koka',
          icon = 'fas fa-box',
        }
      },
      distance = 2.5,
    })
  end)
end

local function pilotEjected()
  exports['qb-target']:RemoveTargetEntity(plane, 'test')
  DeleteEntity(plane)
  DeleteEntity(pilot)
  planeHasSpawned = false
  QBCore.Functions.Notify('Cartelile ei meeldinud see', 'error')
  QBCore.Functions.Notify('Sa ei saanud oma kokat kätte', 'error')
end

local function planeDestroyed()
  exports['qb-target']:RemoveTargetEntity(plane, 'test')
  DeleteEntity(plane)
  DeleteEntity(pilot)
  planeHasSpawned = false
  QBCore.Functions.Notify('Lennuk hävines', 'error')
  QBCore.Functions.Notify('Sa ei saanud oma kokat kätte', 'error')
end

-- Events

RegisterNetEvent('i13-coke:client:grabCoke', function()
  exports['qb-target']:RemoveTargetEntity(plane, 'test')
  DeleteEntity(plane)
  DeleteEntity(pilot)
  planeHasSpawned = false
  TriggerServerEvent('i13-coke:server:getCoke')
  jobStarted = false
  jobFinished = true
end)

RegisterNetEvent('i13-coke:client:getLocation', function()
  QBCore.Functions.TriggerCallback('i13-coke:server:checkLocationMoney', function(result)
    if not jobFinished then
      if not jobStarted then
        if result then
          local random = math.random(1, #Config.PlaneCoords)
          currentDropCoords = Config.PlaneCoords[random]
          landingLocation = AddBlipForCoord(currentDropCoords.landEnd.x, currentDropCoords.landEnd.y, currentDropCoords.landEnd.z)
          SetBlipColour(landingLocation, 2)
          SetBlipSprite(landingLocation, 578)
          SetBlipRoute(landingLocation, true)
          SetBlipRouteColour(landingLocation, 2)
          BeginTextCommandSetBlipName('STRING')
          AddTextComponentSubstringPlayerName('Drop Off')
          EndTextCommandSetBlipName(landingLocation)
          QBCore.Functions.Notify('Drop Off\'i asukoht märgitud gps\'ile')
          gotLocation = true
          jobStarted = true
        else
          QBCore.Functions.Notify('Sul ei ole piisavalt sularaha', 'error')
        end
      else
        QBCore.Functions.Notify('Sul on juba tellimus pooleli', 'error')
      end
    else
      QBCore.Functions.Notify('Tellimus ei ole veel valmis', 'error')
    end
  end)
end)

-- RegisterCommand('testplane', function(source, args, rawCommand)
--   startPlaneLanding()
-- end)

-- Threads

CreateThread(function()
  local pedModel = `g_m_m_armgoon_01`

  RequestModel(pedModel)

  while not HasModelLoaded(pedModel) do
      Wait(5)
  end

  local pos = vector4(2729.68, 4148.65, 43.99, 80.79)

  cokeDealer = CreatePed(4, pedModel, pos.x, pos.y, pos.z - 1, pos.w, false, true)
  FreezeEntityPosition(cokeDealer, true)
  SetEntityInvincible(cokeDealer, true)
  SetBlockingOfNonTemporaryEvents(cokeDealer, true)
  TaskStartScenarioInPlace(cokeDealer, 'WORLD_HUMAN_DRUG_DEALER', 0, true)

  exports['qb-target']:AddTargetEntity(cokeDealer, {
    options = {
      {
        type = 'client',
        event = 'i13-coke:client:getLocation',
        label = 'Telli Pulbrit $6,000',
        icon = 'fas fa-copy',
        item = 'secret_documents',
      }
    },
    distance = 2.0,
  })
end)

CreateThread(function()
  exports['qb-target']:AddBoxZone('cokeProcess', vector3(-1373.94, -311.7, 39.64), 1.15, 2.1, {
    name = 'cokeProcess',
    heading = 300,
    debugPoly = false,
    minZ = 38.79,
    maxZ = 39.99
  }, {
    options = {
      {
        type = 'client',
        event = 'i13-coke:client:processMenu',
        label = 'Protsessi Kokat',
        icon = 'fas fa-scale-balanced',
      }
    },
    distance = 1.5,
  })
end)

CreateThread(function()
  while true do
    Wait(1000)
    if planeHasSpawned then
      if not IsPedInAnyPlane(pilot) or IsEntityDead(pilot) then
        planeHasSpawned = false
        pilotEjected()
      end

      if plane == nil then
        planeHasSpawned = false
        planeDestroyed()
      end
    end
  end
end)

CreateThread(function()
  while true do
    Wait(1000)
    if gotLocation then
      local pos = GetEntityCoords(PlayerPedId())
      local targetPos = currentDropCoords.landEnd
      if #(pos - targetPos) < 20.0 then
        gotLocation = false
        startPlaneLanding()
      end
    end
  end
end)

CreateThread(function()
  while true do
    if jobFinished then
      Wait(5 * 60 * 1000)
      jobFinished = false
    end
    Wait(1000)
  end
end)