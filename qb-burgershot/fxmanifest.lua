fx_version 'cerulean'
game 'gta5'

author 'DrB1ackBeard'
description 'i13-burgershot for QBCore Created By DrB1ackBeard'
version '2.2.0'

shared_script 'config.lua'

client_scripts {
	'client/main.lua',
	'client/garage.lua',
	'client/menus.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

lua54 'yes'