local QBCore = exports['qb-core']:GetCoreObject()



RegisterNetEvent('i13-coke:client:brickTo10g', function(bricks)
  QBCore.Functions.Progressbar('brickto10g', 'Pakib lahti...', 10000 * tonumber(bricks), false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
  }, {
    animDict = 'mini@repair',
    anim = 'fixing_a_ped',
    flags = 47,
  }, {}, {}, function()
    TriggerServerEvent('i13-coke:server:brickTo10g', bricks)
    ClearPedTasks(PlayerPedId())
  end, function()
    QBCore.Functions.Notify('Katkestatud', 'error')
    ClearPedTasks(PlayerPedId())
  end)
end)

RegisterNetEvent('i13-coke:client:brickTo1g', function(bricks)
  QBCore.Functions.Progressbar('brickto1g', 'Pakib lahti...', 10000 * tonumber(bricks), false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
  }, {
    animDict = 'mini@repair',
    anim = 'fixing_a_ped',
    flags = 47,
  }, {}, {}, function()
    TriggerServerEvent('i13-coke:server:brickTo1g', bricks)
    ClearPedTasks(PlayerPedId())
  end, function()
    QBCore.Functions.Notify('Katkestatud', 'error')
    ClearPedTasks(PlayerPedId())
  end)
end)

RegisterNetEvent('i13-coke:client:10gTo1g', function(packs)
  QBCore.Functions.Progressbar('brickto1g', 'Pakib lahti...', 1000 * tonumber(packs), false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
  }, {
    animDict = 'mini@repair',
    anim = 'fixing_a_ped',
    flags = 47,
  }, {}, {}, function()
    TriggerServerEvent('i13-coke:server:10gTo1g', packs)
    ClearPedTasks(PlayerPedId())
  end, function()
    QBCore.Functions.Notify('Katkestatud', 'error')
    ClearPedTasks(PlayerPedId())
  end)
end)


RegisterNetEvent('i13-coke:client:processMenu', function()
  exports['qb-menu']:openMenu({
    {
      header = 'Koka Protsessimine',
      txt = '',
      isMenuHeader = true,
    },
    {
      header = 'Brick → Kotike (10g)',
      txt = 'Paki brick lahti 10g kotikesteks',
      params = {
        event = 'i13-coke:client:brickToPack10',
      }
    },
    {
      header = 'Brick → Kotike (1g)',
      txt = 'Paki brick lahti 1g kotikesteks',
      params = {
        event = 'i13-coke:client:brickToPack1',
      }
    },
    {
      header = 'Kotike (10g) → Kotike (1g)',
      txt = 'Paki 10g kotikesed lahti 1g kotikesteks',
      params = {
        event = 'i13-coke:client:pack10ToPack1',
      }
    },
    {
      header = '❌ Sulge',
      txt = '',
      params = {
        event = 'i13-menu:closeMenu'
      }
    }
  })
end)



RegisterNetEvent('i13-coke:client:brickToPack10', function()
  local dialog = exports['qb-input']:ShowInput({
    header = 'Brickide Kogus',
    submitText = 'Pakenda',
    inputs = {
      {
        text = 'Kogus',
        name = 'brickTo10PackNum',
        type = 'number',
        isRequired = true
      }
    }
  })
  if dialog then
    if not dialog.brickTo10PackNum then return end
    QBCore.Functions.TriggerCallback('i13-coke:server:checkBricks', function(result)
      if result then
        TriggerEvent('i13-coke:client:brickTo10g', dialog.brickTo10PackNum)
      else
        QBCore.Functions.Notify('Sul ei ole nii palju bricke', 'error')
      end
    end, dialog.brickTo10PackNum)
  end
end)

RegisterNetEvent('i13-coke:client:brickToPack1', function()
  local dialog = exports['qb-input']:ShowInput({
    header = 'Brickide Kogus',
    submitText = 'Pakenda',
    inputs = {
      {
        text = 'Kogus',
        name = 'brickTo1PackNum',
        type = 'number',
        isRequired = true
      }
    }
  })
  if dialog then
    if not dialog.brickTo1PackNum then return end
    QBCore.Functions.TriggerCallback('i13-coke:server:checkBricks', function(result)
      if result then
        TriggerEvent('i13-coke:client:brickTo1g', dialog.brickTo1PackNum)
      else
        QBCore.Functions.Notify('Sul ei ole nii palju bricke', 'error')
      end
    end, dialog.brickTo1PackNum)
  end
end)

RegisterNetEvent('i13-coke:client:pack10ToPack1', function()
  local dialog = exports['qb-input']:ShowInput({
    header = '10g Kotikeste Kogus',
    submitText = 'Pakenda',
    inputs = {
      {
        text = 'Kogus',
        name = 'pack10ToPack1Num',
        type = 'number',
        isRequired = true
      }
    }
  })
  if dialog then
    if not dialog.pack10ToPack1Num then return end
    QBCore.Functions.TriggerCallback('i13-coke:server:check10Pack', function(result)
      if result then
        TriggerEvent('i13-coke:client:10gTo1g', dialog.pack10ToPack1Num)
      else
        QBCore.Functions.Notify('Sul ei ole nii palju 10g kotikesi', 'error')
      end
    end, dialog.pack10ToPack1Num)
  end
end)