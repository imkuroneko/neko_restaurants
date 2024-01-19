fx_version 'cerulean'
game 'gta5'

description 'Sistema de gestión de articulos y crafteo para facciones gastronómicas'
author 'KuroNeko'

lua54 'yes'

version '1.2'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/restaurant.lua',
    'client/menu.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/restaurant.lua',
    'server/menu.lua'
}

dependencies {
    'ox_inventory' -- comentar si se utilizará 'qb-inventory'
}