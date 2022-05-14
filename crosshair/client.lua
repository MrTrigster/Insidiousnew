
local on = true

local sniperHashes = {
	[1] = 100416529,
	[2] = 205991906,
	[3] = -952879014,
}



Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if on and IsAimCamActive() then
			if GetSelectedPedWeapon(ped) == sniperHashes[1] or GetSelectedPedWeapon(ped) == sniperHashes[2] or GetSelectedPedWeapon(ped) == sniperHashes[3] then
			else
				HideHudComponentThisFrame(14)
				drawCrosshair()
			end
		end
	Citizen.Wait(6)
	end
end)


RegisterNetEvent('cl:update_c')
AddEventHandler('cl:update_c', function(bool)
	on = bool
end)




-- RegisterCommand('togglecrosshair', function()
-- 	if on then
-- 		on = false
-- 	elseif not on then 
-- 		on = true
-- 	end
-- end)





function drawCrosshair()
	local sprite = DrawRect(0.5, 0.5, 0.001, 0.001, 255, 255, 255, 255)
end
