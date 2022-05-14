fx_version 'cerulean'
game 'gta5'

description 'i13-Scoreboard'
version '1.0.0'

ui_page 'html/ui.html'

shared_script 'config.lua'

client_script 'client.lua'
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

files {
    'html/*'
}

lua54 'yes'