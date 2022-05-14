fx_version 'cerulean'
game 'gta5'

author 'QuakeAcid'

shared_script 'config.lua'

client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/EntityZone.lua',
  '@PolyZone/CircleZone.lua',
  '@PolyZone/ComboZone.lua',
  'client/*.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}
  

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/css/reset.css',
  'html/css/style.css',
  'html/js/app.js'
}

lua54 'yes'