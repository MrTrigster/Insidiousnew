fx_version 'cerulean'
game 'gta5'

description 'QB-AmbulanceJob'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
	'client/main.lua',
	'client/wounding.lua',
	'client/laststand.lua',
	'client/job.lua',
	'client/dead.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/logging.lua'
}

lua54 'yes'