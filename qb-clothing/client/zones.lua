local QBCore = exports['qb-core']:GetCoreObject()
local textShown = false

local function listenClothesControls()
    textShown = true
    CreateThread(function()
        while textShown do
            if IsControlJustReleased(0, 38) then
                customCamLocation = nil
                QBCore.Functions.TriggerCallback('i13-clothing:server:getOutfits', function(result)
                    openMenu({
                        {menu = "character", label = "Riided", selected = true},
                        {menu = "accessoires", label = "Aksessuaarid", selected = false},
                        {menu = "myOutfits", label = "Minu Outfitid", selected = false, outfits = result}
                    })
                    setCurrentStore('clothing')
                end)
                textShown = false
            end
            Wait(1)
        end  
    end)
end

local function listenHairControls()
    textShown = true
    CreateThread(function()
        while textShown do
            if IsControlJustReleased(0, 38) then
                customCamLocation = nil
                openMenu({
                    {menu = "clothing", label = "Juuksur", selected = true},
                })
                setCurrentStore('hair')
                textShown = false
            end
            Wait(1)
        end  
    end)
end

local function listenSurgeonControls()
    textShown = true
    CreateThread(function()
        while textShown do
            if IsControlJustReleased(0, 38) then
                customCamLocation = nil
                openMenu({
                    {menu = "face", label = "Nägu", selected = true},
                })
                setCurrentStore('surgery')
                textShown = false
            end
            Wait(1)
        end  
    end)
end

-- Clothes
CreateThread(function()
    local clothesZone = BoxZone:Create(vector3(423.29, -808.42, 29.49), 3.0, 4.0, {
        name="clothesZone",
        heading=0,
        debugPoly=false,
        minZ=28.49,
        maxZ=31.09
    })

    clothesZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone2 = BoxZone:Create(vector3(77.76, -1390.72, 29.39), 3.0, 4.0, {
        name="clothesZone2",
        heading=0,
        debugPoly=false,
        minZ=28.39,
        maxZ=31.19
    })

    clothesZone2:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone3 = BoxZone:Create(vector3(-819.2, -1074.69, 11.34), 3.0, 4.0, {
        name="clothesZone3",
        heading=300,
        --debugPoly=true,
        minZ=10.34,
        maxZ=13.14
    })

    clothesZone3:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone4 = BoxZone:Create(vector3(-804.41, -598.98, 30.28), 3.0, 4.0, {
        name="clothesZone4",
        heading=60,
        --debugPoly=true,
        minZ=29.28,
        maxZ=31.88
    })

    clothesZone4:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone5 = BoxZone:Create(vector3(-160.8, -302.53, 39.73), 3.0, 4.0, {
        name="clothesZone5",
        heading=70,
        --debugPoly=true,
        minZ=38.73,
        maxZ=41.13
    })

    clothesZone5:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone6 = BoxZone:Create(vector3(123.89, -219.6, 54.56), 3.0, 4.0, {
        name="clothesZone6",
        heading=70,
        --debugPoly=true,
        minZ=53.56,
        maxZ=55.96
    })

    clothesZone6:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone7 = BoxZone:Create(vector3(-711.25, -155.09, 37.42), 3.0, 4.0, {
        name="clothesZone7",
        heading=300,
        --debugPoly=true,
        minZ=36.42,
        maxZ=38.82
    })

    clothesZone7:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone8 = BoxZone:Create(vector3(-1452.97, -236.76, 49.8), 3.0, 4.0, {
        name="clothesZone8",
        heading=47,
        --debugPoly=true,
        minZ=48.8,
        maxZ=51.2
    })

    clothesZone8:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone9 = BoxZone:Create(vector3(-1193.81, -772.56, 17.32), 3.0, 4.0, {
        name="clothesZone9",
        heading=37,
        --debugPoly=true,
        minZ=16.32,
        maxZ=18.72
    })

    clothesZone9:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone10 = BoxZone:Create(vector3(-3172.33, 1048.08, 20.86), 3.0, 4.0, {
        name="clothesZone10",
        heading=67,
        --debugPoly=true,
        minZ=19.86,
        maxZ=22.26
    })

    clothesZone10:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone11 = BoxZone:Create(vector3(-1098.22, 2710.25, 19.12), 3.0, 4.0, {
        name="clothesZone11",
        heading=312,
        --debugPoly=true,
        minZ=18.12,
        maxZ=20.52
    })

    clothesZone11:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone12 = BoxZone:Create(vector3(617.8, 2759.71, 42.09), 3.0, 4.0, {
        name="clothesZone12",
        heading=274,
        --debugPoly=true,
        minZ=41.09,
        maxZ=43.29
    })

    clothesZone12:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone13 = BoxZone:Create(vector3(1198.85, 2707.78, 38.23), 3.0, 4.0, {
        name="clothesZone13",
        heading=270,
        --debugPoly=true,
        minZ=37.23,
        maxZ=39.63
    })

    clothesZone13:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone14 = BoxZone:Create(vector3(1691.73, 4820.31, 42.07), 3.0, 4.0, {
        name="clothesZone14",
        heading=7,
        --debugPoly=true,
        minZ=41.07,
        maxZ=43.27
    })

    clothesZone14:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZone15 = BoxZone:Create(vector3(1.53, 6512.81, 31.89), 3.0, 4.0, {
        name="clothesZone15",
        heading=314,
        --debugPoly=true,
        minZ=30.89,
        maxZ=33.09
    })

    clothesZone15:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local clothesZoneCasino = BoxZone:Create(vector3(925.29, 21.63, 71.83), 3.0, 4.0, {
        name="clothesCasino",
        heading=103,
        --debugPoly=true,
        minZ=70.83,
        maxZ=73.83
    })

    clothesZoneCasino:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenClothesControls()
            exports['qb-drawtext']:DrawText('[E] - Riidepood', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)
end)

-- Hairdresser
CreateThread(function()
    local hairZone = BoxZone:Create(vector3(-815.96, -184.92, 37.57), 3.0, 4.0, {
        name="hairZone",
        heading=30,
        --debugPoly=true,
        minZ=36.57,
        maxZ=39.17
    })

    hairZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenHairControls()
            exports['qb-drawtext']:DrawText('[E] - Juuksur', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local hairZone2 = BoxZone:Create(vector3(136.85, -1708.56, 29.29), 3.0, 4.0, {
        name="hairZone2",
        heading=50,
        --debugPoly=true,
        minZ=28.29,
        maxZ=30.89
    })

    hairZone2:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenHairControls()
            exports['qb-drawtext']:DrawText('[E] - Juuksur', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local hairZone3 = BoxZone:Create(vector3(-1283.28, -1117.43, 6.99), 3.0, 4.0, {
        name="hairZone3",
        heading=0,
        --debugPoly=true,
        minZ=5.99,
        maxZ=8.59
    })

    hairZone3:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenHairControls()
            exports['qb-drawtext']:DrawText('[E] - Juuksur', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local hairZone4 = BoxZone:Create(vector3(1932.14, 3729.94, 32.84), 3.0, 4.0, {
        name="hairZone4",
        heading=300,
        --debugPoly=true,
        minZ=31.84,
        maxZ=34.04
    })

    hairZone4:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenHairControls()
            exports['qb-drawtext']:DrawText('[E] - Juuksur', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local hairZone5 = BoxZone:Create(vector3(1211.83, -472.85, 66.21), 3.0, 4.0, {
        name="hairZone5",
        heading=345,
        --debugPoly=true,
        minZ=65.21,
        maxZ=67.81
    })

    hairZone5:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenHairControls()
            exports['qb-drawtext']:DrawText('[E] - Juuksur', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local hairZone6 = BoxZone:Create(vector3(-32.97, -151.88, 57.08), 3.0, 4.0, {
        name="hairZone6",
        heading=70,
        --debugPoly=true,
        minZ=56.08,
        maxZ=58.48
    })

    hairZone6:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenHairControls()
            exports['qb-drawtext']:DrawText('[E] - Juuksur', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)

    local hairZone7 = BoxZone:Create(vector3(-278.75, 6228.35, 31.7), 3.0, 4.0, {
        name="hairZone7",
        heading=315,
        --debugPoly=true,
        minZ=30.7,
        maxZ=32.9
    })

    hairZone7:onPlayerInOut(function(isPointInside)
        if isPointInside then
            listenHairControls()
            exports['qb-drawtext']:DrawText('[E] - Juuksur', 'left')
        else
            textShown = false
            exports['qb-drawtext']:HideText()
        end
    end)
end)