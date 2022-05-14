CreateThread(function()
	while true do
		Wait(1)
		id = PlayerId()
		DisablePlayerVehicleRewards(id)	
	end
end)
