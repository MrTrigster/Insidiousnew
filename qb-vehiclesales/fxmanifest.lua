fx_version 'cerulean'
game 'gta5'

description 'i13-VehicleSales'
version '1.1.0'

ui_page 'html/ui.html'

shared_script 'config.lua'

client_script 'client/main.lua'
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

files {
	'html/reset.css',
	'html/logo.svg',
	'html/ui.css',
	'html/ui.html',
	'html/vue.min.js',
	'html/ui.js',
}

lua54 'yes'