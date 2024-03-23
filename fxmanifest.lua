fx_version 'cerulean'
game 'gta5'

description 'Sistema de gestión de articulos y crafteo para facciones gastronómicas'
author 'KuroNeko'

lua54 'yes'

version '2.3.2'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/restaurant.lua',
    'client/menu.lua',
    'client/radialmenu.lua',
    'client/billing.lua',
    'client/avisos.lua',
    'client/shop.lua',
    'client/garages.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/restaurant.lua',
    'server/menu.lua',
    'server/billing.lua',
    'server/avisos.lua',
    'server/shop.lua',
}

dependencies {
    'ox_inventory'
}

ui_page 'html/index.html'

files {
    'locales/es.json',
    'html/index.html',
    'html/style.css',
    'html/notif.mp3',
}