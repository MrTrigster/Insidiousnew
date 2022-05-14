local QBCore = exports['qb-core']:GetCoreObject()

local PlayerGang = {}
local isLoggedIn = false
local isInMenu = false
local inRange = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerGang = QBCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
	isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerGang = GangInfo
end)

-- MENU
local menu = MenuV:CreateMenu(false, 'Gangi Boss Menu', 'topright', 68, 68, 68, 'size-125', 'none', 'menuv', 'main')
local menu2 = MenuV:CreateMenu(false, 'Gangi Raha', 'topright', 68, 68, 68, 'size-125', 'none', 'menuv', 'society')
local menu3 = MenuV:CreateMenu(false, 'Liikmete Haldamine', 'topright', 68, 68, 68, 'size-125', 'none', 'menuv', 'employees')
local menu4 = MenuV:CreateMenu(false, 'Värbamise Menu', 'topright', 68, 68, 68, 'size-125', 'none', 'menuv', 'recruit')

RegisterNetEvent('i13-gangmenu:client:openMenu')
AddEventHandler('i13-gangmenu:client:openMenu', function()
    MenuV:OpenMenu(menu)
end)

local menu_button = menu:AddButton({
    icon = '📋',
    label = 'Liikmed',
    value = menu3,
    description = 'Halda Liikmeid'
})
local menu_button1 = menu:AddButton({
    icon = '🤝',
    label = 'Värbamine',
    value = menu4,
    description = 'Värba Uusi Liikmeid'
})
local menu_button2 = menu:AddButton({
    icon = '📦',
    label = 'Kapp',
    value = nil,
    description = 'Bossi Kapp'
})
local menu_button3 = menu:AddButton({
    icon = '👕',
    label = 'Riided',
    value = nil,
    description = 'Bossi Riidekapp'
})
local menu_button4 = menu:AddButton({
    icon = '💰',
    label = 'Gangi Raha',
    value = menu2,
    description = 'Halda Gangi Raha'
})
local menu_button5 = menu2:AddButton({
    icon = '💲',
    label = '',
    value = nil,
    description = 'Praegune Gangi Raha'
})
local menu_button6 = menu2:AddButton({
    icon = '🤑',
    label = 'Võta',
    value = menu2,
    description = 'Võta Raha Gangi Kontolt'
})
local menu_button7 = menu2:AddButton({
    icon = '🏦',
    label = 'Pane',
    value = menu2,
    description = 'Pane Raha Gangi Kontole'
})

-- Storage
menu_button2:On("select", function()
    MenuV:CloseMenu(menu)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerGang.name, {
        maxweight = 4000000,
        slots = 300,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerGang.name)
end)

-- Outfit
menu_button3:On("select", function()
    MenuV:CloseMenu(menu)
    TriggerEvent('i13-clothing:client:openOutfitMenu')
end)

-- Society
menu_button4:On('select', function()
    UpdateSociety()
end)

-- Withdraw
menu_button6:On("select", function()
    local result = LocalInput('Withdrawal Amount', 16, '')
    if result ~= nil then
        TriggerServerEvent("i13-gangmenu:server:withdrawMoney", tonumber(result))
        UpdateSociety()
    end
end)

-- Deposit
menu_button7:On("select", function()
    local result = LocalInput('Deposit Amount', 16, '')
    if result ~= nil then
        TriggerServerEvent("i13-gangmenu:server:depositMoney", tonumber(result))
        UpdateSociety()
    end
end)

-- Employees
menu_button:On("select", function()
    menu3:ClearItems()
    QBCore.Functions.TriggerCallback('i13-gangmenu:server:GetEmployees', function(cb)
        for k,v in pairs(cb) do
            local menu_button8 = menu3:AddButton({
                label = v.grade.name.. ' ' ..v.name,
                value = v,
                description = 'Liige',
                select = function(btn)
                    if PlayerGang.name and PlayerGang.isboss then
                        local select = btn.Value
                        ManageEmployees(select)
                    end
                end
            })
        end
    end, PlayerGang.name)
end)

-- Recruit
menu_button1:On("select", function()
    menu4:ClearItems()
    local playerPed = PlayerPedId()
    for k,v in pairs(QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(playerPed), 10.0)) do
        if v and v ~= PlayerId() then
            local PlayerData = QBCore.Functions.GetPlayerData(v)
            local menu_button10 = menu4:AddButton({
                label = GetPlayerName(v) .. '(' .. PlayerData.charinfo.firstname .. ' ' .. PlayerData.charinfo.lastname .. ')',
                value = v,
                description = 'Saadaval värbamiseks',
                select = function(btn)
                    local select = btn.Value
                    TriggerServerEvent('i13-gangmenu:server:giveJob', GetPlayerServerId(v))
                end
            })
        end
    end
end)

-- MAIN THREAD
CreateThread(function()
    while true do
        Citizen.Wait(3)
        if PlayerGang.name ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.Gangs) do
                if k == PlayerGang.name and PlayerGang.isboss then
                    if #(pos - v) < 1.0 then
                        inRange = true
                        DrawText3D(v, "~g~E~w~ - Boss Menu")
                        if IsControlJustReleased(0, 38) then
                            MenuV:OpenMenu(menu)
                        end
                    else
                        inRange = false
                    end
                end
            end
        end
        if not inRange then
            Wait(1000)
        end
    end
end)

-- FUNCTIONS
function UpdateSociety()
    QBCore.Functions.TriggerCallback('i13-gangmenu:server:GetAccount', function(cb)
        menu_button5.Label = 'Society Amount: $' ..comma_value(cb)
    end, PlayerGang.name)
end

function ManageEmployees(employee)
    local manageroptions = MenuV:CreateMenu(false, employee.name .. ' Options', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv')
    manageroptions:ClearItems()
    MenuV:OpenMenu(manageroptions)
    buttons = {
        [1] = {
            icon = '↕️',
            label = "Ametikõrgendus/Alandus",
            value = "promote",
            description = "Muuda Auaste " .. employee.name
        },
        [3] = {
            icon = '🔥',
            label = "Vallanda",
            value = "Fire",
            description = "Vallanda " .. employee.name
        }
    }
    for k, v in pairs(buttons) do
        if PlayerGang.name and PlayerGang.grade.level >= employee.level then
            local menu_button9 = manageroptions:AddButton({
                icon = v.icon,
                label = v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value
                    if values == 'promote' then
                        local result = LocalInput('New Grade Level', 3, '')
                        if result ~= nil then
                            TriggerServerEvent('i13-gangmenu:server:updateGrade', employee.empSource, tonumber(result))
                        end
                    else
                        TriggerServerEvent('i13-gangmenu:server:fireEmployee', employee.empSource)
                    end
                end
            })
        end
    end
end

-- UTIL
function DrawText3D(v, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(v, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 0)
    ClearDrawOrigin()
end

function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
        return result
    end
end

function comma_value(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end
