fx_version 'cerulean'
game 'gta5'

author 'QuakeAcid'

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

shared_script 'config.lua'

lua54 'yes'