fx_version 'cerulean'
game 'gta5'

description 'i13-SmallResources'
version '1.0.0'

shared_script 'config.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

client_script 'client/*.lua'

data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'events.meta'
data_file 'PED_METADATA_FILE' 'pedhealth.meta'
data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'popgroups.ymt'

files {
	'events.meta',
	'pedhealth.meta',
	'popgroups.ymt',
	'relationships.dat'
}

exports {
	'HasHarness'
}

lua54 'yes'