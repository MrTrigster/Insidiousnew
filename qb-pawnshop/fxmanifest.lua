fx_version 'cerulean'
game 'gta5'

description 'i13-Pawnshop'
version '1.0.0'

shared_script 'config.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua',
	--'client/melt.lua'
}

lua54 'yes'