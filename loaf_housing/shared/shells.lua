Categories = {
    ["mansion"] = {
        type = "house",
        price = {750000, 1250000},
        lockpick = 9,
        label = "Mansion"
    },
    ["highend_house"] = {
        type = "house",
        price = {500000, 750000},
        lockpick = 7,
        label = "Highend house"
    },
    ["midtier_house"] = {
        type = "house",
        price = {200000, 400000},
        lockpick = 5,
        label = "Midtier house"
    },
    ["lowtier_house"] = {
        type = "house",
        price = {100000, 200000},
        lockpick = 3,
        label = "Lowtier house"
    },
    ["shittier_house"] = {
        type = "house",
        price = {50000, 100000},
        lockpick = 2,
        label = "Shit tier house"
    },
    ["trailer"] = {
        type = "house",
        price = {20000, 60000},
        lockpick = 1,
        label = "Trailer"
    },
    ["highend_apartment"] = {
        type = "apartment",
        price = {300000, 600000},
        lockpick = 7,
        label = "Highend apartment"
    },
    ["lowtier_apartment"] = {
        type = "apartment",
        price = {50000, 100000},
        lockpick = 3,
        label = "Lowtier apartment"
    },
    
    -- unused shells for realtor job
    ["labs"] = {
        label = "Labs",
        lockpick = 5,
        type = "house"
    },
    ["misc"] = {
        label = "Misc shells",
        lockpick = 5,
        type = "house"
    },
}

Shells = {
    -- K4MB1 Free pack, get here: https://www.k4mb1maps.com/package/5015840
    ["Michael's house"] = {
        object = `shell_michael`,
        category = "highend_house",
        doorOffset = vector3(-9.356995, 5.597366, -5.053650),
        doorHeading = 267.43
    },
    ["Ranch"] = {
        object = `shell_ranch`,
        category = "mansion",
        doorOffset = vector3(-1.039246, -5.362000, -2.253075),
        doorHeading = 270.21
    },
    ["Midtier house 1"] = {
        object = `shell_trevor`,
        category = "midtier_house",
        doorOffset = vector3(0.179321, -3.609970, -1.397926),
        doorHeading = 358.43
    },
    ["Midtier house 2"] = {
        object = `shell_v16mid`,
        category = "midtier_house",
        doorOffset = vector3(1.422791, -14.005981, -1.482582),
        doorHeading = 359.82
    },
    ["Lowtier house 1"] = {
        object = `shell_frankaunt`,
        category = "lowtier_house",
        doorOffset = vector3(-0.355377, -5.689774, -1.559906),
        doorHeading = 0.92
    },
    ["Lowtier house 3"] = {
        object = `shell_lester`,
        category = "lowtier_house",
        doorOffset = vector3(-1.719360, -5.797150, -1.359543),
        doorHeading = 359.25
    },
    ["Trailer"] = {
        object = `shell_trailer`,
        category = "trailer",
        doorOffset = vector3(-1.378632, -1.774231, -1.469566),
        doorHeading = 359.1
    },
    ["Lowtier apartment 1"] = {
        object = `shell_v16low`,
        category = "lowtier_apartment",
        doorOffset = vector3(4.828278, -6.358368, -2.644226),
        doorHeading = 358.39
    },
    ["Store 1"] = {
        object = `shell_store1`,
        category = "shittier_house",
        doorOffset = vector3(-2.828491, 4.395538, -1.609535),
        doorHeading = 177.08
    },
}

local packs = {
    ["Main Housing Bundle"] = {
        ["Highend house 1"] = {
            object = `shell_highend`,
            category = "highend_house",
            doorOffset = vector3(-22.357116699219, -0.3636474609375, 6.2174072265625),
        },
        ["Highend house 2"] = {
            object = `shell_highendv2`,
            category = "highend_house",
            doorOffset = vector3(-10.472412109375, 0.82540893554688, 0.9453125),
        },
        ["Highend house 3"] = {
            object = `shell_banham`,
            category = "highend_house",
            doorOffset = vector3(-3.541870, -1.406586, 0.247009)
        },
        ["Highend house 4"] = {
            object = `shell_westons`,
            category = "highend_house",
            doorOffset = vector3(-1.497986, -26.218353, -3.424042)
        },
        ["Highend house 5"] = {
            object = `shell_westons2`,
            category = "highend_house",
            doorOffset = vector3(-1.830688, 10.169373, 0.359436)
        },
        ["Highend house 6"] = {
            object = `shell_apartment3`,
            category = "highend_house",
            doorOffset = vector3(11.407715, 4.407562, 1.019608)
        },
        ["Lowtier house 2"] = {
            object = `shell_medium2`,
            category = "lowtier_house",
            doorOffset = vector3(6.056335, 0.612488, -1.651062)
        },
        ["Abandoned house 1"] = {
            object = `shell_medium3`,
            category = "shittier_house",
            doorOffset = vector3(5.650635, -1.674377, 0.214783)
        },
        ["Highend apartment 1"] = {
            object = `shell_apartment1`,
            category = "highend_apartment",
            doorOffset = vector3(-2.098694, 8.670685, 2.212372)
        },
        ["Highend apartment 2"] = {
            object = `shell_apartment2`,
            category = "highend_apartment",
            doorOffset = vector3(-2.237366, 8.761261, 2.212280)
        },
    },
    ["Classic Housing"] = {
        ["Classic House 1"] = {
            object = `classichouse_shell`,
            category = "midtier_house",
            doorOffset = vector3(4.537659, -2.196472, -4.374573),
            doorHeading = 91.2
        },
        ["Classic House 2"] = {
            object = `classichouse2_shell`,
            category = "midtier_house",
            doorOffset = vector3(4.774780, -2.073151, -4.374695),
            doorHeading = 91.2
        },
        ["Classic House 3"] = {
            object = `classichouse2_shell`,
            category = "midtier_house",
            doorOffset = vector3(4.723450, -2.100891, -4.374527),
            doorHeading = 91.2
        },
    },
    ["Deluxe Housing V1"] = {
        ["Highend house 1"] = {
            object = `shell_highend`,
            category = "highend_house",
            doorOffset = vector3(-22.325378, -0.498352, 6.217514),
            doorHeading = 271.79
        },
        ["Highend house 2"] = {
            object = `shell_highendv2`,
            category = "highend_house",
            doorOffset = vector3(-10.382935, 0.870544, 0.944946),
            doorHeading = 271.15
        },
    },
    ["Hotel Housing"] = {
        ["Hotel 1"] = {
            object = `k4_hotel1_shell`,
            category = "highend_apartment",
            doorOffset = vector3(4.986877, 4.251617, -1.804993),
            doorHeading = 180.39
        },
        ["Hotel 2"] = {
            object = `k4_hotel2_shell`,
            category = "highend_apartment",
            doorOffset = vector3(5.039246, 4.268707, -1.804474),
            doorHeading = 180.39
        },
        ["Hotel 3"] = {
            object = `k4_hotel3_shell`,
            category = "highend_apartment",
            doorOffset = vector3(5.007324, 4.223480, -1.804291),
            doorHeading = 180.39
        },
    },
    ["Motel Housing"] = {
        ["Motel 1"] = {
            object = `k4_motel1_shell`,
            category = "highend_apartment",
            doorOffset = vector3(-0.328186, -2.484009, -1.546555),
            doorHeading = 271.6
        },
        ["Motel 2"] = {
            object = `k4_motel2_shell`,
            category = "highend_apartment",
            doorOffset = vector3(0.106079, -3.338165, -1.327591),
            doorHeading = 0.12
        },
        ["Motel 3"] = {
            object = `k4_motel3_shell`,
            category = "highend_apartment",
            doorOffset = vector3(3.187927, 3.312195, -1.511169),
            doorHeading = 181.84
        },
    },
    ["Highend Housing V1"] = {
        ["Highend house 3"] = {
            object = `shell_apartment1`,
            category = "highend_house",
            doorOffset = vector3(-2.132416, 8.975037, 2.212280),
            doorHeading = 182.54
        },
        ["Highend house 4"] = {
            object = `shell_apartment2`,
            category = "highend_house",
            doorOffset = vector3(-2.223877, 9.004517, 2.211990),
            doorHeading = 180.55
        },
        ["Highend house 5"] = {
            object = `shell_apartment3`,
            category = "highend_house",
            doorOffset = vector3(11.658600, 4.563660, 1.019623),
            doorHeading = 126.71
        }
    },
    ["Mansion Housing"] = {
        ["Mansion 1"] = {
            object = `k4_mansion_shell`,
            category = "mansion",
            doorOffset = vector3(-0.185608, -0.896973, 0.023514),
            doorHeading = 182.15
        },
        ["Mansion 2"] = {
            object = `k4_mansion2_shell`,
            category = "mansion",
            doorOffset = vector3(-0.200867, -0.800507, 0.023346),
            doorHeading = 182.15
        },
        ["Mansion 3"] = {
            object = `k4_mansion3_shell`,
            category = "mansion",
            doorOffset = vector3(-0.217621, -0.808746, 0.023773),
            doorHeading = 179.37
        },
    },
    ["Medium Housing V1"] = {
        ["Midtier house 5"] = {
            object = `shell_medium2`,
            category = "midtier_house",
            doorOffset = vector3(5.948669, 0.416565, -1.650894),
            doorHeading = 3.92
        },
        ["Abandoned house 1"] = {
            object = `shell_medium3`,
            category = "shittier_house",
            doorOffset = vector3(5.666534, -1.670715, 0.214752),
            doorHeading = 92.58
        }
    },
    ["Modern Housing V1"] = {
        ["Highend house 6"] = {
            object = `shell_banham`,
            category = "highend_house",
            doorOffset = vector3(-3.314056, -1.549011, 0.246765),
            doorHeading = 90.19
        },
        ["Highend house 10"] = {
            object = `shell_westons`,
            category = "highend_house",
            doorOffset = vector3(-1.260529, -26.391449, -3.424530),
            doorHeading = 37.83
        },
        ["Highend house 11"] = {
            object = `shell_westons2`,
            category = "highend_house",
            doorOffset = vector3(-1.701752, 10.514160, 0.359283),
            doorHeading = 179.36
        }
    },

    ["Default Housing V2"] = {
        ["Small Apartment 1"] = {
            object = `default_housing1_k4mb1`,
            category = "lowtier_apartment",
            doorOffset = vector3(-2.124664, -5.970886, -1.312775),
            doorHeading = 355.97,
        },
        ["Big Ranch"] = {
            object = `default_housing2_k4mb1`,
            category = "mansion",
            doorOffset = vector3(-5.536423, -5.079712, -1.588966),
            doorHeading = 275.31,
        },
        ["Small Trailer"] = {
            object = `default_housing3_k4mb1`,
            category = "trailer",
            doorOffset = vector3(-1.356216, -2.024475, -1.469528),
            doorHeading = 1.05,
        },
        ["Medium Apartment"] = {
            object = `default_housing4_k4mb1`,
            category = "midtier_house",
            doorOffset = vector3(0.213531, -3.805420, -1.398087),
            doorHeading = 0.99,
        },
        ["Medium Apartment 2"] = {
            object = `default_housing5_k4mb1`,
            category = "midtier_house",
            doorOffset = vector3(1.398178, -14.342346, -1.482666),
            doorHeading = 5.05,
        },
        ["Small Apartment 2"] = {
            object = `default_housing6_k4mb1`,
            category = "lowtier_apartment",
            doorOffset = vector3(4.920258, -6.579651, -2.644012),
            doorHeading = 2.39,
        },
    },
    ["Medium Housing V2"] = {
        ["Midtier house 3"] = {
            object = `medium_housing1_k4mb1`,
            category = "midtier_house",
            doorOffset = vector3(-0.296387, -5.744217, -1.559921),
            doorHeading = 0.42,
        },
        ["Midtier house 4"] = {
            object = `medium_housing2_k4mb1`,
            category = "midtier_house",
            doorOffset = vector3(6.056335, 0.381775, -1.651138),
            doorHeading = 0.7,
        },
        ["Abandoned house 2"] = {
            object = `medium_housing3_k4mb1`,
            category = "shittier_house",
            doorOffset = vector3(-2.568512, 7.621597, 0.199402),
            doorHeading = 180.0,
        },
    },
    ["Modern Housing V2"] = {
        ["Modern house 1"] = {
            object = `modern_housing1_k4mb1`,
            category = "highend_house",
            doorOffset = vector3(4.351013, 10.477249, 0.359467),
            doorHeading = 180.44,
        },
        ["Modern house 2"] = {
            object = `modern_housing2_k4mb1`,
            category = "highend_house",
            doorOffset = vector3(-1.686279, 10.579803, 0.359390),
            doorHeading = 180.44,
        },
        ["Modern house 3"] = {
            object = `modern_housing3_k4mb1`,
            category = "highend_house",
            doorOffset = vector3(-3.453003, -1.571716, 0.246948),
            doorHeading = 89.39,
        },
    },
    ["Deluxe Housing V2"] = {
        ["Deluxe house 1"] = {
            object = `deluxe_housing1_k4mb1`,
            category = "highend_house",
            doorOffset = vector3(-22.148254, -0.431564, 6.217285),
            doorHeading = 270.07,
        },
        ["Deluxe house 2"] = {
            object = `deluxe_housing2_k4mb1`,
            category = "highend_house",
            doorOffset = vector3(-10.189392, 0.855148, 0.945084),
            doorHeading = 271.16,
        },
        ["Deluxe house 3"] = {
            object = `deluxe_housing3_k4mb1`,
            category = "highend_house",
            doorOffset = vector3(-9.322937, 5.622025, -5.053497),
            doorHeading = 270.15,
        },
    },
    ["Highend Housing V2"] = {
        ["Highend house 7"] = {
            object = `highend_housing1_k4mb1`,
            category = "highend_house",
            doorOffset = vector3(-2.259796, 8.993820, 2.212219),
            doorHeading = 178.78,
        },
        ["Highend house 8"] = {
            object = `highend_housing2_k4mb1`,
            category = "highend_house",
            doorOffset = vector3(-2.188110, 8.993744, 2.212219),
            doorHeading = 179.41,
        },
        ["Highend house 9"] = {
            object = `highend_housing3_k4mb1`,
            category = "highend_house",
            doorOffset = vector3(11.569214, 4.509125, 1.019516),
            doorHeading = 128.7,
        },
    },

    ["Highend Lab Shells"] = {
        ["Highend coke lab"] = {
            object = `k4coke_shell`,
            category = "labs",
            doorOffset = vector3(-10.723022, -2.563919, -1.062996),
            doorHeading = 270.08
        },
        ["Highend meth lab"] = {
            object = `k4meth_shell`,
            category = "labs",
            doorOffset = vector3(-10.780869, -2.622086, -1.062897),
            doorHeading = 269.8
        },
        ["Highend weed lab"] = {
            object = `k4weed_shell`,
            category = "labs",
            doorOffset = vector3(-10.772614, -2.598846, -1.062897),
            doorHeading = 272.72
        }
    },
    ["Lab Shells Pack"] = {
        ["Empty coke lab"] = {
            object = `shell_coke1`,
            category = "labs",
            doorOffset = vector3(-6.326416, 8.641251, -1.948364),
            doorHeading = 182.98
        },
        ["Coke lab"] = {
            object = `shell_coke2`,
            category = "labs",
            doorOffset = vector3(-6.327118, 8.648651, -1.948761),
            doorHeading = 184.04
        },
        ["Meth lab"] = {
            object = `shell_meth`,
            category = "labs",
            doorOffset = vector3(-6.403137, 8.559357, -1.948273),
            doorHeading = 180.63,
        },
        ["Empty weed lab"] = {
            object = `shell_weed`,
            category = "labs",
            doorOffset = vector3(17.858093, 11.696640, -3.086426),
            doorHeading = 93.33
        },
        ["Weed lab"] = {
            object = `shell_weed2`,
            category = "labs",
            doorOffset = vector3(17.870911, 11.687469, -3.086548),
            doorHeading = 90.04
        }
    },
    ["Furnished Modern Hotels Pack"] = {
        ["Furnished hotel 1"] = {
            object = `modernhotel_shell`,
            category = "misc",
            doorOffset = vector3(4.956665, 4.050308, -1.807922),
            doorHeading = 182.18
        },
        ["Furnished hotel 2"] = {
            object = `modernhotel2_shell`,
            category = "misc",
            doorOffset = vector3(4.920517, 4.365280, -1.811432),
            doorHeading = 175.71
        },
        ["Furnished hotel 3"] = {
            object = `modernhotel3_shell`,
            category = "misc",
            doorOffset = vector3(5.002960, 4.375870, -1.811462),
            doorHeading = 178.49
        }
    },
    ["Furnished Housing"] = {
        ["Furnished house 1"] = {
            object = `furnitured_lowapart`,
            category = "misc",
            doorOffset = vector3(5.013443, -1.269882, -0.644531),
            doorHeading = 3.63
        },
        ["Furnished house 2"] = {
            object = `furnitured_midapart`,
            category = "misc",
            doorOffset = vector3(1.406723, -10.189880, -1.511597),
            doorHeading = 1.8
        },
        ["Furnished house 3"] = {
            object = `furnitured_motel`,
            category = "misc",
            doorOffset = vector3(-1.509644, -3.996979, -1.349945),
            doorHeading = 1.66
        }
    },
    ["Motel Shells Pack"] = {
        ["Furnished motel 1"] = {
            object = `classicmotel_shell`,
            category = "misc",
            doorOffset = vector3(0.131424, -3.669189, -1.327408),
            doorHeading = 2.43
        },
        ["Furnished motel 2"] = {
            object = `highendmotel_shell`,
            category = "misc",
            doorOffset = vector3(3.204941, 3.354507, -1.511139),
            doorHeading = 181.53 
        },
        ["Furnished motel 3"] = {
            object = `standardmotel_shell`,
            category = "misc",
            doorOffset = vector3(-0.441254, -2.415359, -1.546265),
            doorHeading = 271.4
        }
    },
    ["Stash Houses"] = {
        ["Stash house 1"] = {
            object = `container2_shell`,
            category = "misc",
            doorOffset = vector3(-0.077179, -5.721512, -1.203735),
            doorHeading = 357.07
        },
        ["Stash house 2"] = {
            object = `stashhouse1_shell`,
            category = "misc",
            doorOffset = vector3(21.528488, -0.566238, -3.060577),
            doorHeading = 88.44
        },
        ["Stash house 3"] = {
            object = `stashhouse3_shell`,
            category = "misc",
            doorOffset = vector3(-0.008041, 5.334122, -2.001892),
            doorHeading = 179.39
        }
    },
    ["Garage Shells Pack"] = {
        ["Garage 1"] = {
            object = `shell_garagel`,
            category = "misc",
            doorOffset = vector3(12.150574, -14.423569, -1.990234),
            doorHeading = 91.64
        },
        ["Garage 2"] = {
            object = `shell_garagem`,
            category = "misc",
            doorOffset = vector3(13.738968, 1.624313, -1.740143),
            doorHeading = 90.13
        },
        ["Garage 3"] = {
            object = `shell_garages`,
            category = "misc",
            doorOffset = vector3(5.762512, 3.820374, -1.490265),
            doorHeading = 182.22
        }
    },
    ["Office Shells Pack"] = {
        ["Office 1"] = {
            object = `shell_office1`,
            category = "misc",
            doorOffset = vector3(1.273163, 5.005173, -1.716003),
            doorHeading = 180.8
        },
        ["Office 2"] = {
            object = `shell_office2`,
            category = "misc",
            doorOffset = vector3(3.132797, -1.870438, -1.865112),
            doorHeading = 90.87
        },
        ["Office 3"] = {
            object = `shell_officebig`,
            category = "misc",
            doorOffset = vector3(-5.518173, -4.390808, -1.388123),
            doorHeading = 4.61
        }
    }
}

for pack, bought in pairs(Config.ShellPacks) do
    if bought then
        -- print(("Loading pack ^3%s^0"):format(pack))
        for shell, shellData in pairs(packs[pack]) do
            if not Shells[shell] then
                Shells[shell] = shellData
                -- print(("Added shell ^4%s^0 from pack ^3%s^0"):format(shell, pack))
            end
        end
    end
end

-- insert all started shells into categories
for label, data in pairs(Shells) do
    local categoryData = Categories[data.category]
    categoryData.shells = categoryData.shells or {}
    table.insert(categoryData.shells, label)
end
for _, category in pairs(Categories) do
    if not category.shells then
        category.shells = {}
    end
    table.sort(category.shells)
end

exports("GetShells", function()
    return Categories
end)

exports("GetShell", function(shell)
    return Shells[shell]
end)