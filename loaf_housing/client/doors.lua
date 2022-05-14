local propertiesWithDoors = {}

local function HandleLocking()
    while true do
        Wait(1000)

        for property, propertyData in pairs(propertiesWithDoors) do
            for door, doorData in pairs(propertyData.doors) do
                local doorLocked = GlobalState["loaf_housing_"..property.."_"..door] ~= true
                local doorObj = GetClosestObjectOfType(doorData.coords.xyz, 4.0, doorData.object)
                if DoesEntityExist(doorObj) then
                    FreezeEntityPosition(doorObj, doorLocked)
                    if doorLocked and math.abs(GetEntityHeading(doorObj) - doorData.coords.w) > 5.0 then
                        SetEntityHeading(doorObj, doorData.coords.w)
                    end
                end
            end
        end
    end
end

local function DrawLockedState()
    while true do
        Wait(1000)

        local playerPed = PlayerPedId()
        for property, propertyData in pairs(propertiesWithDoors) do
            for door, doorData in pairs(propertyData.doors) do
                local doorObj = GetClosestObjectOfType(doorData.coords.xyz, 4.0, doorData.object)
                local doorCoords = GetEntityCoords(doorObj)
                
                if #(GetEntityCoords(playerPed) - doorCoords) <= 2.0 then
                    while #(GetEntityCoords(playerPed) - doorCoords) <= 2.0 do
                        Wait(0)
                        Draw3DText(GlobalState["loaf_housing_"..property.."_"..door] ~= true and Strings["locked"] or Strings["unlocked"], doorCoords)
                    end
                    collectgarbage()
                end
            end
        end
    end
end

function RefreshHouseDoors()
    propertiesWithDoors = {}
    for property, propertyData in pairs(Houses) do
        if propertyData.interiortype == "walkin" then
            propertiesWithDoors[property] = propertyData
        end
    end
end

CreateThread(function()
    while not loaded do Wait(500) end
    Wait(500)

    RefreshHouseDoors()

    CreateThread(DrawLockedState)
    CreateThread(HandleLocking)
end)