local density = {
    ['parked'] = 0.5,
    ['vehicle'] = 0.5,
    ['multiplier'] = 0.5,
    ['peds'] = 0.7,
    ['scenario'] = 0.5,
}

function DecorSet(Type, Value)
    if Type == 'parked' then
        density['parked'] = Value
    elseif Type == 'vehicle' then
        density['vehicle'] = Value
    elseif Type == 'multiplier' then
        density['multiplier'] = Value
    elseif Type == 'peds' then
        density['peds'] = Value
    elseif Type == 'scenario' then
        density['scenario'] = Value
    end
end

exports('DecorSet', DecorSet)

CreateThread(function()
	while true do
		SetParkedVehicleDensityMultiplierThisFrame(density['parked'])
		SetVehicleDensityMultiplierThisFrame(density['vehicle'])
		SetRandomVehicleDensityMultiplierThisFrame(density['multiplier'])
		SetPedDensityMultiplierThisFrame(density['peds'])
		SetScenarioPedDensityMultiplierThisFrame(density['scenario'], density['scenario']) -- Walking NPC Density
		Wait(0)
	end
end)

/* Clear Peds In Areas*/

CreateThread(function()
    while true do
        ClearAreaOfPeds(-516.58, -196.7, 38.22, 30.0, 0) -- Courtroom
        ClearAreaOfPeds(160.05, -3027.82, 6.86, 30.0, 0) -- Mechano
        ClearAreaOfPeds(-1286.49, -429.02, 34.77, 20.0, 0) -- Morningwoold Blvd Apartment
        Wait(0)
    end
end)