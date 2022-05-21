fx_version 'cerulean'
game 'gta5'

description 'i13-Prison'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
	'client/main.lua',
	'client/jobs.lua',
	'client/prisonbreak.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

lua54 'yes'