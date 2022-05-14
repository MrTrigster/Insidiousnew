local QBCore = exports['qb-core']:GetCoreObject()
local inCityhallPage = false
local qbCityhall = {}

qbCityhall.Open = function()
    SendNUIMessage({
        action = "open"
    })
    SetNuiFocus(true, true)
    inCityhallPage = true
end

qbCityhall.Close = function()
    SendNUIMessage({
        action = "close"
    })
    SetNuiFocus(false, false)
    inCityhallPage = false
end

DrawText3Ds = function(coords, text)
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

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    inCityhallPage = false
end)

local inRange = true

Citizen.CreateThread(function()
    CityhallBlip = AddBlipForCoord(Config.Cityhall.coords)

    SetBlipSprite (CityhallBlip, 498)
    SetBlipDisplay(CityhallBlip, 4)
    SetBlipScale  (CityhallBlip, 0.75)
    SetBlipAsShortRange(CityhallBlip, true)
    SetBlipColour(CityhallBlip, 0)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Linnahall")
    EndTextCommandSetBlipName(CityhallBlip)
end)

local creatingCompany = false
local currentName = nil
-- Citizen.CreateThread(function()
--     while true do

--         local ped = PlayerPedId()
--         local pos = GetEntityCoords(ped)
--         inRange = false

--         local dist = #(pos - Config.Cityhall.coords)
--         local dist2 = #(pos - Config.DrivingSchool.coords)

--         if dist < 20 then
--             inRange = true
--             DrawMarker(2, Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
--             if #(pos - vector3(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z)) < 1.5 then
--                 DrawText3Ds(Config.Cityhall.coords, '~g~E~w~ - Linnahalli Menu')
--                 if IsControlJustPressed(0, 38) then
--                     qbCityhall.Open()
--                 end
--             end
--         end

--         if not inRange then
--             Citizen.Wait(1000)
--         end

--         Citizen.Wait(2)
--     end
-- end)

RegisterNetEvent('i13-cityhall:client:openMenu', function()
    qbCityhall.Open()
end)

RegisterNetEvent('i13-cityhall:client:getIds')
AddEventHandler('i13-cityhall:client:getIds', function()
    TriggerServerEvent('i13-cityhall:server:getIDs')
end)

RegisterNetEvent('i13-cityhall:client:sendDriverEmail')
AddEventHandler('i13-cityhall:client:sendDriverEmail', function(charinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "Hr"
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = "Pr"
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('i13-phone:server:sendNewMail', {
            sender = "Township",
            subject = "Driving lessons request",
            message = "Hello " .. gender .. " " .. charinfo.lastname .. ",<br /><br />We have just received a message that someone wants to take driving lessons<br />If you are willing to teach, please contact us:<br />Naam: <strong>".. charinfo.firstname .. " " .. charinfo.lastname .. "</strong><br />Phone Number: <strong>"..charinfo.phone.."</strong><br/><br/>Kind regards,<br />Township Los Santos",
            button = {}
        })
    end)
end)

local idTypes = {
    ["id_card"] = {
        label = "ID Kaart",
        item = "id_card"
    },
    ["driver_license"] = {
        label = "Juhiluba",
        item = "driver_license"
    },
    ["pilot_license"] = {
        label = "Piloodiluba",
        item = "pilot_license"
    },
    ["weaponlicense"] = {
        label = "Relvaluba",
        item = "weaponlicense"
    }
}

RegisterNUICallback('requestId', function(data)
    if inRange then
        local idType = data.idType

        TriggerServerEvent('i13-cityhall:server:requestId', idTypes[idType])
        QBCore.Functions.Notify('Sa said '..idTypes[idType].label..' $50 eest', 'success', 3500)
    else
        QBCore.Functions.Notify('Sa ei saa seda teha', 'error')
    end
end)

RegisterNUICallback('requestLicenses', function(data, cb)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local licensesMeta = PlayerData.metadata["licences"]
    local availableLicenses = {}

    for type,_ in pairs(licensesMeta) do
        if licensesMeta[type] then
            local licenseType = nil
            local label = nil

            if type == "driver" then 
                licenseType = "driver_license" 
                label = "Juhiluba"
            elseif type == "pilot" then
                licenseType = "pilot_license"
                label = "Piloodiluba"
            elseif type == "weapon" then
                licenseType = "weaponlicense"
                label = "Relvaluba"
            end

            availableLicenses[#availableLicenses+1] = {
                idType = licenseType,
                label = label
            }
        end
    end
    cb(availableLicenses)
end)

RegisterNUICallback('applyJob', function(data)
    if inRange then
        TriggerServerEvent('i13-cityhall:server:ApplyJob', data.job)
    else
        QBCore.Functions.Notify('Sa ei saa seda teha', 'error')
    end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('cityhall', vector3(-552.99, -190.49, 38.22), 0.6, 4.05, {
        name = 'cityhall',
        heading = 30,
        debugPoly = false,
        minZ = 38.17,
        maxZ = 39.82
    }, {
        options = {
            {
                type = 'client',
                event = 'i13-cityhall:client:openMenu',
                icon = 'fas fa-clipboard',
                label = 'Taotle Dokumenti',
            },
        },
        distance = 2.0,
    })
end)