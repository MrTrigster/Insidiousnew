local openid = false

RegisterNetEvent('i13-idcard:client:open', function(info,nui)
    if not openid then
        SetNuiFocusKeepInput(true)
        SetNuiFocus(true,false)
        SendNUIMessage({nui = nui,information = info})
        openid = true
    end
end)

RegisterNetEvent('i13-idcard:client:policebadgeanim', function()
    local ped = PlayerPedId()
    local propname = "prop_fib_badge"
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(propname), x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 28422)
    loadAnimDict("paper_1_rcm_alt1-9")
    AttachEntityToEntity(prop, ped, boneIndex, 0.12, 0.01, -0.06, -310.0, 10.0, 150.0, true, true, false, true, 1, true)
    TaskPlayAnim(ped, "paper_1_rcm_alt1-9", "player_one_dual-9", 3.0, -1, -1, 50, 0, false, false, false)
    Wait(3200)
    DeleteEntity(prop)
    ClearPedTasks(ped)
end)

RegisterNUICallback("escape", function()
    SetNuiFocus(false)
    openid = false
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

CreateThread(function()
    while true do
        if openid then
            DisableControlAction(0, 177, true) -- disable escape
            DisableControlAction(0, 200, true) -- disable escape
            DisableControlAction(0, 202, true) -- disable escape
            DisableControlAction(0, 322, true) -- disable escape
        end
        Wait(0)
    end
end)