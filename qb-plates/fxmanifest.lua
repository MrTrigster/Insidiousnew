fx_version 'cerulean'

game { 'gta5' }

description 'Project Error Fake Plate'

version '1.0.0'

lua54 'yes'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config/*.lua',
	'server/*.lua',
}

client_scripts {
	'client/*.lua',
}