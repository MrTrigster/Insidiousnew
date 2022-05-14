fx_version "cerulean"
game "gta5"
lua54 "yes"

description "Real estate agent script for loaf_housing."
author "Loaf Scripts#7785"
version "2.0.2"

shared_script "shared/*.lua"
server_script {
    "@mysql-async/lib/MySQL.lua",
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua"
}
client_script "client/*.lua"

dependency {
    "loaf_lib", -- https://github.com/loaf-scripts/loaf_lib
    "loaf_housing", -- https://store.loaf-scripts.com/package/4310850
    "loaf_billing" -- https://github.com/loaf-scripts/loaf_billing
}

escrow_ignore {
    "shared/*.lua",
    "client/*.lua",
    "server/*.lua"
}
dependency '/assetpacks'