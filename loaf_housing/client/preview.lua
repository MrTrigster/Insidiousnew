CreateThread(function()
    if not Config.PreviewProperty then 
        return
    end

    while not loaded do
        Wait(500)
    end

    local position = vector3(-4000.0, -8250.0, 1250.0) -- the position where shells are spawned when previewing

    local function RefreshShell(category, shellId)
        local shell = Shells[Categories[category].shells[shellId]]
        local shell_model = lib.LoadModel(shell.object)

        if cache.shell then
            DeleteEntity(cache.shell)
        end
        DoScreenFadeOut(0)
        cache.shell = CreateObject(shell_model.model, position, false, false, false)
        SetEntityHeading(cache.shell, 0.0)
        FreezeEntityPosition(cache.shell, true)

        local doorPosition = GetOffsetFromEntityInWorldCoords(cache.shell, shell.doorOffset)
        Teleport(doorPosition)
        DoScreenFadeIn(500)

        return doorPosition
    end

    function PreviewProperty(propertyId)
        local propertyData = Houses[propertyId]
        if cache.busy or cache.inInstance or not propertyData then 
            return 
        end

        if not lib.TriggerCallbackSync("loaf_housing:preview_property", propertyId) then
            return
        end

        local previousCoords, previousHeading = GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId())

        CloseMenu()
        
        cache.inInstance = true

        local maxShells, currentShell, doorPosition = 0
        if propertyData.interiortype == "shell" then
            if propertyData.shell then
                for i, shell in pairs(Categories[propertyData.category].shells) do
                    if shell == propertyData.shell then
                        currentShell = i
                        break
                    end
                end
            else
                maxShells = #Categories[propertyData.category].shells
                currentShell = 1
            end

            print(currentShell)
            doorPosition = RefreshShell(propertyData.category, currentShell)
            TriggerEvent("loaf_housing:weather_sync")
        elseif propertyData.interiortype == "interior" then
            DoScreenFadeOut(750)
            while not IsScreenFadedOut() do
                Wait(0)
            end

            local interiorData = Config.Interiors[propertyData.interior]
            if interiorData.ipl then
                RequestIpl(interiorData.ipl)
                while not IsIplActive(interiorData.ipl) do
                    Wait(250)
                    print("loading interior")
                end
            end

            Teleport(interiorData.coords)
            DoScreenFadeIn(500)

            doorPosition = interiorData.coords
        end
        RefreshConceal()

        while cache.inInstance do
            local txt = Strings["previewing_nohelp"]
            
            if maxShells > 1 then
                txt = Strings["previewing"]:format(currentShell, maxShells, Categories[propertyData.category].shells[currentShell])

                if IsDisabledControlJustReleased(0, 175) then -- right arrow
                    if currentShell + 1 <= maxShells then
                        currentShell += 1
                    else
                        currentShell = 1
                    end
                    RefreshShell(propertyData.category, currentShell)
                elseif IsDisabledControlJustReleased(0, 174) then -- left arrow
                    if currentShell - 1 > 0 then
                        currentShell -= 1
                    else
                        currentShell = maxShells
                    end
                    RefreshShell(propertyData.category, currentShell)
                end
            end

            if IsDisabledControlJustReleased(0, 194) then -- backspace
                cache.inInstance = false
            end
            
            AddTextEntry(GetCurrentResourceName() .. "preview", txt)
            BeginTextCommandDisplayHelp(GetCurrentResourceName() .. "preview")
            EndTextCommandDisplayHelp(0, 0, 0, -1)

            if #(GetEntityCoords(PlayerPedId()) - doorPosition) > 100.0 then
                SetEntityCoords(PlayerPedId(), doorPosition)
            end
            
            Wait(0)
        end

        TriggerServerEvent("loaf_housing:stop_previewing")

        ClearHelpText()

        DoScreenFadeOut(750)
        while not IsScreenFadedOut() do
            Wait(0)
        end

        if DoesEntityExist(cache.shell) then
            DeleteEntity(cache.shell)
        end
        cache.shell = nil
        
        Teleport(propertyData.entrance - vector4(0.0, 0.0, 1.0, 0.0))
        DoScreenFadeIn(500)
    end
end)