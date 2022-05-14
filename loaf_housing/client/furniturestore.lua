RegisterNetEvent("loaf_housing:furniture_store", function(coords)
    while cache.busy do
        if Config.FurnitureStoreLight then
            DrawLightWithRange(coords, 255, 255, 255, 50.0, 25.0)
        end
        
        DisableAllControlActions(0)
        DisableAllControlActions(1)
        DisableAllControlActions(2)
        Wait(0)
    end
end)

function BrowseFurniture()
    cache.busy = true

    DoScreenFadeOut(750)
    while not IsScreenFadedOut() do Wait(0) end

    local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
    SetCamCoord(cam, Config.FurnitureStore.Camera)
    RenderScriptCams(1, 0, 0, 1, 1)
    SetCamActive(cam, true) 
    SetCamFov(cam, 50.0)
    FreezeEntityPosition(PlayerPedId(), true)
    SetFocusPosAndVel(Config.FurnitureStore.Interior, 0.0, 0.0, 0.0)
    SetCamRot(cam, Config.FurnitureStore.CameraRotation, 2)

    Wait(500)
    DoScreenFadeIn(750)

    local currentCategory, currentObject, pressDelay = 1, 1, 0
    local furnitureObject, furnitureAttachments
    local addedLights

    local helpText = Strings["furniture_browsing"]

    local function ShowHelpText(confirm)
        local furnitureData = Furniture[currentCategory].furniture[currentObject]

        if confirm then
            AddTextEntry(GetCurrentResourceName().."current_helptext_furniture", Strings["furniture_confirm"]:format(furnitureData.label, furnitureData.price))
        else
            AddTextEntry(GetCurrentResourceName().."current_helptext_furniture", Strings["furniture_browsing"]:format(
                Furniture[currentCategory].label,
                furnitureData.storage and Strings["furniture_is_storage"] or "",
                currentObject, #Furniture[currentCategory].furniture,
                currentCategory, #Furniture,
                furnitureData.label,
                furnitureData.price
            ))
        end
        BeginTextCommandDisplayHelp(GetCurrentResourceName().."current_helptext_furniture")
        EndTextCommandDisplayHelp(0, true, false, 0)
    end

    local function CreateFurniture()
        ShowHelpText(false)
        local furnitureData = Furniture[currentCategory].furniture[currentObject]

        if DoesEntityExist(furnitureObject) then
            DeleteEntity(furnitureObject) 
        end
        if furnitureAttachments then
            for _, entity in pairs(furnitureAttachments) do
                DeleteEntity(entity)
            end
            furnitureAttachments = nil
        end
        StartLoading(Strings["loading_object"])
        local model = lib.LoadModel(furnitureData.object)
        BusyspinnerOff()
        if not model.success then 
            Notify(Strings["couldnt_load"]:format(furnitureData.object))
            return 
        end
        furnitureObject = CreateObject(model.model, Config.FurnitureStore.Interior)
        SetEntityHeading(furnitureObject, Config.FurnitureStore.Heading)
        if not addedLights then
            addedLights = true
            TriggerEvent("loaf_housing:furniture_store", GetOffsetFromEntityInWorldCoords(furnitureObject, 0.0, -5.0, 2.0))
        end
        if not furnitureData.attached then 
            return 
        end
        furnitureAttachments = {}
        for _, attachment in pairs(furnitureData.attached) do
            StartLoading(Strings["loading_object"])
            local model = lib.LoadModel(attachment.object)
            BusyspinnerOff()
            if model.success then
                local attached = CreateObject(model.model, GetEntityCoords(furnitureObject), false, true)
                FreezeEntityPosition(attached, true)
                table.insert(furnitureAttachments, attached)
        
                AttachEntityToEntity(attached, furnitureObject, 0, attachment.offset.xyz, vector3(0.0, 0.0, attachment.offset.w), false, false, false, false, 2, true)
            else
                Notify(Strings["couldnt_load"]:format(furnitureData.object))
            end
        end
    end

    CreateFurniture()
    
    while true do
        if pressDelay <= GetGameTimer() then
            if IsDisabledControlPressed(0, 299) then -- down arrow
                pressDelay = GetGameTimer() + 200
                if Furniture[currentCategory - 1] then
                    currentCategory = currentCategory - 1
                else
                    currentCategory = #Furniture
                end
                currentObject = 1
                CreateFurniture()
            elseif IsDisabledControlPressed(0, 300) then -- up arrow
                pressDelay = GetGameTimer() + 200
                if Furniture[currentCategory + 1] then
                    currentCategory = currentCategory + 1
                else
                    currentCategory = 1
                end
                currentObject = 1
                CreateFurniture()
            elseif IsDisabledControlPressed(0, 307) then -- right arrow
                pressDelay = GetGameTimer() + 200
                if Furniture[currentCategory].furniture[currentObject + 1] then
                    currentObject = currentObject + 1
                else
                    currentObject = 1
                end
                CreateFurniture()
            elseif IsDisabledControlPressed(0, 308) then -- left arrow
                pressDelay = GetGameTimer() + 200
                if Furniture[currentCategory].furniture[currentObject - 1] then
                    currentObject = currentObject - 1
                else
                    currentObject = #Furniture[currentCategory].furniture
                end
                CreateFurniture()
            end
        end
        
        if IsDisabledControlPressed(0, 34) then -- A
            SetEntityHeading(furnitureObject, GetEntityHeading(furnitureObject) - 1.0)
        elseif IsDisabledControlPressed(0, 35) then -- D
            SetEntityHeading(furnitureObject, GetEntityHeading(furnitureObject) + 1.0)
        end

        if IsDisabledControlPressed(0, 32) then -- W
            local rot = GetCamRot(cam, 2)
            if rot.x < -20.0 then
                SetCamRot(cam, rot.x + 0.1, rot.y, rot.z, 2)
            end
        elseif IsDisabledControlPressed(0, 33) then -- S
            local rot = GetCamRot(cam, 2)
            if rot.x > -35.0 then
                SetCamRot(cam, rot.x - 0.1, rot.y, rot.z, 2)
            end
        end

        if IsDisabledControlPressed(0, 241) and GetCamFov(cam) > 5.0 then -- Scrollwheel (up)
            SetCamFov(cam, GetCamFov(cam) - 0.5)
        elseif IsDisabledControlPressed(0, 242) and GetCamFov(cam) < 100.0 then -- Scrollwheel (down)
            SetCamFov(cam, GetCamFov(cam) + 0.5)
        end

        if IsDisabledControlJustReleased(0, 191) then -- enter
            Wait(50)
            
            local furnitureData = Furniture[currentCategory].furniture[currentObject]
            ShowHelpText(true)

            while true do
                if IsDisabledControlJustReleased(0, 191) then -- enter
                    StartLoading(Strings["processing_payment"])
                    local success = lib.TriggerCallbackSync("loaf_housing:purchase_furniture", currentCategory, currentObject)
                    if success then
                        Notify(Strings["purchased_furniture"]:format(furnitureData.label, furnitureData.price))
                    end
                    BusyspinnerOff()
                end

                if IsDisabledControlJustReleased(0, 194) then -- backspace
                    Wait(50)
                    break
                end

                Wait(0)
            end

            ShowHelpText(false)
        end

        if IsDisabledControlJustReleased(0, 194) then -- backspace
            break
        end

        Wait(0)
    end

    FreezeEntityPosition(PlayerPedId(), false)

    DoScreenFadeOut(750)
    while not IsScreenFadedOut() do Wait(0) end

    ClearFocus()
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam)

    if DoesEntityExist(furnitureObject) then
        DeleteEntity(furnitureObject)
    end
    for _, attached in pairs(furnitureAttachments or {}) do
        DeleteEntity(attached)
    end

    ClearHelpText()
    Wait(500)
    DoScreenFadeIn(750)
    cache.busy = false
end

function FurnitureMarker(action)
    if cache.busy then return end
    if action == "use" then
        FurnitureStoreMenu()
    elseif action == "exit" then
        CloseMenu()
    end
end

CreateThread(function()
    while not loaded do Wait(500) end

    local blipData = Config.Blip.furnitureStore
    if blipData.enabled then
        cache.furnitureBlip = lib.AddBlip({
            coords = Config.FurnitureStore.Entrance.xyz,
            sprite = blipData.sprite,
            color = blipData.color,
            scale = blipData.scale,
            label = Strings["furniture_blip"]
        })
    end

    cache.furnitureMarker = lib.AddMarker({
        coords = Config.FurnitureStore.Entrance.xyz - vec3(0.0,0.0,1.0),
        type = 1,
        callbackData = {
            enter = "enter",
            press = "use",
            exit = "exit"
        },
        key = "primary",
        text = Strings["furniture_marker"],
    }, FurnitureMarker, FurnitureMarker, FurnitureMarker)
end)