Config = {
    Debug = false,
    Framework = "qb", -- esx or qb
    Align = "bottom-right", -- menu alignment (esx)
    Command = "keys", -- false to disable
    Keybind = false, -- false to disable, requires command
    UseRPName = true, -- use the in-game name instead of fivem name + id?
}

Strings = {
    ["keybind"] = "Sinu Võtmed",
    ["no_keys"] = "Sul ei ole võtmeid",

    -- menu
    ["main_menu"] = "Sinu Võtmed",

    ["transfer_nearby"] = "Anna Võti",
    ["use_key"] = "Kasuta Võtit",
    ["delete_key"] = "Eemalda Võti",

    ["confirm_delete"] = "Kindel, et tahad võtit eemaldada %s?",
    ["yes"] = "Jah",
    ["no"] = "Ei",

    ["give_to"] = "Anna võti %s'le (%i)",
    ["noone_nearby"] = "Kedagi pole lähedal",
    
    ["confirm_give"] = "Kindel, et tahad anda võtit %s'le?",
    ["couldnt_transfer"] = "Ei saanud võtit anda",
    ["transferred"] = "Andsid võtme %s %s'le",

    -- notifications
    ["not_your_key"] = "Sul ei ole seda võtit",
    ["couldnt_delete"] = "Ei saanud võtit eemaldada",
    ["deleted"] = "Eemaldasid võtme \"%s\".",
    ["received_key"] = "Sa said võtme",

    -- logs
    ["LOG_transferred_key"] = "Transferred their key %s (unique id: %s) to %s [id %i]",
    ["LOG_received_key"] = "Received key %s (unique id: %s) via transfer from %s [id %i]",
    ["LOG_removed_key"] = "Removed their key %s (unique id: %s)",
    ["LOG_create_key"] = "Received a key created by script %s. Key data:\nname: %s\nkey id: %s\nunique id: %s",
    ["LOG_delete_all"] = "All keys with id %s has been deleted by script %s",
    ["LOG_delete_specific"] = "Script %s deleted key with unique id %s",
    ["LOG_delete_key"] = "Had their key %s (unique id: %s) deleted by script %s."
}

-- IGNORE EVERYTHING BELOW THIS LINE --
setmetatable(Strings, {
    __index = function(self, key)
        return "Error: Missing translation for \""..key.."\""
    end
})

_print = print
function print(...)
    if not Config.Debug then return end
    _print("[^3DEBUG^0]", ...)
end

function printf(s, ...)
    if not Config.Debug then return end
    print(s:format(table.unpack({...})))
end