-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local requiredItemsShowed = false
local requiredItems = {[1] = {name = QBCore.Shared.Items["cryptostick"]["name"], image = QBCore.Shared.Items["cryptostick"]["image"]}}

-- Functions

local function DrawText3Ds(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function ExchangeSuccess()
	TriggerServerEvent('i13-crypto:server:ExchangeSuccess', math.random(1, 10))
end

local function ExchangeFail()
	local Odd = 5
	local RemoveChance = math.random(1, Odd)
	local LosingNumber = math.random(1, Odd)
	if RemoveChance == LosingNumber then
		TriggerServerEvent('i13-crypto:server:ExchangeFail')
		TriggerServerEvent('i13-crypto:server:SyncReboot')
	end
end

local function SystemCrashCooldown()
	CreateThread(function()
		while Crypto.Exchange.RebootInfo.state do
			if (Crypto.Exchange.RebootInfo.percentage + 1) <= 100 then
				Crypto.Exchange.RebootInfo.percentage = Crypto.Exchange.RebootInfo.percentage + 1
				TriggerServerEvent('i13-crypto:server:Rebooting', true, Crypto.Exchange.RebootInfo.percentage)
			else
				Crypto.Exchange.RebootInfo.percentage = 0
				Crypto.Exchange.RebootInfo.state = false
				TriggerServerEvent('i13-crypto:server:Rebooting', false, 0)
			end
			Wait(1200)
		end
	end)
end

local function HackingSuccess(success)
    if success then
		TriggerEvent('mhacking:hide')
        ExchangeSuccess()
    else
		TriggerEvent('mhacking:hide')
		ExchangeFail()
	end
end

--[[CreateThread(function()
	while true do
		sleep = 5000
		if LocalPlayer.state['isLoggedIn'] then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			local dist = #(pos - Crypto.Exchange.coords)
			if dist < 15 then
				sleep = 5
				if dist < 1.5 then
					if not Crypto.Exchange.RebootInfo.state then
						DrawText3Ds(Crypto.Exchange.coords, '~g~E~w~ - Sisesta USB')
						if not requiredItemsShowed then
							requiredItemsShowed = true
							TriggerEvent('inventory:client:requiredItems', requiredItems, true)
						end
						
						if IsControlJustPressed(0, 38) then
							QBCore.Functions.TriggerCallback('i13-crypto:server:HasSticky', function(HasItem)
								if HasItem then
									--TriggerEvent("mhacking:show")
									--TriggerEvent("mhacking:start", math.random(4, 6), 45, HackingSuccess)
									exports["memorygame"]:thermiteminigame(9, 1, 2, 7,
    										function() -- success
        										--print("success")
												ExchangeSuccess()
    										end,
    										function() -- failure
        										--print("failure")
												ExchangeFail()
    									end)
								else
									QBCore.Functions.Notify('Sul ei ole Cryptostick', 'error')
								end
							end)
						end
					else
						DrawText3Ds(Crypto.Exchange.coords, 'S??steem teeb rebooti - '..Crypto.Exchange.RebootInfo.percentage..'%')
					end
				else
					if requiredItemsShowed then
						requiredItemsShowed = false
						TriggerEvent('inventory:client:requiredItems', requiredItems, false)
					end
				end
			end
		end
		Wait(sleep)
	end
end) ]]

-- Events

RegisterNetEvent('i13-crypto:client:useStick', function()
	if not Crypto.Exchange.RebootInfo.state then
		QBCore.Functions.TriggerCallback('i13-crypto:server:HasSticky', function(HasItem)
			if HasItem then
				exports["memorygame"]:thermiteminigame(9, 1, 2, 7,
    			function() -- success
					ExchangeSuccess()
    			end,
    			function() -- failure
					ExchangeFail()
    			end)
			else
				QBCore.Functions.Notify('Sul ei ole Cryptostick\'i', 'error')
			end
		end)
	else
		QBCore.Functions.Notify('S??steem teeb rebooti', 'error')
	end
end)

RegisterNetEvent('i13-crypto:client:SyncReboot', function()
	Crypto.Exchange.RebootInfo.state = true
	SystemCrashCooldown()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	isLoggedIn = true
	TriggerServerEvent('i13-crypto:server:FetchWorth')
	TriggerServerEvent('i13-crypto:server:GetRebootState')
end)

RegisterNetEvent('i13-crypto:client:UpdateCryptoWorth', function(crypto, amount, history)
	Crypto.Worth[crypto] = amount
	if history ~= nil then
		Crypto.History[crypto] = history
	end
end)

RegisterNetEvent('i13-crypto:client:GetRebootState', function(RebootInfo)
	if RebootInfo.state then
		Crypto.Exchange.RebootInfo.state = RebootInfo.state
		Crypto.Exchange.RebootInfo.percentage = RebootInfo.percentage
		SystemCrashCooldown()
	end
end)

-- Threads

CreateThread(function()
	exports['qb-target']:AddBoxZone('crypt', vector3(-1056.31, -232.31, 44.02), 1.2, 1.0, {
		name = 'crypt',
		heading = 28.0,
		debugPoly = false,
		minZ = 43.82,
		maxZ = 44.82
	}, {
		options = {
			{
				type = 'client',
				event = 'i13-crypto:client:useStick',
				icon = 'fab fa-bitcoin',
				label = 'Sisesta Cryptostick',
			}
		},
		distance = 1.7,
	})
end)