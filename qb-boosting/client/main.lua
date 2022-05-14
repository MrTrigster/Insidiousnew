local QBCore = exports['qb-core']:GetCoreObject()

local laptopOpen = false
local started = false
local vinStarted = false
local assistingBoost = false
local startedContractId = 0
local dropBlipCreated = false
local vinBlipCreated = false
local startedVinDropOff = false
local startedDropOff = false
local startedHacking = false
local callingCops = false
local copsCalled = false
local updateTime = 3000
local disablerStatus = 0
local disablerUsed = false
local disablerComplete = false
local completedContract = false
local hackablePlate = '0'
local hackableClass = ''
local inQueue = false
local randomLoc = nil
local randomVin = nil
local pedsSpawned = false
local inVinZone = false
local vinZoneName = nil
local Contracts = {}
local boostGroup = {}

-- FUNCTIONS
-- blips

local function CreateBlip(v)
  Circle = Citizen.InvokeNative(0x46818D79B1F7499A,v.x + math.random(0.0,150.0), v.y + math.random(0.0,80.0), v.z + math.random(0.0,5.0) , 300.0) -- you can use a higher number for a bigger zone
  SetBlipHighDetail(Circle, true)
  SetBlipColour(Circle, 18)
  SetBlipAlpha (Circle, 128)
end

local function DeleteCircle()
  if DoesBlipExist(Circle) then
    RemoveBlip(Circle)
  end
end

local function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

local function CreateDropPoint()
  DeleteBlip()
  randomLoc = math.random(1, #Config.DropOffPoints)
  if startedDropOff then
    blip = AddBlipForCoord(Config.DropOffPoints[randomLoc].x, Config.DropOffPoints[randomLoc].y, Config.DropOffPoints[randomLoc].z)
  end
  SetBlipSprite(blip, 514)
  SetBlipScale(blip, 0.7)
  SetBlipAsShortRange(blip, false)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Drop Off")
  EndTextCommandSetBlipName(blip)
end

local function CreateVinPoint()
  DeleteBlip()
  randomVin = math.random(1, #Config.VinPoints)
  if startedVinDropOff then
    blip = AddBlipForCoord(Config.VinPoints[randomVin]['coords'].x, Config.VinPoints[randomVin]['coords'].y, Config.VinPoints[randomVin]['coords'].z)
  end
  SetBlipSprite(blip, 225)
  SetBlipScale(blip, 1.0)
  SetBlipColour(blip, 2)
  SetBlipAsShortRange(blip, false)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Vin Scratch")
  EndTextCommandSetBlipName(blip)

  local shape = Config.VinPoints[randomVin]['shape']
  local vinName = 'vinPoint'..QBCore.Shared.RandomStr(2)

  zone = PolyZone:Create(shape, {
    name = vinName,
    debugPoly = false,
    minZ = Config.VinPoints[randomVin].minZ,
    maxZ = Config.VinPoints[randomVin].maxZ
  })

  zone:onPlayerInOut(function(isPointInside)
    if isPointInside then
      inVinZone = true
      if vinStarted then
        if startedVinDropOff then
          if disablerComplete then
            exports['qb-target']:AddTargetBone('windscreen', {
              options = {
                {
                  type = 'client',
                  event = 'qb-boosting:client:scratchVin',
                  label = 'Kraabi Vin Number',
                  icon = 'fas fa-circle-check',
                  canInteract = function()
                    if inVinZone then
                      if disablerComplete then
                        return true
                      else
                        return false
                      end
                    else
                      return false
                    end
                  end,
                }
              },
              distance = 2.0,
            })
          else
            QBCore.Functions.Notify('Sul on tracker eemaldamata!', 'error')
          end
        end
      end
    else
      inVinZone = false
      exports['qb-target']:RemoveTargetBone('windscreen', 'test')
    end
  end)

  vinZoneName = vinName
end

local function DeleteCopBlip()
  if DoesBlipExist(copblip) then
    RemoveBlip(copblip)
  end
end

local function CreateCopBlip(coords)
  DeleteCopBlip()
  copblip = AddBlipForCoord(coords.x, coords.y, coords.z)
  SetBlipSprite(copblip , 225)
  SetBlipScale(copblip , 2.5)
  SetBlipColour(copblip, 1)
  SetBlipAlpha(copblip, 150)
  SetBlipAsShortRange(copblip, false)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Varastatud Sõiduk")
  EndTextCommandSetBlipName(copblip)
end

--------------------------

local function DisableDisplayControlActions()
  DisableControlAction(0, 1, true) -- disable mouse look
  DisableControlAction(0, 2, true) -- disable mouse look
  DisableControlAction(0, 3, true) -- disable mouse look
  DisableControlAction(0, 4, true) -- disable mouse look
  DisableControlAction(0, 5, true) -- disable mouse look
  DisableControlAction(0, 6, true) -- disable mouse look
  DisableControlAction(0, 263, true) -- disable melee
  DisableControlAction(0, 264, true) -- disable melee
  DisableControlAction(0, 257, true) -- disable melee
  DisableControlAction(0, 140, true) -- disable melee
  DisableControlAction(0, 141, true) -- disable melee
  DisableControlAction(0, 142, true) -- disable melee
  DisableControlAction(0, 143, true) -- disable melee
  DisableControlAction(0, 177, true) -- disable escape
  DisableControlAction(0, 200, true) -- disable escape
  DisableControlAction(0, 202, true) -- disable escape
  DisableControlAction(0, 322, true) -- disable escape
  DisableControlAction(0, 245, true) -- disable chat
end

local function spawnHostilePeds()
  local coords = GetEntityCoords(PlayerPedId())
  local pedModels = {'g_m_m_armboss_01', 'g_m_m_armlieut_01'}
  for k,v in pairs(pedModels) do
    RequestModel(v)
    while not HasModelLoaded(v) do
      Wait(10)
    end
  end

  local _, pos, anotPos = GetClosestRoad(coords.x, coords.y, coords.z, 10, 1, true)

  ped1 = CreatePed(4, 'g_m_m_armboss_01', pos.x + 1, pos.y, pos.z, 0.0, true, true)
  GiveWeaponToPed(ped1, `WEAPON_HEAVYPISTOL`, 42, false, true)
  TaskCombatPed(ped1, PlayerPedId(), 0, 16)

  ped2 = CreatePed(4, 'g_m_m_armlieut_01', pos.x, pos.y, pos.z, 0.0, true, true)
  GiveWeaponToPed(ped2, `WEAPON_PISTOL`, 42, false, true)
  TaskCombatPed(ped2, PlayerPedId(), 0, 16)
end

local function spawnVehicle(model, coords)
  local ModelHash = tostring(model)
  RequestModel(ModelHash)
  while not HasModelLoaded(ModelHash) do
    Wait(10)
  end
  Vehicle = CreateVehicle(ModelHash, coords.x, coords.y, coords.z, 0.0, true, false)
  SetModelAsNoLongerNeeded(ModelHash)
  SetVehicleEngineOn(Vehicle, false, false)
  SetVehicleDoorsLocked(Vehicle, 2)

  return ({vehPlate = GetVehicleNumberPlateText(Vehicle)})
end

local function StartTrackerNotify()
  if startedHacking then
    if disablerUsed == false then
      -- local class = Contracts[startedContractId].class
      local class = hackableClass
      if class == 'D' or class == 'C' then
        TriggerEvent('qb-phone:client:CustomNotification', 'Boosting', 'Sellel sõidukil ei ole trackerit, toimeta see punkti!', 'fas fa-car', '#000d1a', 5000)
        disablerUsed = true
        -- disablerComplete = true
        TriggerServerEvent('qb-boosting:server:finishDisabler', boostGroup)
      elseif class == 'B' or class == 'A' then
        TriggerEvent('qb-phone:client:BoostNotification', 'Boosting', 'Otsib trackereid ('..disablerStatus..'/3)', 'fas fa-car', '#000d1a', true)
        disablerUsed = true
        Wait(15000)
        TriggerEvent('qb-phone:client:BoostNotification', 'Boosting', 'Otsib trackereid ('..disablerStatus..'/3)', 'fas fa-car', '#000d1a', false)
        disablerUsed = false
      elseif class == 'S' then
        TriggerEvent('qb-phone:client:BoostNotification', 'Boosting', 'Otsib trackereid ('..disablerStatus..'/6)', 'fas fa-car', '#000d1a', true)
        disablerUsed = true
        Wait(15000)
        TriggerEvent('qb-phone:client:BoostNotification', 'Boosting', 'Otsib trackereid ('..disablerStatus..'/6)', 'fas fa-car', '#000d1a', false)
        disablerUsed = false
      end
    end
  end
end

local function startTracker()
  TriggerServerEvent('qb-boosting:server:startTracker', boostGroup['UserName'])
end

local function notifyIncomplete()
  QBCore.Functions.Notify('Sul on tracker eemaldamata!', 'error')
end

local function openBoosting()
  QBCore.Functions.TriggerCallback('qb-boosting:server:hasLaptop', function(hasLaptop)
    if hasLaptop then
      for k,v in pairs(Contracts) do
        local data = {
          vehicle = GetDisplayNameFromVehicleModel(v.vehicle),
          price = v.price,
          class = v.class,
          id = v.id,
          started = v.boostStarted,
          name = v.label,
        }
        print()
        SendNUIMessage({
          add = 'true',
          data = data
        })
      end
      QBCore.Functions.TriggerCallback('qb-boosting:server:getBoostLevel', function(boostLevel)
        if boostLevel then
          QBCore.Functions.TriggerCallback('qb-boosting:server:getBoostXP', function(boostXP)
            if boostXP then
              SendNUIMessage({
                action = "getLevel",
                level = boostLevel,
                experience = boostXP,
              })
            end
          end)
        end
      end)
      SetNuiFocus(true, true)
      SendNUIMessage({
        action = "open",
        toggle = true,
        searching = inQueue,
      })
      laptopOpen = true
    else
      QBCore.Functions.Notify('Sul ei ole Boosting Laptop\'i', 'error')
    end
  end)
end

-- CALLBACKS

RegisterNUICallback('startBoost', function(data)
  QBCore.Functions.TriggerCallback('qb-phone:server:GetGroupsApp', function(EmploymentGroup)
    for ke, ve in pairs(EmploymentGroup) do
      if not EmploymentGroup[tostring(QBCore.Functions.GetPlayerData().citizenid)] then QBCore.Functions.Notify('Sa ei ole gruppi loonud', 'error') return end
      if ke == QBCore.Functions.GetPlayerData().citizenid then
        if started == false and vinStarted == false then
          if assistingBoost == false then
            QBCore.Functions.TriggerCallback('qb-boosting:server:getPolice', function(result)
              if result >= Config.MinimumPolice then
                QBCore.Functions.TriggerCallback('qb-boosting:server:getWallet', function (wallet)
                  if wallet then
                    for k,v in ipairs(Contracts) do
                      if (tonumber(v.id) == tonumber(data.id)) then
                        TriggerEvent('qb-boosting:client:startContract', data.id)
                        Contracts[data.id].boostStarted = true
                        boostGroup = EmploymentGroup[ke]
                        Wait(2000)
                        TriggerServerEvent('qb-boosting:server:sendBoostData', boostGroup, Contracts[data.id].plate, Contracts[data.id].class)
                      end
                    end
                  else
                    QBCore.Functions.Notify('Sul ei ole piisavalt INC', 'error')
                  end
                end, tonumber(data.price))
              else
                QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke', 'error')
              end
            end)
          else
            QBCore.Functions.Notify('Sul on juba boost pooleli', 'error')
          end
        else
          QBCore.Functions.Notify('Sul on juba boost pooleli', 'error')
        end
      else
        QBCore.Functions.Notify('Sa ei ole gruppi loonud', 'error')
      end
    end
  end)
  SetNuiFocus(false, false)
end)

RegisterNUICallback('startVin', function(data)
  QBCore.Functions.TriggerCallback('qb-phone:server:GetGroupsApp', function(EmploymentGroup)
    if not EmploymentGroup[QBCore.Functions.GetPlayerData().citizenid] then QBCore.Functions.Notify('Sa ei ole gruppi loonud', 'error') return end
    for ke, ve in pairs(EmploymentGroup) do
      if ke == QBCore.Functions.GetPlayerData().citizenid then
        if started == false and vinStarted == false then
          if assistingBoost == false then
            QBCore.Functions.TriggerCallback('qb-boosting:server:getPolice', function(result)
              if result >= Config.MinimumPolice then
                QBCore.Functions.TriggerCallback('qb-boosting:server:getWallet', function(wallet)
                  if wallet then
                    for k,v in ipairs(Contracts) do
                      if (tonumber(v.id) == tonumber(data.id)) then
                        TriggerEvent('qb-boosting:client:startVin', data.id)
                        Contracts[data.id].boostStarted = true
                        boostGroup = EmploymentGroup[ke]
                        Wait(2000)
                        TriggerServerEvent('qb-boosting:server:sendBoostData', boostGroup, Contracts[data.id].plate, Contracts[data.id].class)
                      end
                    end
                  else
                    QBCore.Functions.Notify('Sul ei ole piisavalt INC', 'error')
                  end
                end, tonumber(data.price))
              else
                QBCore.Functions.Notify('Linnas ei ole piisavalt politseinikke', 'error')
              end
            end)
          else
            QBCore.Functions.Notify('Sul on juba boost pooleli', 'error')
          end
        else
          QBCore.Functions.Notify('Sul on juba boost pooleli', 'error')
        end
      else
        QBCore.Functions.Notify('Sa ei ole gruppi loonud', 'error')
      end
    end
  end)
  SetNuiFocus(false, false)
end)

RegisterNUICallback('transferBoostContract', function(data)
  local id = data.boostId
  local playerid = data.playerId
  for k,v in ipairs(Contracts) do
    if (tonumber(v.id) == tonumber(id)) then
      local veh = v.vehicle
      local vehLabel = v.label
      local coord = v.coords
      local vehClass = v.class
      local VehiclePrice = v.price
      TriggerServerEvent('qb-boosting:server:transferBoost', veh, vehLabel, coord, vehClass, VehiclePrice, v.id, playerid)
    end
  end
end)

RegisterNUICallback('close', function(data)
  SetNuiFocus(false, false)
  laptopOpen = false
end)

RegisterNUICallback('remove', function(data)
  TriggerEvent('qb-boosting:client:removeContract', data.id)
end)

RegisterNUICallback('toggleQueue', function(data)
  inQueue = data.toggleQueue
  print('queue toggled to '..tostring(inQueue))
end)

-- COMMANDS

RegisterCommand('boosting', function(source)
  PlayerData = QBCore.Functions.GetPlayerData()
  if LocalPlayer.state.isLoggedIn then
    if not PlayerData.metadata['ishandcuffed'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['isdead'] and not IsPauseMenuActive() then
      openBoosting()
    else
      QBCore.Functions.Notify('Sa ei saa seda teha', 'error')
    end
  end
end)

TriggerEvent('chat:removeSuggestion', 'boosting')

-- RegisterCommand('addboost', function(source)
--   TriggerEvent('qb-boosting:client:createContract')
-- end)

-- EVENTS

RegisterNetEvent('qb-boosting:client:openBoosting', function()
  ExecuteCommand('boosting')
end)

RegisterNetEvent('qb-boosting:client:createContract', function()
  if inQueue then
    QBCore.Functions.TriggerCallback('qb-boosting:server:hasLaptop', function(result)
      if result then
        QBCore.Functions.TriggerCallback('qb-boosting:server:getBoostLevel', function(boostLevel)
          if boostLevel then
            local random = math.random(#Config.Vehicles[boostLevel])
            local veh = Config.Vehicles[boostLevel][random].vehicle
            local vehLabel = Config.Vehicles[boostLevel][random].label
            local coord = Config.VehicleCoords[math.random(#Config.VehicleCoords)]
            local vehClass = QBCore.Shared.Vehicles[veh].class
            VehiclePrice = Config.ClassPrices[vehClass]

            local data = {
              vehicle = veh,
              price = VehiclePrice,
              class = vehClass,
              id = #Contracts+1,
              coords = coord,
              plate = '0000',
              label = vehLabel,
              boostStarted = false
            }
            TriggerEvent('qb-phone:client:CustomNotification', 'Boosting', 'Sulle tuli '..vehClass..' Class boost!', 'fas fa-car', '#000d1a', 2500)
            table.insert(Contracts, data)
          end
        end)
      else
        inQueue = false
      end
    end)
  else
    QBCore.Functions.Notify('Sa ei ole otsimise järjekorras', 'error')
  end
end)

RegisterNetEvent('qb-boosting:client:startContract', function(id)
  for k,v in ipairs(Contracts) do
    if (tonumber(v.id) == tonumber(id)) then
      local vehCoords = v.coords
      local vehInfo = spawnVehicle(v.vehicle, v.coords)
      SetEntityHeading(Vehicle, vehCoords.w)
      CreateBlip(v.coords)
      Contracts[k].plate = vehInfo.vehPlate
      startedContractId = v.id
      started = true
      TriggerEvent('qb-phone:client:CustomNotification', 'Boosting', 'Alustasid boosti, otsi sõiduk kaardil märgitud alast!', 'fas fa-car', '#000d1a', 6000)
    end
  end
end)

RegisterNetEvent('qb-boosting:client:startVin', function(id)
  for k,v in ipairs(Contracts) do
    if (tonumber(v.id) == tonumber(id)) then
      local vehCoords = v.coords
      local vehInfo = spawnVehicle(v.vehicle, v.coords)
      SetEntityHeading(Vehicle, vehCoords.w)
      CreateBlip(v.coords)
      Contracts[k].plate = vehInfo.vehPlate
      startedContractId = v.id
      vinStarted = true
      TriggerEvent('qb-phone:client:CustomNotification', 'Boosting', 'Alustasid boosti, otsi sõiduk kaardil märgitud alast!', 'fas fa-car', '#000d1a', 6000)
    end
  end
end)

RegisterNetEvent('qb-boosting:client:completeContract', function()
  if disablerComplete then
    if completedContract then
      TriggerEvent('qb-phone:client:CustomNotification', 'Boosting', 'Sõiduk kohale toimetatud, mine alast eemale!', 'fas fa-car', '#000d1a', 6000)
      -- TriggerServerEvent('qb-boosting:server:removeBlip')
      Wait(math.random(10000, 20000))
      TriggerServerEvent('qb-boosting:server:finishedContract', Contracts[startedContractId].price)
      table.remove(Contracts, startedContractId)
      SetEntityAsMissionEntity(Vehicle,true,true)
      DeleteEntity(Vehicle)
      TriggerServerEvent('qb-boosting:server:finishedAssist', boostGroup['UserName'])
    end
  else
    QBCore.Functions.Notify('Sul on tracker eemaldamata!', 'error')
  end
end)

RegisterNetEvent('qb-boosting:client:scratchVin', function()
  local coords = GetEntityCoords(PlayerPedId())
  local vinVehicle = GetVehiclePedIsIn(PlayerPedId(), true)
  if disablerComplete then
    if GetVehicleNumberPlateText(vinVehicle) == Contracts[startedContractId].plate then
      QBCore.Functions.TriggerCallback('qb-boosting:server:getWallet', function(wallet)
        if wallet then
          QBCore.Functions.Progressbar('scratchVin', 'Kraabib vin numbrit...', 10000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
          }, {
            animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
            anim = 'machinic_loop_mechandplayer',
            flags = 9,
          }, {}, {}, function()
            TriggerServerEvent('qb-boosting:server:finishedVin', Contracts[startedContractId].vehicle, Contracts[startedContractId].plate)
            Wait(1000)
            table.remove(Contracts, startedContractId)
            TriggerServerEvent('qb-boosting:server:finishedAssist', boostGroup['UserName'])
            DeleteBlip()
          end, function()
            QBCore.Functions.Notify('Katkestatud', 'error')
          end)
        else
          QBCore.Functions.Notify('Sul ei ole piisavalt INC')
        end
      end, 50)
    else
      QBCore.Functions.Notify('See ei ole õige sõiduk', 'error')
    end
  end
end)

RegisterNetEvent('qb-boosting:client:resetVariables', function()
  started = false
  vinStarted = false
  startedContractId = 0
  dropBlipCreated = false
  vinBlipCreated = false
  startedDropOff = false
  startedVinDropOff = false
  startedHacking = false
  callingCops = false
  copsCalled = false
  updateTime = 3000
  disablerStatus = 0
  disablerUsed = false
  disablerComplete = false
  completedContract = false
  assistingBoost = false
  hackablePlate = '0'
  hackableClass = ''
  randomLoc = nil
  randomVin = nil
  if vinZoneName ~= nil then
    vinZoneName = nil
    zone:destroy()
  end
  pedsSpawned = false
  boostGroup = {}
  print('successfully reset your variables')
end)

RegisterNetEvent('qb-boosting:client:removeContract', function(id)
  for k,v in ipairs(Contracts) do
    if (tonumber(v.id) == tonumber(id)) then
      DeleteCircle()
      if DoesEntityExist(Vehicle) then
        if GetVehicleNumberPlateText(Vehicle) == Contracts[id].plate then
          SetEntityAsMissionEntity(Vehicle,true,true)
          DeleteEntity(Vehicle)
        end
      end
      table.remove(Contracts, k)
      started = false
      vinStarted = false
      startedContractId = 0
      dropBlipCreated = false
      vinBlipCreated = false
      startedDropOff = false
      startedVinDropOff = false
      startedHacking = false
      callingCops = false
      copsCalled = false
      updateTime = 3000
      disablerStatus = 0
      disablerUsed = false
      disablerComplete = false
      completedContract = false
      assistingBoost = false
      hackablePlate = '0'
      hackableClass = ''
      randomLoc = nil
      randomVin = nil
      if vinZoneName ~= nil then
        vinZoneName = nil
        zone:destroy()
      end
      pedsSpawned = false
      boostGroup = {}
      SendNUIMessage({
        action = "delete",
        boostid = id,
      })
    end
  end
end)

RegisterNetEvent('qb-boosting:client:recieveBoost', function(veh, vehLabel, coord, vehClass, VehiclePrice)
  local boost = {
    vehicle = veh,
    price = VehiclePrice,
    label = vehLabel,
    coords = coord,
    class = vehClass,
    id = #Contracts+1,
    plate = '0000',
    boostStarted = false,
  }
  table.insert(Contracts, boost)
  TriggerEvent('qb-phone:client:CustomNotification', 'Boosting', 'Sulle saadeti '..vehClass..' Class boost!', 'fas fa-car', '#000d1a', 2500)
end)

RegisterNetEvent('qb-boosting:client:setCopBlip', function(coords)
  CreateCopBlip(coords)
end)

RegisterNetEvent('qb-boosting:client:setBlipTime', function(time)
  updateTime = time
end)

RegisterNetEvent('qb-boosting:client:removeCopBlip', function()
  DeleteCopBlip()
end)

RegisterNetEvent('qb-boosting:client:useDisabler', function()
  local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
  if veh ~= 0 then
    QBCore.Functions.TriggerCallback('qb-phone:server:GetGroupsApp', function(EmploymentGroup)
      print(json.encode(boostGroup))
      for k,v in pairs(EmploymentGroup) do
        if GetVehicleNumberPlateText(veh) == hackablePlate then
          local class = hackableClass
          print(class)
          if disablerUsed == false then
            disablerUsed = true
            if class == 'B' or class == 'A' then
              if disablerStatus < 3 then
                local minigame = exports['hackingminigame']:Open()
                if disablerStatus < 2 then
                  if minigame == true then
                    disablerStatus = disablerStatus + 1
                    disablerUsed = false
                    TriggerServerEvent('qb-boosting:server:updateTracker', boostGroup['UserName'], disablerStatus)
                    -- StartTrackerNotify()
                    TriggerServerEvent('qb-boosting:server:setBlipTime', true)
                    updateTime = 10000
                    Wait(7000)
                    TriggerServerEvent('qb-boosting:server:setBlipTime', false)
                    updateTime = 3000
                  else
                    disablerUsed = false
                    QBCore.Functions.Notify('Ebaõnnestus', 'error')
                  end
                elseif disablerStatus == 2 then
                  if minigame == true then
                    TriggerServerEvent('qb-boosting:server:resetDisabler', boostGroup['UserName'])
                    TriggerServerEvent('qb-boosting:server:finishDisabler', boostGroup)
                    -- disablerStatus = 0
                    callingCops = false
                    -- disablerComplete = true
                    TriggerServerEvent('qb-boosting:server:removeBlip')
                    -- TriggerEvent('qb-phone:client:CustomNotification', 'Boosting', 'Tracker eemaldatud, vii sõiduk Drop Offi!', 'fas fa-car', '#000d1a', 6000)
                  else
                    QBCore.Functions.Notify('Ebaõnnestus', 'error')
                    disablerUsed = false
                  end
                end
              end
            elseif class == 'S' then
              if disablerStatus < 6 then
                local minigame = exports['hackingminigame']:Open()
                if disablerStatus < 5 then
                  if minigame == true then
                    disablerStatus = disablerStatus + 1
                    disablerUsed = false
                    TriggerServerEvent('qb-boosting:server:updateTracker', boostGroup['UserName'], disablerStatus)
                    -- StartTrackerNotify()
                    TriggerServerEvent('qb-boosting:server:setBlipTime', true)
                    Wait(7000)
                    TriggerServerEvent('qb-boosting:server:setBlipTime', false)
                  else
                    disablerUsed = false
                    QBCore.Functions.Notify('Ebaõnnestus', 'error')
                  end
                elseif disablerStatus == 5 then
                  if minigame == true then
                    TriggerServerEvent('qb-boosting:server:resetDisabler', boostGroup['UserName'])
                    TriggerServerEvent('qb-boosting:server:finishDisabler', boostGroup)
                    -- disablerStatus = 0
                    callingCops = false
                    -- disablerComplete = true
                    TriggerServerEvent('qb-boosting:server:removeBlip')
                    -- TriggerEvent('qb-phone:client:CustomNotification', 'Boosting', 'Tracker eemaldatud, vii sõiduk Drop Offi!', 'fas fa-car', '#000d1a', 6000)
                  else
                    QBCore.Functions.Notify('Ebaõnnestus', 'error')
                    disablerUsed = false
                  end
                end
              end
            end
          end
        else
          QBCore.Functions.Notify('Sa ei ole õiges sõidukis', 'error')
        end
      end
    end)
  else
    QBCore.Functions.Notify('Sa ei ole sõidukis', 'error')
  end
end)

RegisterNetEvent('qb-boosting:client:getBoostData', function(boostingGroup, boostPlate, boostClass)
  if QBCore.Functions.GetPlayerData().citizenid ~= boostingGroup.CSN then
    boostGroup = boostingGroup
    print(json.encode(boostGroup))
  end
  hackablePlate = boostPlate
  hackableClass = boostClass
  assistingBoost = true
end)

RegisterNetEvent('qb-boosting:client:notifyTracker', function()
  startedHacking = true
  StartTrackerNotify()
end)

RegisterNetEvent('qb-boosting:client:updateTracker', function(disabler)
  disablerStatus = disabler
  StartTrackerNotify()
end)

RegisterNetEvent('qb-boosting:client:resetDisabler', function()
  disablerStatus = 0
  print('disabler reset for you')
end)

RegisterNetEvent('qb-boosting:client:finishDisabler', function()
  disablerComplete = true
  TriggerEvent('qb-phone:client:CustomNotification', 'Boosting', 'Tracker eemaldatud!', 'fas fa-car', '#000d1a', 6000)
  print('disabler complete for you(leader)')
end)

-- THREADS

CreateThread(function()
  while laptopOpen do
    DisableDisplayControlActions()
    Wait(1)
  end
end)

CreateThread(function()
  while true do
    Wait(0)
    while started do
      Wait(1000)
      local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
      if veh ~= 0 then
        local PlayerPed = PlayerPedId()
        if GetVehicleNumberPlateText(veh) == Contracts[startedContractId].plate then
          local PedDriver = GetVehiclePedIsIn(PlayerPed)
          local Driver = GetPedInVehicleSeat(PedDriver, -1)
          local Passenger = GetPedInVehicleSeat(PedDriver, 0)
          if Driver == PlayerPed or Passenger == PlayerPed then
            if not dropBlipCreated then
              if not pedsSpawned then
                spawnHostilePeds()
                pedsSpawned = true
              end
              startedDropOff = true
              dropBlipCreated = true
              local class = Contracts[startedContractId].class
              if class == 'B' or class == 'A' then
                if not copsCalled then
                  local hash = GetEntityModel(Vehicle)
                  local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                  local vehPlate = Contracts[startedContractId].plate
                  -- local data = {displayCode = '10-75', description = class..' Class Boost', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-car', info = modelName..''}
                  -- local dispatchData = {dispatchData = data, caller = 'Autoalarm', coords = GetEntityCoords(PlayerPed)}
                  -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                  exports['qb-dispatch']:CarBoosting(veh, class)
                  callingCops = true
                  copsCalled = true
                end
              elseif class == 'S' then
                if not copsCalled then
                  local hash = GetEntityModel(Vehicle)
                  local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                  local vehPlate = Contracts[startedContractId].plate
                  -- local data = {displayCode = '10-75', description = class..' Class Boost', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-car', info = modelName..''}
                  -- local dispatchData = {dispatchData = data, caller = 'Autoalarm', coords = GetEntityCoords(PlayerPed)}
                  -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                  exports['qb-dispatch']:CarBoosting(veh, class)
                  callingCops = true
                  copsCalled = true
                end
              end
              CreateDropPoint()
              startTracker()
              DeleteCircle()
            end
          end
        end
      end
    end
  end
end)

CreateThread(function()
  while true do
    Wait(0)
    while vinStarted do
      Wait(1000)
      local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
      if veh ~= 0 then
        local PlayerPed = PlayerPedId()
        if GetVehicleNumberPlateText(veh) == Contracts[startedContractId].plate then
          local PedDriver = GetVehiclePedIsIn(PlayerPed)
          local Driver = GetPedInVehicleSeat(PedDriver, -1)
          local Passenger = GetPedInVehicleSeat(PedDriver, 0)
          if Driver == PlayerPed or Passenger == PlayerPed then
            if not vinBlipCreated then
              if not pedsSpawned then
                spawnHostilePeds()
                pedsSpawned = true
              end
              startedVinDropOff = true
              vinBlipCreated = true
              local class = Contracts[startedContractId].class
              if class == 'B' or class == 'A' then
                if not copsCalled then
                  local hash = GetEntityModel(Vehicle)
                  local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                  local vehPlate = Contracts[startedContractId].plate
                  -- local data = {displayCode = '10-75', description = class..' Class Boost', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-car', info = modelName..''}
                  -- local dispatchData = {dispatchData = data, caller = 'Autoalarm', coords = GetEntityCoords(PlayerPed)}
                  -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                  exports['qb-dispatch']:CarBoosting(veh, class)
                  callingCops = true
                  copsCalled = true
                end
              elseif class == 'S' then
                if not copsCalled then
                  local hash = GetEntityModel(Vehicle)
                  local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                  local vehPlate = Contracts[startedContractId].plate
                  -- local data = {displayCode = '10-75', description = class..' Class Boost', isImportant = 1, recipientList = {'police'}, length = '10000', infoM = 'fa-car', info = modelName..''}
                  -- local dispatchData = {dispatchData = data, caller = 'Autoalarm', coords = GetEntityCoords(PlayerPed)}
                  -- TriggerServerEvent('wf-alerts:svNotify', dispatchData)
                  exports['qb-dispatch']:CarBoosting(veh, class)
                  callingCops = true
                  copsCalled = true
                end
              end
              CreateVinPoint()
              startTracker()
              DeleteCircle()
            end
          end
        end
      end
    end
  end
end)

CreateThread(function()
  while true do
    if callingCops then
      Wait(updateTime)
      local coords = GetEntityCoords(Vehicle)
      if callingCops then
        TriggerServerEvent('qb-boosting:server:alertCops', coords)
      end
    else
      Wait(500)
    end
  end
end)

CreateThread(function()
  while true do
    if startedDropOff then
      Wait(1000)
      local coordA = GetEntityCoords(PlayerPedId())
      local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
      if veh ~= 0 then
        local PlayerPed = PlayerPedId()
        if GetVehicleNumberPlateText(veh) == Contracts[startedContractId].plate then
          local PedVehicle = GetVehiclePedIsIn(PlayerPed)
          local aDist = GetDistanceBetweenCoords(Config.DropOffPoints[randomLoc].x, Config.DropOffPoints[randomLoc].y, Config.DropOffPoints[randomLoc].z, coordA.x, coordA.y, coordA.z)
          if aDist < 10.0 then
            if disablerComplete then
              completedContract = true
              Wait(300)
              DeleteBlip()
              if startedDropOff then
                TriggerEvent('qb-boosting:client:completeContract')
              end
              startedDropOff = false
            else
              notifyIncomplete()
            end
          end
        end
      end
    else
      Wait(5000)
    end
  end
end)

CreateThread(function()
  while true do
    Wait(Config.ContractWaitTime)
    if inQueue then
      if not started and not vinStarted then
        local chance = math.random(1, 10)
        local chance2 = 60 / 10
        if chance <= chance2 then
          TriggerEvent('qb-boosting:client:createContract')
        end
      end
    end
  end
end)