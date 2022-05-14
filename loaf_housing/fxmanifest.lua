fx_version "cerulean"
game "gta5"
lua54 "yes"

description "Housing script for FiveM."
author "Loaf Scripts#7785"
version "2.0.7"

shared_script "shared/*.lua"
server_script {
    "@mysql-async/lib/MySQL.lua",
    "@oxmysql/lib/MySQL.lua",
    "server/frameworks/*.lua",
    "server/*.lua",
    "escrow/server.lua"
}
client_script {
    "client/frameworks/**.lua",
    "client/*.lua"
}

dependency {
    "loaf_lib",
    "loaf_keysystem"
}

escrow_ignore {
    "shared/*.lua",

    "client/*.lua",
    "client/frameworks/**.lua",

    "server/**.lua",

    "whiteshell/fxmanifest.lua",
    "whiteshell/stream/_manifest.ymf",
    "whiteshell/stream/white_shell_col.ybn",
    "whiteshell/stream/white_shell_milo_.ymap",
    "whiteshell/stream/white_shell.ydr",
    "whiteshell/stream/white_shell.ytyp"
}
dependency '/assetpacks'