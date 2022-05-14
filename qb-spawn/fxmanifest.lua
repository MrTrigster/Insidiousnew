fx_version 'cerulean'
game 'gta5'

description 'i13-Spawn'
version '1.0.0'

shared_scripts {
	'@qb-houses/config.lua',
	'@qb-apartments/config.lua'
}

client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/script.js',
	'html/reset.css'
}

dependencies {
	'qb-core',
	'qb-houses',
	'qb-interior',
	'qb-apartments'
}

lua54 'yes'