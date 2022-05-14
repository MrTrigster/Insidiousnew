Strings = {
    ["select_menu"] = "Vali Menu",
    ["unsigned_bill"] = "Allkirjastamata",
    ["signed_bill"] = "Allkirjastatud",

    ["unsigned_bills"] = "Allkirjastamata Lepingud",
    ["signed_bills"] = "Allkirjastatud Lepingud",
    ["bill_item"] = "[%s] %s",
    ["no_bills"] = "Ei ole lepinguid",

    ["view_bill"] = "Vaata Lepingut",
    ["transfer_bill"] = "Näita Lepingut",

    ["who_transfer"] = "Kellele tahad sa lepingut näidata",
    ["confirm_transfer"] = "Näita \"%s\" %s'le",

    ["sent_bill"] = "Sa saatsid lepingu $%i %s'le",
    ["received_bill"] = "Sa said lepingu $%i",

    ["transferred_bill"] = "Sa saatsid %s %s'le",
    ["received_transfer"] = "Sa said %s %s'lt",

    ["bill_paid"] = "%s ($%i) sai makstud %s poolt",

    ["keybind"] = "View invoices",

    ["no_money"] = "Sul ei ole piisavalt raha",

    ["yes"] = "Jah",
    ["no"] = "Ei",

    ["back"] = "← Tagasi",
    ["close"] = "Sulge Menu",
}

-- ignore this
setmetatable(Strings, {__index = function(self, key)
    print("NO KEY", key)
    return "Error: Missing translation for \""..key.."\""
end})