fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'shared/shared_utils.lua',
    'config.lua',
    'translations.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/*.js',
    'html/DEP/*.js',
    'html/img/**',
    'html/ProximaNova.woff'
}