
-- target

CreateThread(function()
	exports['qb-target']:AddBoxZone("BurgerShotDuty", vector3(-1190.435, -902.3856, 14.91256), 0.4, 1.7, {
		name = "BurgerShotDuty",
		heading = 124.0,
		debugPoly = false,
		minZ=13.0,
		maxZ=15.0,
	}, {
		options = {
		    {  
			event = "qb-burgershot:DutyB",
			icon = "far fa-clipboard",
			label = "On Duty / Off Duty",
			job = "burgershot",
		    },
		},
		distance = 1.5
	})

		exports['qb-target']:AddBoxZone("burger_tray_1", vector3(-1193.84, -894.42, 14.0), 1.0, 0.6, {
			name = "burger_tray_1",
			heading = 303.25,
			debugPoly = false,
			minZ=13.8,
			maxZ=14.5,
		}, {
			options = {
			    {
				event = "qb-burgershot:Tray1",
				icon = "far fa-clipboard",
				label = "Kandik 1",
			    },
			},
			distance = 1.5
		})

	exports['qb-target']:AddBoxZone("burger_tray_2", vector3(-1194.86, -892.87, 14.0), 1.0, 0.6, {
		name="burger_tray_2",
		heading=304.09,
		debugPoly=false,
		minZ=13.8,
		maxZ=14.5,
	}, {
		options = {
		    {
			event = "qb-burgershot:Tray4",
			icon = "far fa-clipboard",
			label = "Kandik 2",
		    },
		},
		distance = 1.5
	})

	exports['qb-target']:AddBoxZone("burger_tray_3", vector3(-1195.85, -891.59, 14.0), 1.0, 0.9, {
		name="burger_tray_3",
		heading=303.94,
		debugPoly=false,
		minZ=13.8,
		maxZ=14.5,
	}, {
		options = {
		    {
			event = "qb-burgershot:Tray3",
			icon = "far fa-clipboard",
			label = "Kandik 3",
		    },
		},
		distance = 1.5
	})

    exports['qb-target']:AddBoxZone("burger_tray_4", vector3(-1193.81, -907.14, 13.98), 1.0, 1.3, {
		name="burger_tray_4",
		heading=351,
		debugPoly=false,
		minZ=13.63,
		maxZ=14.38,
	}, {
		options = {
		    {
			event = "qb-burgershot:Tray4",
			icon = "far fa-clipboard",
			label = "Drive Thru",
		    },
		},
		distance = 2.3
	})

	exports['qb-target']:AddBoxZone("burgershotcooker", vector3(-1202.73, -897.69, 14.0), 1.2, 0.7, {
		name="burgershotcooker",
		heading=124.49,
		debugPoly=false,
		minZ=13.4,
		maxZ=14.3,
	}, {
		options = {
			{
				event = "qb-burgershot:PattyFry",
				icon = "fas fa-hamburger",
				label = "Prae Burgereid",
				job = "burgershot",
			},
		},
		distance = 1.5
	})

	exports['qb-target']:AddBoxZone("burgershotcooker2", vector3(-1203.18, -897.01, 14.0), 1.2, 0.7, {
		name="burgershotcooker2",
		heading=121.45,
		debugPoly=false,
		minZ=13.4,
		maxZ=14.3,
	}, {
		options = {
			{
				event = "qb-burgershot:PattyFry",
				icon = "fas fa-hamburger",
				label = "Prae Burgereid",
				job = "burgershot",
			},
		},
		distance = 1.5
	})

		exports['qb-target']:AddBoxZone("burgershotfryer", vector3(-1201.8, -898.98, 14.0), 1.0, 2.0, {
		name="burgershotfryer",
		heading=124.01,
		debugPoly=false,
		minZ=13.8,
		maxZ=14.2,
		}, {
		    options = {
			    {
			        event = "qb-burgershot:Fries",
			        icon = "fas fa-box",
			        label = "Prae Friikaid",
			        job = "burgershot",
			    },
                {
                    event = "qb-burgershot:Donut",
                    icon = "fas fa-box",
                    label = "Prae Sõõrikuid",
                    job = "burgershot",
                },
		    },
		    distance = 1.5
		})


	exports['qb-target']:AddBoxZone("burgershotdrinks", vector3(-1199.54, -895.52, 14.0), 2.2, 0.6, {
	    name="burgershotdrinks",
	    heading=34,
	    debugPoly=false,
	    minZ=13.8,
	    maxZ=14.8,
	    }, {
		options = {
		    {
			event = "qb-menu:DrinkMenu",
			icon = "fas fa-filter",
			label = "Võta Jooki",
			job = "burgershot",
		    },
		},
		distance = 1.5
	    })

    exports['qb-target']:AddBoxZone("burgershotdrinks2", vector3(-1190.45, -904.73, 14.0), 1.0, 2.5, {
        name="burgershotdrinks2",
        heading=307.69,
        debugPoly=false,
        minZ=13.8,
        maxZ=14.8,
        }, {
            options = {
                {
                    event = "qb-menu:DrinkMenu",
                    icon = "fas fa-filter",
                    label = "Võta Jooki",
                    job = "burgershot",
                },
            },
            distance = 1.5
        })


    exports['qb-target']:AddBoxZone("burgerfridge", vector3(-1196.31, -901.8381, 14.0), 1.0, 1.0, {
        name="burgerfridge",
        heading=34.00,
        debugPoly=false,
        minZ=13.0,
        maxZ=15.6,
        }, {
            options = {
                {
                    event = "qb-menu:OrderMenu",
                    icon = "fas fa-laptop",
                    label = "Telli Koostisaineid",
                    job = "burgershot",
                },
            },
            distance = 1.5
        })

        exports['qb-target']:AddBoxZone("burgershotdisplay", vector3(-1197.78, -894.45, 14.0), 4.6, 1.2, {
            name="burgershotdisplay",
            heading=34,
            debugPoly=false,
            minZ=13.0,
            maxZ=14.8,
        }, {
                options = {
                    {
                        event = "qb-burgershot:Storage",
                        icon = "fas fa-box",
                        label = "Riiul",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


        exports['qb-target']:AddBoxZone("craftburger", vector3(-1198.41, -898.57, 14.0), 1.0, 1.5, {
            name="craftburger",
            heading=32.51,
            debugPoly=false,
            minZ=13.8,
            maxZ=14.2,
        }, {
                options = {
                    {
                        event = "qb-menu:Burgers",
                        icon = "fas fa-hand-holding",
                        label = "Valmista Burgereid",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


        exports['qb-target']:AddBoxZone("BurgerShot_register_1", vector3(-1196.5, -890.88, 14.0), 0.5, 0.4, {
            name="BurgerShot_register_1",
            debugPoly=false,
            heading=302.09,
            minZ=13.8,
            maxZ=14.4,
        }, {
                options = {
                    {
                        event = "qb-burgershot:bill",
                        parms = "1",
                        icon = "fas fa-credit-card",
                        label = "Tee Arve",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })

        exports['qb-target']:AddBoxZone("BurgerShot_register_2", vector3(-1195.41, -892.51, 14.0), 0.5, 0.4, {
            name="BurgerShot_register_2",
            debugPoly=false,
            heading=304.73,
            minZ=13.8,
            maxZ=14.4,
            }, {
                    options = {
                        {
                            event = "qb-burgershot:bill",
                            parms = "2",
                            icon = "fas fa-credit-card",
                            label = "Tee Arve",
                            job = "burgershot",
                        },
                    },
                    distance = 1.5
                })  


        exports['qb-target']:AddBoxZone("BurgerShot_register_3", vector3(-1194.38, -894.03, 14.0), 0.5, 0.4, {
            name="BurgerShot_register_3",
            debugPoly=false,
            heading=304.41,
            minZ=13.8,
            maxZ=14.4,
        }, {
            options = {
                {
                    event = "qb-burgershot:bill",
                    parms = "3",
                    icon = "fas fa-credit-card",
                    label = "Tee Arve",
                    job = "burgershot",
                },
            },
            distance = 1.5,
        })
        
        exports['qb-target']:AddBoxZone("BurgerShot_register_4", vector3(-1192.75, -906.45, 13.98), 0.5, 0.4, {
            name = "BurgerShot_register_4",
            heading = 55,
            debugPoly = false,
            minZ = 13.98,
            maxZ = 14.54
        }, {
            options = {
                {
                    event = "qb-burgershot:bill",
                    parms = "4",
                    icon = "fas fa-credit-card",
                    label = "Tee Arve",
                    job = "burgershot",
                },
            },
            distance = 2.3,
        })
end)


-- QB-Menu --

RegisterNetEvent('qb-menu:Burgers', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "| Saadaval Burgerid |",
            txt = "",
        },
        {
            header = "• Moneyshot Burger",
            txt = "Päts , Praetud Liha , Tomat , Kapsas",
            params = {
                event = "qb-burgershot:MoneyShot"
            }
        },
        {
            header = "• Meat Free Burger",
            txt = "Päts , Tomat , Kapsas",
            params = {
                event = "qb-burgershot:MeatFree"
            }
        },
        {
            header = "• Bleeder Burger",
            txt = "Päts , Praetud Liha , Tomat , Kapsas",
            params = {
                event = "qb-burgershot:BleederBurger"
            }
        },
        {
            header = "• The Heart Stopper",
            txt = "Päts , Praetud Liha , Tomat , Kapsas",
            params = {
                event = "qb-burgershot:HeartStopper"
            }
        },
        {
            header = "• Torpedo Roll",
            txt = "Päts , Praetud Liha",
            params = {
                event = "qb-burgershot:Torpedo"
            }
        },
        {
            header = "• Murder Meal",
            txt = "Heart Stopper, Friikad and Jook",
            params = {
                event = "qb-burgershot:CreateMurderMeal"
            }
        },
    })
end)


RegisterNetEvent('qb-menu:OrderMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "| Külmkapp |",
            txt = "",
        },
        {
            header = "• Telli Asju",
            txt = "Telli koostisosi juurde",
            params = {
                event = "qb-burgershot:shop"
            }
        },
        {
            header = "• Ava Külmkapp",
            txt = "Vaata külmkappi",
            params = {
                event = "qb-burgershot:Storage2"
            }
        },
    })
end)

RegisterNetEvent('qb-menu:DrinkMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "| Joogi Menu |",
            txt = "",
        },
        {
            header = "• Siirupiga Jook",
            txt = "Siirup",
            params = {
                event = "qb-burgershot:SoftDrink"
            }
        },
        {
            header = "• Milkshake",
            txt = "Kokteili segu",
            params = {
                event = "qb-burgershot:mShake"
            }
        },
        {
            header = "• Jäätis",
            txt = "Jäätise segu",
            params = {
                event = "qb-burgershot:IceCream"
            }
        },
    })
end)


-- Till Stuff --
--[[RegisterNetEvent("qb-burgershot:bill", function()
    local bill = exports["nh-keyboard"]:openKeyboard({
        header = "Tee Arve",
        rows = {
            {
                id = 0,
                txt = "Mängija ID"
            },
            {
                id = 1,
                txt = "Summa"
            }
        }
    })
    if bill ~= nil then
        if bill[1].input == nil or bill[2].input == nil then 
            return 
        end
        TriggerServerEvent("qb-burgershot:bill:player", bill[1].input, bill[2].input)
    end
end)]]

RegisterNetEvent("qb-burgershot:bill", function()
    local dialog = exports["qb-input"]:ShowInput({
        header = "Tee Arve",
        submitText = "Kinnita",
        inputs = {
            {
                text = 'Mängija ID',
                name = 'bspid',
                type = 'number',
                isRequired = true
            },
            {
                text = 'Summa',
                name = 'bssum',
                type = 'number',
                isRequired = true
            }
        }
    })
    if dialog then
        if not dialog.bspid or not dialog.bssum then 
            return 
        end
        TriggerServerEvent("qb-burgershot:bill:player", dialog.bspid, dialog.bssum)
    end
end)