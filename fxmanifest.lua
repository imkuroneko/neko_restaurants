fx_version 'cerulean'
game 'gta5'

description 'Sistema de gestión de articulos y crafteo para facciones gastronómicas'
author 'KuroNeko'

version '1.0'

shared_scripts {
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