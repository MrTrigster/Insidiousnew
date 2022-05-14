fx_version 'cerulean'
game 'gta5'

description 'nui_drawtext'
version '1.1'
author 'github.com/loljoshie'

client_script 'config.lua'
client_script 'client.lua'
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

lua54 'yes'

ui_page 'html/index.html'

files {
	'html/*',
	'html/index.html',
	'html/styles.css',
	'html/app.js',
}
