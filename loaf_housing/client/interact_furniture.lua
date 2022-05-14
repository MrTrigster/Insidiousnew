-- this file handles interactable furniture, such as poledancing, sitting in chairs etc
local interactableFurniture = {
    ["prop_strip_pole_01"] = {
        useText = "Poledance",
        stopText = "Stop poledancing",

        offset = vector3(0.0, 0.3, 1.0),
        rotation = vector3(0.0, 0.0, 0.0),
        anim = function()
            local randomDance = math.random(1, 3)
            return "mini@strip_club@pole_dance@pole_dance" .. randomDance, "pd_dance_0" .. randomDance
        end
    },
    ["apa_mp_h_stn_chairarm_01"] = {
        useText = "Sit down",
        stopText = "Stop sitting",

        offset = vector3(0.0, -0.25, 0.6),
        rotation = function(chair)
            if GetEntityHeading(chair) >= 180.0 then
                return vector3(0.0, 0.0, GetEntityHeading(chair) - 179.9)
            end
            
            return vector3(0.0, 0.0, GetEntityHeading(chair) + 179.9)
        end,
        anim = {"mini@strip_club@lap_dance_2g@ld_2g_reach", "ld_2g_sit_idle"}
    },
}

local busy
local function UseFurniture(data) 
    if busy then
        return
    end

    local furnitureName, object = table.unpack(data)
    busy = true
    local furnitureData = interactableFurniture[furnitureName]
    local offset = GetOffsetFromEntityInWorldCoords(object, furnitureData.offset)

    local anim, dict
    if type(furnitureData.anim) == "function" then
        anim, dict = furnitureData.anim()
    else
        anim, dict = table.unpack(furnitureData.anim)
    end
    
    lib.LoadAnimDict(dict)
    local rotation 
    if type(furnitureData.rotation) == "vector3" then
        rotation = furnitureData.rotation
    else
        rotation = furnitureData.rotation(object)
    end
        
    local scene = NetworkCreateSynchronisedScene(offset, rotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, anim, dict, 1.5, -4.0, 1, 1, 1148846080, 0)
    NetworkStartSynchronisedScene(scene)

    lib.HideHelpText()

    AddTextEntry(GetCurrentResourceName().."current_helptext_interactable", "~INPUT_VEH_DUCK~ " .. furnitureData.stopText)
    BeginTextCommandDisplayHelp(GetCurrentResourceName().."current_helptext_interactable")
    EndTextCommandDisplayHelp(0, true, false, 0)

    while true do
        Wait(0)

        if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
            break
        end
    end

    ClearHelpText()
    NetworkStopSynchronisedScene(scene)
    busy = false
end

local markers = {}
function LoadInteractableFurniture(furnitureObject, furnitureName, furnitureId)
    if not Config.InteractableFurniture or markers[furnitureId] or not interactableFurniture[furnitureName] then
        return
    end

    markers[furnitureId] = lib.AddMarker({
        coords = GetEntityCoords(furnitureObject),
        type = 1,
        alpha = 0,
        scale = vector3(2.0, 2.0, 2.0),
        callbackData = {
            press = {furnitureName, furnitureObject}
        },
        key = "secondary",
        text = interactableFurniture[furnitureName].useText
    }, nil, nil, UseFurniture)
end

function RemoveInteractableFurniture(furnitureId)
    if not Config.InteractableFurniture then
        return
    end

    if furnitureId == "REMOVE_ALL" then
        for _, v in pairs(markers) do
            lib.RemoveMarker(v)
        end
        markers = {}
        return
    end

    if markers[furnitureId] then
        lib.RemoveMarker(markers[furnitureId])
        markers[furnitureId] = nil
    end
end