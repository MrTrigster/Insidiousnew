fx_version 'cerulean'
game 'gta5'

description 'i13-Nitro'
version '1.0.0'

client_script 'client/main.lua'

server_scripts {
    'server/main.lua',
    '@oxmysql/lib/MySQL.lua',
}