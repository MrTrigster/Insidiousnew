-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local currentData = nil

-- Functions

local function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(5)
  end
end

local function helpText(text)
	SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Events

RegisterNetEvent('i13-boombox:client:placeBoombox', function()
    loadAnimDict("anim@heists@money_grab@briefcase")
    TaskPlayAnim(PlayerPedId(), "anim@heists@money_grab@briefcase", "put_down_case", 8.0, -8.0, -1, 1, 0, false, false, false)
    Citizen.Wait(1000)
    ClearPedTasks(PlayerPedId())
    local coords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    boomboxObject = CreateObject(GetHashKey('prop_boombox_01'), x, y, z, true, false, false)
    PlaceObjectOnGroundProperly(boomboxObject)
    SetEntityHeading(boomboxObject, heading)
    FreezeEntityPosition(boomboxObject, true)
    currentData = NetworkGetNetworkIdFromEntity(boomboxObject)

    CreateThread(function()
        exports['qb-target']:AddTargetEntity(boomboxObject, {
            options = {
                {
                    type = 'client',
                    event = 'i13-boombox:client:playMusic',
                    label = 'Kasuta Boomboxi',
                    icon = 'fas fa-radio'
                }
            },
            distance = 1.6,
        })
    end)
end)

RegisterNetEvent('i13-boombox:client:pickupBoombox', function()
    local obj = NetworkGetEntityFromNetworkId(currentData)
    local objCoords = GetEntityCoords()
    NetworkRequestControlOfEntity(obj)
    loadAnimDict("anim@heists@narcotics@trash")
    TaskPlayAnim(PlayerPedId(), "anim@heists@narcotics@trash", "pickup", 8.0, -8.0, -1, 1, 0, false, false, false)
    Citizen.Wait(700)
    SetEntityAsMissionEntity(obj,false,true)
    DeleteEntity(obj)
    DeleteObject(obj)
    if not DoesEntityExist(obj) then
        TriggerServerEvent('i13-boombox:server:pickedup', currentData)
        TriggerServerEvent('QBCore:Server:AddItem', 'boombox', 1)
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['boombox'], 'add')
        currentData = nil
    end
    Citizen.Wait(500)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('i13-boombox:client:playMusic', function()
    local musicMenu = {
      {
          isHeader = true,
          header = '💿 | Boombox'
      },
      {
          header = '🎶 | Mängi Muusikat',
          txt = 'Sisesta youtube URL',
          params = {
              event = 'i13-boombox:client:musicMenu',
              args = {

              }
          }
      },
      {
          header = '⏸️ | Pane Pausile',
          txt = 'Pane hetkel käiv muusika pausile',
          params = {
              isServer = true,
              event = 'i13-boombox:server:pauseMusic',
              args = {
                  entity = currentData,
              }
          }
      },
      {
          header = '▶️ | Jätka Mängimist',
          txt = 'Jätka pausil oleva muusika mängimist',
          params = {
              isServer = true,
              event = 'i13-boombox:server:resumeMusic',
              args = {
                  entity = currentData,
              }
          }
      },
      {
          header = '🔈 | Muuda Helitugevust',
          txt = 'Muuda boomboxi helitugevust',
          params = {
              event = 'i13-boombox:client:changeVolume',
              args = {

              }
          }
      },
      {
          header = '❌ | Peata Muusika',
          txt = 'Peata muusika mängimine',
          isServer = true,
          params = {
              isServer = true,
              event = 'i13-boombox:server:stopMusic',
              args = {
                  entity = currentData,
              }
          }
      },
      {
          header = '❌ | Korja Üles',
          txt = 'Korja boombox maast üles',
          params = {
              event = 'i13-boombox:client:pickupBoombox',
              args = {
              }
          }
      }
    }
    exports['qb-menu']:openMenu(musicMenu)
end)

RegisterNetEvent('i13-boombox:client:musicMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Muusika Valik',
        submitText = "Kinnita",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'song',
                text = 'YouTube URL'
            }
        }
    })
    if dialog then
        if not dialog.song then return end
        TriggerServerEvent('i13-boombox:server:playMusic', dialog.song, currentData, GetEntityCoords(NetworkGetEntityFromNetworkId(currentData)))
    end
end)

RegisterNetEvent('i13-boombox:client:changeVolume', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Muusika Helitugevus',
        submitText = "Submit",
        inputs = {
            {
                type = 'text', -- number doesn't accept decimals??
                isRequired = true,
                name = 'volume',
                text = 'Min: 0.01 - Max: 1'
            }
        }
    })
    if dialog then
        if not dialog.volume then return end
        TriggerServerEvent('i13-boombox:server:changeVolume', dialog.volume, currentData)
    end
end)

-- CreateThread(function()
--     while true do
--         local sleep = 1000
--         if LocalPlayer.state['isLoggedIn'] then
--             local ped = PlayerPedId()
--             local coords    = GetEntityCoords(ped)
--             local object = GetClosestObjectOfType(coords, 3.0, GetHashKey('prop_boombox_01'), false, false, false)
--             if DoesEntityExist(object) then
--                 local objCoords = GetEntityCoords(object)
--                 if #(coords - objCoords) < 4 then
--                   currentData = NetworkGetNetworkIdFromEntity(object)
--                     helpText('Vajuta ~INPUT_CONTEXT~ et mängida muusikat')
--                     if IsControlJustReleased(0, 38) then
--                         TriggerEvent('i13-boombox:client:playMusic')
--                     end
--                     sleep = 5
--                 else
--                   exports['qb-menu']:closeMenu()
--                 end
--             end
--         end
--         Wait(sleep)
--     end
-- end)