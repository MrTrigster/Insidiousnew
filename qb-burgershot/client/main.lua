QBCore = exports['qb-core']:GetCoreObject()

local onDuty = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	if PlayerData.job.onduty then
	    if PlayerData.job.name == "burgershot" then
		TriggerServerEvent("QBCore:ToggleDuty")
	    end
	end
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    if PlayerData.job.name == 'burgershot' then
    	onDuty = duty
    end
end)

CreateThread(function()
    BurgerShot = AddBlipForCoord(-1197.32, -897.655, 13.995)
    SetBlipSprite (BurgerShot, 106)
    SetBlipDisplay(BurgerShot, 4)
    SetBlipScale  (BurgerShot, 0.8)
    SetBlipAsShortRange(BurgerShot, true)
    SetBlipColour(BurgerShot, 75)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("BurgerShot")
    EndTextCommandSetBlipName(BurgerShot)
end) 

RegisterNetEvent("i13-burgershot:DutyB")
AddEventHandler("i13-burgershot:DutyB", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("i13-burgershot:Tray1")
AddEventHandler("i13-burgershot:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("i13-burgershot:Tray4")
AddEventHandler("i13-burgershot:Tray4", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray4")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray4", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("i13-burgershot:Tray3")
AddEventHandler("i13-burgershot:Tray3", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray3")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray3", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("i13-burgershot:Tray4")
AddEventHandler("i13-burgershot:Tray4", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray4")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray4", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("i13-burgershot:Storage")
AddEventHandler("i13-burgershot:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerstorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerstorage", {
        maxweight = 250000,
        slots = 40,
    })
end)

RegisterNetEvent("i13-burgershot:Storage2")
AddEventHandler("i13-burgershot:Storage2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerstorage2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerstorage2", {
        maxweight = 250000,
        slots = 40,
    })
end)

--Meal Creations
RegisterNetEvent("i13-burgershot:MurderMeal")
AddEventHandler("i13-burgershot:MurderMeal", function()
		local randomToy = math.random(1,10)
		--remove box
		TriggerServerEvent('QBCore:Server:RemoveItem', "burger-murdermeal", 1)
		--add items from box
		TriggerServerEvent('QBCore:Server:AddItem', "burger-heartstopper", 1)
		TriggerServerEvent('QBCore:Server:AddItem', "burger-softdrink", 1)
		TriggerServerEvent('QBCore:Server:AddItem', "burger-fries", 1)

		if randomToy < 4 then
			QBCore.Functions.Notify("Karbis ei olnud mänguasja", "error")
		elseif randomToy == 4 then
			TriggerServerEvent('QBCore:Server:AddItem', "burger-toy1", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-toy1"], "add")
		elseif randomToy < 10 and randomToy > 4 then
			QBCore.Functions.Notify("Karbis ei olnud mänguasja", "error")
		elseif randomToy == 10 then
			TriggerServerEvent('QBCore:Server:AddItem', "burger-toy2", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-toy2"], "add")
		else
            QBCore.Functions.Notify("Karbis ei olnud mänguasja", "error")
        end
end)

RegisterNetEvent("i13-burgershot:CreateMurderMeal")
AddEventHandler("i13-burgershot:CreateMurderMeal", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('i13-burgershot:server:get:ingredientMurderMeal', function(HasItems)
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Teeb Murder Meal'i...", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-fries", 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-heartstopper", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-softdrink", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-murdermeal", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-murdermeal"], "add")
                   	QBCore.Functions.Notify("Tegid Murder Meal'i", "success")
				end, function()
					QBCore.Functions.Notify("Tühistatud", "error")
				end)
			else
   				QBCore.Functions.Notify("Sul ei ole vajalikke asju", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Pead olema On-Duty", "error")
	end  
end)

RegisterNetEvent("i13-burgershot:BleederBurger")
AddEventHandler("i13-burgershot:BleederBurger", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('i13-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Teeb burgerit...", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-meat", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-tomato", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-bleeder", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-bleeder"], "add")
                    			QBCore.Functions.Notify("Sa tegid Bleeder Burgeri", "success")
				end, function()
					QBCore.Functions.Notify("Tühistatud", "error")
				end)
			else
   				QBCore.Functions.Notify("Sul ei ole vajalikke asju", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
	end
end)

RegisterNetEvent("i13-burgershot:MoneyShot")
AddEventHandler("i13-burgershot:MoneyShot", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('i13-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Teeb burgerit...", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-meat", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-tomato", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-moneyshot", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-moneyshot"], "add")
                    			QBCore.Functions.Notify("Sa tegid MoneyShot Burgeri", "success")
				end, function()
					QBCore.Functions.Notify("Tühistatud", "error")
				end)
			else
   				QBCore.Functions.Notify("Sul ei ole vajalikke asju", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
	end
end)

RegisterNetEvent("i13-burgershot:HeartStopper")
AddEventHandler("i13-burgershot:HeartStopper", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('i13-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Teeb burgerit...", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-meat", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-tomato", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-heartstopper", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-heartstopper"], "add")
                    			QBCore.Functions.Notify("Sa tegid Heart Stopper'i", "success")
				end, function()
					QBCore.Functions.Notify("Tühistatud", "error")
				end)
			else
   				QBCore.Functions.Notify("Sul ei ole vajalikke asju", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
	end
end)


RegisterNetEvent("i13-burgershot:Torpedo")
AddEventHandler("i13-burgershot:Torpedo", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('i13-burgershot:server:get:ingredientTorpedo', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Teeb Torpedo...", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-meat", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-torpedo", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-torpedo"], "add")
                    			QBCore.Functions.Notify("Sa tegid Torpedo", "success")
				end, function()
					QBCore.Functions.Notify("Tühistatud", "error")
				end)
			else
   				QBCore.Functions.Notify("Sul ei ole vajalikke asju", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
	end  
end)

RegisterNetEvent("i13-burgershot:MeatFree")
AddEventHandler("i13-burgershot:MeatFree", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('i13-burgershot:server:get:ingredientMeatfree', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Teeb burgerit...", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-tomato", 1)
                    			TriggerServerEvent('QBCore:Server:RemoveItem', "burger-lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-meatfree", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-meatfree"], "add")
                   			QBCore.Functions.Notify("Sa tegid Meat Free Burger'i", "success")
				end, function()
					QBCore.Functions.Notify("Tühistatud", "error")
				end)
			else
   				QBCore.Functions.Notify("Sul ei ole vajalikke asju", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
	end  
end)



RegisterNetEvent("i13-burgershot:SoftDrink")
AddEventHandler("i13-burgershot:SoftDrink", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeSoftDrink()
        else
            QBCore.Functions.Notify("Sul ei ole siirupit", "error")
        end
      end, 'burger-sodasyrup')
    else
        QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
    end
end)

RegisterNetEvent("i13-burgershot:mShake")
AddEventHandler("i13-burgershot:mShake", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeMShake()
        else
            QBCore.Functions.Notify("Sul ei ole Kokteili segu", "error")
        end
      end, 'burger-mshakeformula')
    else
        QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
    end
end)

RegisterNetEvent("i13-burgershot:IceCream")
AddEventHandler("i13-burgershot:IceCream", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeIceCream()
        else
            QBCore.Functions.Notify("Sul ei ole Jäätise segu", "error")
        end
      end, 'burger-icecreamformula')
    else
        QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
    end
end)

RegisterNetEvent("i13-burgershot:Fries")
AddEventHandler("i13-burgershot:Fries", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeFries()
        else
            QBCore.Functions.Notify("Sul ei ole kartuleid", "error")
        end
      end, 'burger-potato')
    else
        QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
    end
end)

RegisterNetEvent("i13-burgershot:Donut")
AddEventHandler("i13-burgershot:Donut", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeDonut()
        else
            QBCore.Functions.Notify("Sul ei ole taigent", "error")
        end
      end, 'burger-dough')
    else
        QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
    end
end)

RegisterNetEvent("i13-burgershot:PattyFry")
AddEventHandler("i13-burgershot:PattyFry", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakePatty()
        else
            QBCore.Functions.Notify("Sul ei ole toorest liha", "error")
        end
      end, 'burger-raw')
    else
        QBCore.Functions.Notify("Sa pead olema On-Duty", "error")
    end
end)

-- Functions --
function MakeFries()
	TriggerServerEvent('QBCore:Server:RemoveItem', "burger-potato", 1)
	QBCore.Functions.Progressbar("pickup", "Valmistab friikaid...", 4000, false, true, {
	    disableMovement = true,
	    disableCarMovement = true,
	    disableMouse = false,
	    disableCombat = true,
	},{
	    animDict = "amb@prop_human_bbq@male@base",
	    anim = "base",
	    flags = 8,
	    }, {
		model = "prop_cs_fork",
		bone = 28422,
		coords = vector3(-0.005, 0.00, 0.00),
		rotation = vector3(175.0, 160.0, 0.0),
	    }
	)
	Wait(4000)
	TriggerServerEvent('QBCore:Server:AddItem', "burger-fries", 5)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-fries"], "add")
	QBCore.Functions.Notify("Sa tegid 5 friikat", "success")
	StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function MakeDonut()
	TriggerServerEvent('QBCore:Server:RemoveItem', "burger-dough", 1)
	QBCore.Functions.Progressbar("pickup", "Valmistab sõõrikuid...", 4000, false, true, {
	    disableMovement = true,
	    disableCarMovement = true,
	    disableMouse = false,
	    disableCombat = true,
	},{
	    animDict = "amb@prop_human_bbq@male@base",
	    anim = "base",
	    flags = 8,
	    }, {
		model = "prop_cs_fork",
		bone = 28422,
		coords = vector3(-0.005, 0.00, 0.00),
		rotation = vector3(175.0, 160.0, 0.0),
	    }
	)
	Wait(4000)
	TriggerServerEvent('QBCore:Server:AddItem', "burger-donut", 2)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-donut"], "add")
	QBCore.Functions.Notify("Sa tegid 2 sõõrikut", "success")
	StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function MakePatty()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-raw", 1)
    QBCore.Functions.Progressbar("pickup", "Praeb liha...", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = vector3(-0.005, 0.00, 0.00),
        rotation = vector3(175.0, 160.0, 0.0),
    }    
)
    Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-meat", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-meat"], "add")
    QBCore.Functions.Notify("Sa praadisid liha", "success")
    StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function MakeSoftDrink()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-sodasyrup", 1)
    QBCore.Functions.Progressbar("pickup", "Täidab topsi...", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-softdrink", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-softdrink"], "add")
    QBCore.Functions.Notify("Täitsid topsi", "success")
end  


function MakeMShake()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-mshakeformula", 1)
    QBCore.Functions.Progressbar("pickup", "Täidab topsi...", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-mshake", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-mshake"], "add")
    QBCore.Functions.Notify("Täitsid topsi", "success")
end  

function MakeIceCream()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-icecreamformula", 1)
    QBCore.Functions.Progressbar("pickup", "Valmistab jäätist...", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-icecream", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-icecream"], "add")
    QBCore.Functions.Notify("Valmistasid jäätise", "success")
end
   
RegisterNetEvent("i13-burgershot:shop")
AddEventHandler("i13-burgershot:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "burgershot", Config.Items)
end)
