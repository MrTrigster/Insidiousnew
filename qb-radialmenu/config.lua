Config = {}

Config.MenuItems = {
    [1] = {
        id = 'citizen',
        title = 'Tegevused',
        icon = 'user',
        items = {
            -- {
            --     id = 'givenum',
            --     title = 'Anna Kontaktandmed',
            --     icon = 'address-book',
            --     type = 'client',
            --     event = 'qb-phone:client:GiveContactDetails',
            --     shouldClose = true
            -- }, 
            {
                id = 'cornerselling',
                title = 'Müü Narkot',
                icon = 'cannabis',
                type = 'client',
                event = 'qb-drugs:client:cornerselling',
                shouldClose = true
            }, {
                id = 'clothesmenu',
                title = 'Riietus',
                icon = 'tshirt',
                items = {
                    {
                        id = 'Hair',
                        title = 'Hair',
                        icon = 'user',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Ear',
                        title = 'Ear Piece',
                        icon = 'deaf',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleProps',
                        shouldClose = true
                    }, {
                        id = 'Neck',
                        title = 'Neck',
                        icon = 'user-tie',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Top',
                        title = 'Top',
                        icon = 'tshirt',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Shirt',
                        title = 'Shirt',
                        icon = 'tshirt',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Pants',
                        title = 'Pants',
                        icon = 'user',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Shoes',
                        title = 'Shoes',
                        icon = 'shoe-prints',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'meer',
                        title = 'Extras',
                        icon = 'plus',
                        items = {
                            {
                                id = 'Hat',
                                title = 'Hat',
                                icon = 'hat-cowboy-side',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Glasses',
                                title = 'Glasses',
                                icon = 'glasses',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Visor',
                                title = 'Visor',
                                icon = 'hat-cowboy-side',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Mask',
                                title = 'Mask',
                                icon = 'theater-masks',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                shouldClose = true
                            }, {
                                id = 'Vest',
                                title = 'Vest',
                                icon = 'vest',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                shouldClose = true
                            }, {
                                id = 'Bag',
                                title = 'Bag',
                                icon = 'shopping-bag',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                shouldClose = true
                            }, {
                                id = 'Bracelet',
                                title = 'Bracelet',
                                icon = 'user',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Watch',
                                title = 'Watch',
                                icon = 'stopwatch',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Gloves',
                                title = 'Gloves',
                                icon = 'mitten',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                shouldClose = true
                            }
                        }
                    }
                }
            },
        }
    },
    [2] = {
        id = 'interactions',
        title = 'Interact',
        icon = 'exclamation-triangle',
        items = {
            {
                id = 'stealplayer',
                title = 'Röövi',
                icon = 'mask',
                type = 'client',
                event = 'police:client:RobPlayer',
                shouldClose = true
            }, 
            {
                id = 'escort2',
                title = 'Tiri',
                icon = 'user-friends',
                type = 'client',
                event = 'police:client:EscortPlayer',
                shouldClose = true
            },
            {
                id = 'flipvehicle',
                title = 'Flipi Sõiduk',
                icon = 'truck-pickup',
                type = 'client',
                event = 'qb-radialmenu:client:flipvehicle',
                shouldClose = true
             }
        }
    },
    [3] = {
        id = 'vehicle',
        title = 'Auto',
        icon = 'car',
        items = {
            {
                id = 'vehiclemenu',
                title = 'Menüü',
                icon = 'car',
                type = 'client',
                event = 'vehcontrol:openVehControl',
                shouldClose = true,
            },
            {
                id = 'driftmode',
                title = 'Drift Mode',
                icon = 'car-side',
                type = 'client',
                event = 'qbdriftmode:DriftMode',
                shouldClose = true
            },
            {
                id = 'vehicleextras',
                title = 'Vehicle Extras',
                icon = 'plus',
                items = {
                    {
                        id = 'extra1',
                        title = 'Extra 1',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra2',
                        title = 'Extra 2',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra3',
                        title = 'Extra 3',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra4',
                        title = 'Extra 4',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra5',
                        title = 'Extra 5',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra6',
                        title = 'Extra 6',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra7',
                        title = 'Extra 7',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra8',
                        title = 'Extra 8',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra9',
                        title = 'Extra 9',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra10',
                        title = 'Extra 10',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra11',
                        title = 'Extra 11',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra12',
                        title = 'Extra 12',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    }, {
                        id = 'extra13',
                        title = 'Extra 13',
                        icon = 'box-open',
                        type = 'client',
                        event = 'qb-radialmenu:client:setExtra',
                        shouldClose = false
                    },
                },
            },
        },
    },
}

Config.JobInteractions = {
    ["ambulance"] = {
        {
            id = 'statuscheck',
            title = 'Kontrolli Seisundit',
            icon = 'heartbeat',
            type = 'client',
            event = 'hospital:client:CheckStatus',
            shouldClose = true
        },{
            id = 'revivep',
            title = 'Revive',
            icon = 'user-md',
            type = 'client',
            event = 'hospital:client:RevivePlayer',
            shouldClose = true
        },{
            id = 'treatwounds',
            title = 'Heal',
            icon = 'band-aid',
            type = 'client',
            event = 'hospital:client:TreatWounds',
            shouldClose = true
        },{
            id = 'escort',
            title = 'Tiri',
            icon = 'user-friends',
            type = 'client',
            event = 'police:client:EscortPlayer',
            shouldClose = true
        }, {
            id = 'emsmdt',
            title = 'MDT',
            icon = 'tablet-alt',
            type = 'command',
            event = 'mdt',
            shouldClose = true
        }, {
            id = 'emsradios',
            title = 'Raadiokanalid',
            icon = 'info-circle',
            items = {
                {
                    id = 'emsjoinradio1',
                    title = 'Kanal 1',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel1',
                    shouldClose = true
                }, {
                    id = 'emsjoinradio2',
                    title = 'Kanal 2',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel2',
                    shouldClose = true
                }, {
                    id = 'emsjoinradio3',
                    title = 'Kanal 3',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel3',
                    shouldClose = true
                }, {
                    id = 'emsjoinradio4',
                    title = 'Kanal 4',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel4',
                    shouldClose = true
                }, {
                    id = 'emsjoinradio5',
                    title = 'Kanal 5',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel5',
                    shouldClose = true
                }, {
                    id = 'emsjoinradio6',
                    title = 'Kanal 6',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel6',
                    shouldClose = true
                }
            }
        },
    },
    ["taxi"] = {
        {
            id = 'togglemeter',
            title = 'Näita/Peida Mõõtja',
            icon = 'eye-slash',
            type = 'client',
            event = 'qb-taxi:client:toggleMeter',
            shouldClose = false
        }, {
            id = 'togglemouse',
            title = 'Alusta/Peata Mõõtja',
            icon = 'hourglass-start',
            type = 'client',
            event = 'qb-taxi:client:enableMeter',
            shouldClose = true
        }, {
            id = 'npc_mission',
            title = 'NPC Sõit',
            icon = 'taxi',
            type = 'client',
            event = 'qb-taxi:client:DoTaxiNpc',
            shouldClose = true
        }
    },
    ["mechanic"] = {
        {
            id = 'towvehicle',
            title = 'Vea Sõidukit',
            icon = 'truck-pickup',
            type = 'client',
            event = 'qb-tow:client:TowVehicle',
            shouldClose = true
        }
    },
    ["news"] = {
        {
            id = 'newscam',
            title = 'Kaamera',
            icon = 'camera',
            type = 'client',
            event = 'Cam:ToggleCam',
            shouldClose = true
        },
        {
            id = 'newsmic',
            title = 'Mikrofon',
            icon = 'microphone',
            type = 'client',
            event = 'Mic:ToggleMic',
            shouldClose = true
        },
        {
            id = 'newsbmic',
            title = 'Boom Mikrofon',
            icon = 'microphone',
            type = 'client',
            event = 'Mic:ToggleBMic',
            shouldClose = true
        },
    },
    ["police"] = {
        {
            id = 'statuscheck',
            title = 'Kontrolli Tervise Seisundit',
            icon = 'heartbeat',
            type = 'client',
            event = 'hospital:client:CheckStatus',
            shouldClose = true
        }, {
            id = 'checkstatus',
            title = 'Kontrolli Seisundit',
            icon = 'question',
            type = 'client',
            event = 'police:client:CheckStatus',
            shouldClose = true
        }, {
            id = 'escort',
            title = 'Tiri',
            icon = 'user-friends',
            type = 'client',
            event = 'police:client:EscortPlayer',
            shouldClose = true
        }, {
            id = 'searchplayer',
            title = 'Otsi Läbi',
            icon = 'search',
            type = 'client',
            event = 'police:client:SearchPlayer',
            shouldClose = true
        }, {
            id = 'mdt',
            title = 'MDT',
            icon = 'tablet-alt',
            type = 'command',
            event = 'mdt',
            shouldClose = true
        }, {
            id = 'pdradios',
            title = 'Raadiokanalid',
            icon = 'info-circle',
            items = {
                {
                    id = 'pdjoinradio1',
                    title = 'Kanal 1',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel1',
                    shouldClose = true
                }, {
                    id = 'pdjoinradio2',
                    title = 'Kanal 2',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel2',
                    shouldClose = true
                }, {
                    id = 'pdjoinradio3',
                    title = 'Kanal 3',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel3',
                    shouldClose = true
                }, {
                    id = 'pdjoinradio4',
                    title = 'Kanal 4',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel4',
                    shouldClose = true
                }, {
                    id = 'pdjoinradio5',
                    title = 'Kanal 5',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel5',
                    shouldClose = true
                }, {
                    id = 'pdjoinradio6',
                    title = 'Kanal 6',
                    icon = 'info-circle',
                    type = 'client',
                    event = 'qb-radio:client:JoinRadioChannel6',
                    shouldClose = true
                }
            }
        }, {
            id = 'policeobjects',
            title = 'Objects',
            icon = 'road',
            items = {
                {
                    id = 'spawnpion',
                    title = 'Cone',
                    icon = 'exclamation-triangle',
                    type = 'client',
                    event = 'police:client:spawnCone',
                    shouldClose = false
                }, {
                    id = 'spawnhek',
                    title = 'Gate',
                    icon = 'torii-gate',
                    type = 'client',
                    event = 'police:client:spawnBarrier',
                    shouldClose = false
                }, {
                    id = 'spawnschotten',
                    title = 'Speed Limit Sign',
                    icon = 'sign',
                    type = 'client',
                    event = 'police:client:spawnRoadSign',
                    shouldClose = false
                }, {
                    id = 'spawntent',
                    title = 'Tent',
                    icon = 'campground',
                    type = 'client',
                    event = 'police:client:spawnTent',
                    shouldClose = false
                }, {
                    id = 'spawnverlichting',
                    title = 'Lighting',
                    icon = 'lightbulb',
                    type = 'client',
                    event = 'police:client:spawnLight',
                    shouldClose = false
                }, {
                    id = 'deleteobject',
                    title = 'Remove object',
                    icon = 'trash',
                    type = 'client',
                    event = 'police:client:deleteObject',
                    shouldClose = false
                }
            }
        }
    },
    -- ["hotdog"] = {
    --     {
    --         id = 'togglesell',
    --         title = 'Alusta/Lõpeta Müük',
    --         icon = 'hotdog',
    --         type = 'client',
    --         event = 'qb-hotdogjob:client:ToggleSell',
    --         shouldClose = true
    --     }
    -- }
    -- ["taxi"] = {

    -- },
}

Config.TrunkClasses = {
    [0] = {allowed = true, x = 0.0, y = -1.5, z = 0.10}, -- Compacts
    [1] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sedans
    [2] = {allowed = true, x = 0.0, y = -1.0, z = 0.15}, -- SUVs
    [3] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes
    [4] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Muscle
    [5] = {allowed = true, x = 0.0, y = -2.0, z = 0.05}, -- Sports Classics
    [6] = {allowed = true, x = 0.0, y = -2.0, z = 0.05}, -- Sports
    [7] = {allowed = true, x = 0.0, y = -2.0, z = 0.20}, -- Super
    [8] = {allowed = false, x = 0.0, y = -1.0, z = 0.25}, -- Motorcycles
    [9] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Off-road
    [10] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Industrial
    [11] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Utility
    [12] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Vans
    [13] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Cycles
    [14] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Boats
    [15] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Helicopters
    [16] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Planes
    [17] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Service
    [18] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Emergency
    [19] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Military
    [20] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Commercial
    [21] = {allowed = true, x = 0.0, y = -1.0, z = 0.25} -- Trains
}

Config.ExtrasEnabled = true

Config.Commands = {
    ["top"] = {
        Func = function() ToggleClothing("Top") end,
        Sprite = "top",
        Desc = "Take your shirt off/on",
        Button = 1,
        Name = "Torso"
    },
    ["gloves"] = {
        Func = function() ToggleClothing("Gloves") end,
        Sprite = "gloves",
        Desc = "Take your gloves off/on",
        Button = 2,
        Name = "Gloves"
    },
    ["visor"] = {
        Func = function() ToggleProps("Visor") end,
        Sprite = "visor",
        Desc = "Toggle hat variation",
        Button = 3,
        Name = "Visor"
    },
    ["bag"] = {
        Func = function() ToggleClothing("Bag") end,
        Sprite = "bag",
        Desc = "Opens or closes your bag",
        Button = 8,
        Name = "Bag"
    },
    ["shoes"] = {
        Func = function() ToggleClothing("Shoes") end,
        Sprite = "shoes",
        Desc = "Take your shoes off/on",
        Button = 5,
        Name = "Shoes"
    },
    ["vest"] = {
        Func = function() ToggleClothing("Vest") end,
        Sprite = "vest",
        Desc = "Take your vest off/on",
        Button = 14,
        Name = "Vest"
    },
    ["hair"] = {
        Func = function() ToggleClothing("Hair") end,
        Sprite = "hair",
        Desc = "Put your hair up/down/in a bun/ponytail.",
        Button = 7,
        Name = "Hair"
    },
    ["hat"] = {
        Func = function() ToggleProps("Hat") end,
        Sprite = "hat",
        Desc = "Take your hat off/on",
        Button = 4,
        Name = "Hat"
    },
    ["glasses"] = {
        Func = function() ToggleProps("Glasses") end,
        Sprite = "glasses",
        Desc = "Take your glasses off/on",
        Button = 9,
        Name = "Glasses"
    },
    ["ear"] = {
        Func = function() ToggleProps("Ear") end,
        Sprite = "ear",
        Desc = "Take your ear accessory off/on",
        Button = 10,
        Name = "Ear"
    },
    ["neck"] = {
        Func = function() ToggleClothing("Neck") end,
        Sprite = "neck",
        Desc = "Take your neck accessory off/on",
        Button = 11,
        Name = "Neck"
    },
    ["watch"] = {
        Func = function() ToggleProps("Watch") end,
        Sprite = "watch",
        Desc = "Take your watch off/on",
        Button = 12,
        Name = "Watch",
        Rotation = 5.0
    },
    ["bracelet"] = {
        Func = function() ToggleProps("Bracelet") end,
        Sprite = "bracelet",
        Desc = "Take your bracelet off/on",
        Button = 13,
        Name = "Bracelet"
    },
    ["mask"] = {
        Func = function() ToggleClothing("Mask") end,
        Sprite = "mask",
        Desc = "Take your mask off/on",
        Button = 6,
        Name = "Mask"
    }
}

local Bags = {[40] = true, [41] = true, [44] = true, [45] = true}

Config.ExtraCommands = {
    ["pants"] = {
        Func = function() ToggleClothing("Pants", true) end,
        Sprite = "pants",
        Desc = "Take your pants off/on",
        Name = "Pants",
        OffsetX = -0.04,
        OffsetY = 0.0
    },
    ["shirt"] = {
        Func = function() ToggleClothing("Shirt", true) end,
        Sprite = "shirt",
        Desc = "Take your shirt off/on",
        Name = "shirt",
        OffsetX = 0.04,
        OffsetY = 0.0
    },
    ["reset"] = {
        Func = function()
            if not ResetClothing(true) then
                Notify('Nothing To Reset', 'error')
            end
        end,
        Sprite = "reset",
        Desc = "Revert everything back to normal",
        Name = "reset",
        OffsetX = 0.12,
        OffsetY = 0.2,
        Rotate = true
    },
    ["bagoff"] = {
        Func = function() ToggleClothing("Bagoff", true) end,
        Sprite = "bagoff",
        SpriteFunc = function()
            local Bag = GetPedDrawableVariation(PlayerPedId(), 5)
            local BagOff = LastEquipped["Bagoff"]
            if LastEquipped["Bagoff"] then
                if Bags[BagOff.Drawable] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            end
            if Bag ~= 0 then
                if Bags[Bag] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            else
                return false
            end
        end,
        Desc = "Take your bag off/on",
        Name = "bagoff",
        OffsetX = -0.12,
        OffsetY = 0.2
    }
}
