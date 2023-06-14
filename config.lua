Config = {}

Config.foodCraftItem  = ''
Config.drinkCraftItem = ''

Config.foodCraftAreaLabel  = '🍳 Estación de alimentos'
Config.drinkCraftAreaLabel = '🥤 Estación de bebidas'

Config.shops = {
    ['pizzeria'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = true,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'pizzeria',

        -- ===== Sistema de Menus para el público
        menu = false,
        menuDetails = { coords = vector3(-1167.05, -1442.96, 4.55), heading = 4.53, minZ = 4.00, maxZ = 6.00, width = 1, height = 2.2, prop = 'prop_stripmenu' },

        -- ===== Refrigeradores (para artículos ya preparados y cosas así)
        stashesInventory = {
            { coords = vector3(-1159.196, -1443.675, 4.653), heading = 35.00, minZ = 4.00, maxZ = 6.00, width = 1, height = 2.2 },
        },

        -- ===== Bandejas (para poder facilitar los artículos a los clientes)
        stashesBar = {
            { coords = vector3(-1165.88, -1442.07, 4.51), heading = 84.93, minZ = 4.00, maxZ = 6.00, width = 0.5, height = 0.7, prop = 'prop_food_tray_01' },
        },

        -- ===== Mesas del comercio
        stashesTables = {
            { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
        },

        -- ===== Áreas de Crafteo
        craftingArea = {
            { coords = vector3(-1160.633, -1447.763, 4.353), heading = 35.0, minZ = 4.053, maxZ = 6.653, width = 1, height = 2.2, prop = nil, type = 'food' },
            { coords = vector3(-1161.632, -1448.963, 4.353), heading = 35.0, minZ = 4.053, maxZ = 6.653, width = 1, height = 2.2, prop = nil, type = 'food' },
        },

        craftablesFoods = {
            'pizza_box_muzzarella',
            'pizza_box_pepperoni',
            'pizza_box_burger',
            'pizza_box_chicken_bbq',
            'pizza_box_jamon_queso',
            'pizza_box_jamon_verduras',
            'pizza_box_onion_bacon',
            'pizza_box_vegetariana'
        },

        craftablesDrinks = {
        }
    },
}