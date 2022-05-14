fx_version 'bodacious'
game 'gta5'
author 'QBCore Framework Community'

description 'i13-Printer'
version '1.0.1'

ui_page "html/index.html"

shared_script 'config.lua'

client_script 'client/main.lua'
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

files {
    '*.lua',
    'html/*.html',
    'html/*.js',
    'html/*.css',
    'html/*.png',
}

lua54 'yes'