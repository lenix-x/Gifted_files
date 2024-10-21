fx_version 'cerulean'
game 'gta5'
author 'Lenix__x'

description 'qb-properties'
version '1.0.0'


shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'config/containers.lua',
}

client_scripts {
	'client/main.lua',
	'client/pink.lua',
	'client/containers.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
	'server/pink.lua',
	'server/containers.lua',
}

lua54 'yes'