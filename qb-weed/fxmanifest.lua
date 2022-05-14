fx_version 'cerulean'
game 'gta5'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'sv/*.lua',
}

client_scripts {
    'cl/*.lua',
}

shared_script 'config.lua'

lua54 'yes'