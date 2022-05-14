Strings = {
    ["keybind"] = "Maakleri Menu",
    
    ["enter"] = "Sisene majja",
    ["exit"] = "Välju majast",

    ["boss"] = "Ülemuse Tegevused",

    ["noone_nearby"] = "Kedagi pole lähedal",

    -- job menu
    ["job_menu"] = "Kinnisvara Maakler",
    ["bill_player"] = "Saada Leping",
    ["transfer_property"] = "Anna Võtmed",
    ["create_property"] = "Loo Uus Kinnisvara",
    ["remove_property"] = "Eemalda Kinnisvara",
    -- remove property
    ["property_remove"] = "Kinnisvara mida eemaldada",
    ["removed_property"] = "Eemaldasid kinnisvara #%i",
    ["remove"] = "Eemalda Kinnisvara",
    -- bill menu
    ["who_bill"] = "Kellele tahad lepingut saata?",
    ["houseid_bill"] = "Kinnisvara id",
    ["send_bill"] = "Saada",
    -- transfer menu
    ["who_transfer"] = "Kellele tahad võtmeid anda?",
    ["property_transfer"] = "Kinnisvara id",
    ["not_paid"] = "Isik ei ole lepingut allkirjastanud",
    ["transferred_property"] = "Võtmed üle antud",
    ["transfer"] = "Anna Üle",
    -- create house menu
    ["set_entrance"] = "Määra sissepääs",
    ["set_garage_entrance"] = "Set garage entrance",
    ["set_garage_exit"] = "Set garage exit",
    ["add_property"] = "Lisa Kinnisvara",
    ["cancel_creation"] = "Katkesta",

    ["entrance"] = "Kinnisvara Sissepääs",
    ["garage_entrance"] = "Garaaz",
    ["garage_exit"] = "Garaazi Spawn",

    ["set_interior"] = "Määra Interior",
    ["choose_interior"] = "Vali Interior",
    ["interior_set"] = "Interior määratud: %s",

    ["must_entrance"] = "Pead valima sissepääsu asukoha",
    ["must_interior"] = "Pead valima interiori",
    ["set_propertytype"] = "Vali Kinnisvara tüüp",
    ["house"] = "Maja",
    ["apartment"] = "Korter",
    ["finish_property"] = "Lõpeta Kinnisvara Loomine",

    ["house_label"] = "Maja nimi",
    ["apartment_label"] = "Korteri nimi",
    ["short_name"] = "See nimi on liiga lühike",
    ["property_price"] = "Kinnisvara hind",
    ["price_low"] = "See hind on liiga madal",

    ["company_no_money"] = "Su ettevõttel ei ole piisavalt raha, et seda kinnisvara luua",

    -- misc
    ["blip"] = "Kinnisvara Maakler",
    ["invalid_property"] = "Ei ole kinnisvara selle id'ga",
    ["someone_owns"] = "See juba kuulub kellelegi",
    ["already_owns"] = "See juba kuulub sellele isikule",
    ["bill_label"] = "%s (#%i)"
}

-- ignore this
setmetatable(Strings, {__index = function(self, key)
    print("NO KEY", key)
    return "Error: Missing translation for \""..key.."\""
end})