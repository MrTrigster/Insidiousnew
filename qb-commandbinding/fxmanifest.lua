fx_version 'cerulean'
game 'gta5'

description 'i13-CommandBinding'
version '1.0.0'

ui_page 'html/index.html'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

client_script 'client/main.lua'

files {
	'html/*'
}

lua54 'yes'