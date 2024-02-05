fx_version 'cerulean'
game 'gta5'

description 'Sistema de gestión de articulos y crafteo para facciones gastronómicas'
author 'KuroNeko'

lua54 'yes'

version '1.2'

shared_scripts {
    'config.lua',
}

client_scripts {
    'client/restaurant.lua',
    'client/menu.lua',
    'client/radialmenu.lua',
    'client/billing.lua',
    'client/shop.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/restaurant.lua',
    'server/menu.lua',
    'server/billing.lua',
    'server/shop.lua',
}

dependencies {
    'ox_inventory' -- comentar si se utilizará 'qb-inventory'
}