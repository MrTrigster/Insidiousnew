local open = false

RegisterNUICallback('callback', function(data, cb)
	SetNuiFocus(false, false)
    Callbackk(data.success)
    open = false
    cb('ok')
end)

function OpenHackingGame(callback, blocks, speed)
    if not open then
        Callbackk = callback
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "open",
            blocks = blocks,
            speed = speed,
        })
    end
end

-- RegisterCommand("varhack",function()
--     exports['var']:OpenHackingGame(function(success)
--         if success then
--             print("success")
-- 		else
-- 			print("failed")
-- 		end
--     end, 5, 5)
-- end)