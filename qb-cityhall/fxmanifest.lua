fx_version 'cerulean'
game 'gta5'

description 'i13-CityHall'
version '1.0.0'

ui_page 'html/index.html'

shared_script 'config.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_script 'client/main.lua'

files {
    'html/*.js',
    'html/*.html',
    'html/*.css'
}

lua54 'yes'