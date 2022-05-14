local QBCore = exports['qb-core']:GetCoreObject()
local IsFirstSpawn = true

-- Handlers

AddEventHandler('playerSpawned', function(spawn)
  if IsFirstSpawn then
    TriggerServerEvent('qa:server:secondCheck')
    IsFirstSpawn = false
  end
end)

-- Callbacks

RegisterNUICallback('ban', function(data, cb)
  if not data.target or not data.reason then return end
  QBCore.Functions.TriggerCallback('qa:server:ban', function(success, reason)
    if success then
      QBCore.Functions.Notify('Mängija bannitud', 'success')
    else
      QBCore.Functions.Notify(reason, 'error')
    end
  end, data.target, data.reason, data.length, data.offline)
end)

RegisterNUICallback('unban', function(data, cb)
  if not data.id then return end
  QBCore.Functions.TriggerCallback('qa:server:unban', function(success)
    if success then
      QBCore.Functions.Notify('Mängija unbanned', 'success')
    else
      QBCore.Functions.Notify('Midagi läks valesti', 'error')
    end
  end, data.id)
end)

RegisterNUICallback('getListData', function(data, cb)
  if not data.list or not data.page then cb(nil); return end
  QBCore.Functions.TriggerCallback('qa:server:getListData', function(data)
    cb(data)
  end, data.list, data.page)
end)

RegisterNUICallback('close', function(data, cb)
  SetNuiFocus(false, false)
end)

-- Events

RegisterNetEvent('qa:client:showMenu', function(menu)
  if menu == 'ban' then
    QBCore.Functions.TriggerCallback('qa:server:getIndexedPlayerList', function(indexedPList)
      SendNUIMessage({
        show = true,
        window = menu,
        players = indexedPList
      })
    end)
  elseif menu == 'banlist' then
    SendNUIMessage({
      loading = true,
      window = menu
    })
    QBCore.Functions.TriggerCallback('qa:server:getBanList', function(list, pages)
      SendNUIMessage({
        show = true,
        window = menu,
        list = list,
        pages = pages
      })
    end)
  end
  SetNuiFocus(true, true)
end)