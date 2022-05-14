fx_version 'cerulean'
game 'gta5'

client_scripts {
  'client/*.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/app.js',
  'html/style.css',
  'html/jquery.datetimepicker.min.css',
  'html/jquery.datetimepicker.full.min.js',
  'html/date.format.js'
}

lua54 'yes'