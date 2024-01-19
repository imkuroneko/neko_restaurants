Config = {}

Config.foodCraftItem  = ''
Config.drinkCraftItem = ''

Config.foodCraftAreaLabel  = '🍳 Estación de alimentos'
Config.drinkCraftAreaLabel = '🥤 Estación de bebidas'

Config.Inventory = 'ox_inventory' -- 'ox_inventory' || 'qb-inventory'

Config.Stashes = {
    maxSlots  = 20,
    maxWeight = 125000
}

Config.shops = {
    ['burgershot'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'burgershot',

        -- ===== Refrigeradores (para artículos ya preparados y cosas así)
        stashesInventory = {
            { coords = vector3(-1194.428, -896.772, 13.886), heading = 345.00, minZ = 12.936, maxZ = 14.836, width = 1.0, height = 1.5 },
            { coords = vector3(-1195.828, -896.372, 13.886), heading = 345.00, minZ = 12.936, maxZ = 14.836, width = 1.0, height = 1.5 },
            { coords = vector3(-1203.569, -897.004, 14.186), heading = 305.00, minZ = 12.886, maxZ = 15.486, width = 1.1, height = 3.4 },
        },

        -- ===== Bandejas (para poder facilitar los artículos a los clientes)
        stashesBar = {
            { coords = vector3(-1196.81, -892.78, 13.98), heading = 245.89, minZ = 13.436, maxZ = 14.336, width = 1.0, height = 1.0, prop = nil }, -- 'prop_food_tray_01'
            { coords = vector3(-1194.67, -893.31, 13.98), heading = 245.89, minZ = 13.436, maxZ = 14.336, width = 1.0, height = 1.0, prop = nil }, -- 'prop_food_tray_01'
            { coords = vector3(-1192.83, -893.83, 13.98), heading = 331.82, minZ = 13.436, maxZ = 14.336, width = 1.0, height = 1.0, prop = nil }, -- 'prop_food_tray_01'
            { coords = vector3(-1190.93, -894.31, 13.98), heading = 216.98, minZ = 13.436, maxZ = 14.336, width = 1.0, height = 1.0, prop = nil }, -- 'prop_food_tray_01'
        },

        -- ===== Mesas del comercio
        stashesTables = {
            -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
        },

        -- ===== Áreas de Crafteo
        craftingArea = {
            { coords = vector3(-1195.294, -900.373, 13.386), heading = 345.0, minZ = 12.886, maxZ = 13.886, width = 1.0, height = 1.0, prop = nil, type = 'food' },
            { coords = vector3(-1196.294, -899.974, 13.386), heading = 345.0, minZ = 12.886, maxZ = 13.886, width = 1.0, height = 1.0, prop = nil, type = 'food' },
            { coords = vector3(-1196.993, -899.874, 13.386), heading = 345.0, minZ = 12.886, maxZ = 13.886, width = 1.0, height = 1.0, prop = nil, type = 'food' },
            { coords = vector3(-1195.894, -897.174, 13.486), heading = 345.0, minZ = 12.986, maxZ = 13.986, width = 1.0, height = 1.0, prop = nil, type = 'food' },

            { coords = vector3(-1190.195, -898.874, 13.786), heading = 305.0, minZ = 12.836, maxZ = 14.736, width = 1.2, height = 1.3, prop = nil, type = 'drink' },
            { coords = vector3(-1191.095, -899.674, 13.786), heading = 305.0, minZ = 12.836, maxZ = 14.736, width = 1.2, height = 1.3, prop = nil, type = 'drink' },
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
    ['vanilla'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'vanilla',

        -- ===== Refrigeradores (para artículos ya preparados y cosas así)
        stashesInventory = {
            { coords = vector3(132.716, -1288.894, 29.655), heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.6, height = 1.6 },
            { coords = vector3(129.616, -1277.197, 29.655), heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.6, height = 1.6 },
        },

        -- ===== Bandejas (para poder facilitar los artículos a los clientes)
        stashesBar = {
            { coords = vector3(129.82, -1286.81, 29.30), heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.5, height = 0.7, prop = 'prop_whiskey_bottle' },
            { coords = vector3(129.11, -1285.77, 29.30), heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.5, height = 0.7, prop = 'prop_whiskey_bottle' },
            { coords = vector3(128.4, -1284.52, 29.30),  heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.5, height = 0.7, prop = 'prop_whiskey_bottle' },
        },

        -- ===== Mesas del comercio
        stashesTables = {
            -- /targhelp
            -- { coords = vector3(128.816, -1284.495, 29.655), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
        },

        -- ===== Áreas de Crafteo
        craftingArea = {
            { coords = vector3(136.917, -1283.695, 29.255), heading = 30.0, minZ = 28.755, maxZ = 29.755, width = 1.8, height = 1.8, prop = 'prop_food_tray_01', type = 'food' },

            { coords = vector3(134.817, -1279.996, 29.255), heading = 30.0, minZ = 28.755, maxZ = 29.755, width = 1.8, height = 1.8, prop = 'prop_food_tray_01', type = 'drink' },
            { coords = vector3(135.917, -1281.896, 29.255), heading = 30.0, minZ = 28.755, maxZ = 29.755, width = 1.8, height = 1.8, prop = 'prop_food_tray_01', type = 'drink' },
        },

        craftablesFoods = {
            'caviar',
            'tabla_quesos',
            'sushi',
            'choricitos_al_vino',
            'coctel_de_mariscos'
        },

        craftablesDrinks = {
            'mimosa',
            'orgasmo_de_pitufo',
            'panty_dropper',
            'sex_on_the_beach',
            'smirnoff_ice',
            'cosmopolitan',
            'champagne',
            'coca_cola',
            'jugo_frutilla'
        }
    },
    ['bahama'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'bahama',

        -- ===== Refrigeradores (para artículos ya preparados y cosas así)
        stashesInventory = {
            -- publicos
            { coords = vector3(-1394.98, -611.242, 30.319), heading = 30.0, minZ = 30.219, maxZ = 31.219, width = 1.4, height = 1.4 },
            { coords = vector3(-1392.676, -614.567, 30.319), heading = 30.0, minZ = 30.219, maxZ = 31.219, width = 1.4, height = 1.4 },

            -- oficina jefe
            { coords = vector3(-1364.804, -616.221, 30.32), heading = 30.0, minZ = 29.82, maxZ = 30.82, width = 1.4, height = 1.4 },
        },

        -- ===== Bandejas (para poder facilitar los artículos a los clientes)
        stashesBar = {
            { coords = vector3(-1165.88, -1442.07, 4.51), heading = 84.93, minZ = 4.00, maxZ = 6.00, width = 0.5, height = 0.7, prop = 'prop_food_tray_01' },
        },

        -- ===== Mesas del comercio
        stashesTables = {
            -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
        },

        -- ===== Áreas de Crafteo
        craftingArea = {
            { coords = vector3(-1389.106, -608.136, 30.719), heading = 30.0, minZ = 30.219, maxZ = 31.219, width = 1.4, height = 1.4, prop = nil, type = 'food' },
            { coords = vector3(-1392.309, -610.168, 30.669), heading = 30.0, minZ = 30.219, maxZ = 31.219, width = 1.4, height = 1.4, prop = nil, type = 'food' },
            { coords = vector3(-1390.643, -612.693, 30.519), heading = 30.0, minZ = 30.219, maxZ = 31.219, width = 1.4, height = 1.4, prop = nil, type = 'food' },
            { coords = vector3(-1387.811, -610.687, 30.319), heading = 30.0, minZ = 30.219, maxZ = 31.219, width = 1.4, height = 1.4, prop = nil, type = 'food' },

            { coords = vector3(-1390.484, -606.401, 29.819), heading = 30.00, minZ = 29.319, maxZ = 30.319, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
            { coords = vector3(-1392.706, -607.572, 29.819), heading = 30.00, minZ = 29.319, maxZ = 30.319, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
            { coords = vector3(-1389.631, -614.191, 30.219), heading = 30.00, minZ = 29.319, maxZ = 30.319, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
            { coords = vector3(-1386.664, -612.502, 30.319), heading = 30.00, minZ = 29.319, maxZ = 30.319, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
        },


        craftablesFoods = {
            'camarones_fritos',
            'ceviche',
            'croqueta_merluza',
            'empanadas_calamar',
            'mejillones_ajillo',
        },

        craftablesDrinks = {
            'caipirinha',
            'ginebra',
            'mojito',
            'pina_colada',
            'tequila_sunrise',
            'limonada',
            'fanta',
        }
    },
    ['galaxy'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'galaxy',

        -- ===== Refrigeradores (para artículos ya preparados y cosas así)
        stashesInventory = {
            { coords = vector3(353.496, 288.42, 91.03), heading = 30.0, minZ = 90.53, maxZ = 91.53, width = 1.4, height = 1.4 },
            { coords = vector3(355.145, 280.808, 94.291), heading = 345.02, minZ = 93.891, maxZ = 94.191, width = 1.55, height = 1.55 },
        },

        -- ===== Bandejas (para poder facilitar los artículos a los clientes)
        stashesBar = {
            -- { coords = vector3(-1165.88, -1442.07, 4.51), heading = 84.93, minZ = 4.00, maxZ = 6.00, width = 0.5, height = 0.7, prop = 'prop_food_tray_01' },
        },

        -- ===== Mesas del comercio
        stashesTables = {
            -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
        },

        -- ===== Áreas de Crafteo
        craftingArea = {
            { coords = vector3(353.444, 288.87, 92.11), heading = 30.0, minZ = 91.61, maxZ = 92.61, width = 1.4, height = 1.4, prop = nil, type = 'food' },
            { coords = vector3(351.242, 289.647, 92.01), heading = 30.0, minZ = 91.61, maxZ = 92.61, width = 1.4, height = 1.4, prop = nil, type = 'food' },
            { coords = vector3(355.058, 282.574, 95.291), heading = 345.01, minZ = 94.791, maxZ = 95.791, width = 4.3, height = 1.4, prop = nil, type = 'food' },

            { coords = vector3(352.905, 288.71, 90.92), heading = 30.0, minZ = 90.42, maxZ = 91.42, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
            { coords = vector3(351.245, 289.13, 91.19), heading = 30.0, minZ = 90.42, maxZ = 91.42, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
            { coords = vector3(355.684, 282.795, 93.891), heading = 345.01, minZ = 93.391, maxZ = 94.391, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
        },

        craftablesFoods = {
            'palitos_muzzarella',
            'alitas_pollo',
            'aros_cebolla',
            'hamburguesa',
            'nuggets',
        },

        craftablesDrinks = {
            'vodka',
            'old_fashioned',
            'daikiri_frutilla',
            'coco_loco',
            'skyblue',
            'jugo_naranja',
            'guarana',
        }
    },
    ['yellow'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'yellow',

        -- ===== Refrigeradores (para artículos ya preparados y cosas así)
        stashesInventory = {
            { coords = vector3(1983.269, 3052.403, 47.035), heading = 30.00, minZ = 46.535, maxZ = 47.535, width = 1.4, height = 1.4 },
            { coords = vector3(1985.027, 3048.214, 47.195), heading = 30.00, minZ = 46.535, maxZ = 47.535, width = 1.4, height = 1.4 },
        },

        -- ===== Bandejas (para poder facilitar los artículos a los clientes)
        stashesBar = {
            -- { coords = vector3(-1165.88, -1442.07, 4.51), heading = 84.93, minZ = 4.00, maxZ = 6.00, width = 0.5, height = 0.7, prop = 'prop_food_tray_01' },
        },

        -- ===== Mesas del comercio
        stashesTables = {
            -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
        },

        -- ===== Áreas de Crafteo
        craftingArea = {
            { coords = vector3(1984.33, 3050.212, 47.215), heading = 30.0, minZ = 46.715, maxZ = 47.715, width = 1.4, height = 1.4, prop = nil, type = 'food' },

            { coords = vector3(1982.045, 3053.672, 46.785), heading = 30.0, minZ = 46.285, maxZ = 47.285, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
            { coords = vector3(1981.364, 3052.851, 46.785), heading = 30.0, minZ = 46.285, maxZ = 47.285, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
        },

        craftablesFoods = {
            'empanada',
            'papas_fritas',
            'croquetas_pollo',
            'choripan',
            'brochetas',
        },

        craftablesDrinks = {
            'chopp_cerveza',
            'whisky',
            'destornillador',
            'cuba_libre',
            'fernet_coca',
            'sangria',
            'drpepper',
        }
    },
    ['tequila'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'tequila',

        -- ===== Refrigeradores (para artículos ya preparados y cosas así)
        stashesInventory = {
            { coords = vector3(-563.016, 284.431, 81.886), heading = 30.0, minZ = 81.386, maxZ = 82.386, width = 1.4, height = 1.4 },
        },

        -- ===== Bandejas (para poder facilitar los artículos a los clientes)
        stashesBar = {
            -- { coords = vector3(-1165.88, -1442.07, 4.51), heading = 84.93, minZ = 4.00, maxZ = 6.00, width = 0.5, height = 0.7, prop = 'prop_food_tray_01' },
        },

        -- ===== Mesas del comercio
        stashesTables = {
            -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
        },

        -- ===== Áreas de Crafteo
        craftingArea = {
            { coords = vector3(-561.373, 285.293, 82.176), heading = 35.0, minZ = 81.796, maxZ = 82.796, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
            { coords = vector3(-560.975, 288.031, 82.177), heading = 35.0, minZ = 81.796, maxZ = 82.796, width = 1.4, height = 1.4, prop = nil, type = 'drink' },

            { coords = vector3(-563.164, 288.882, 82.296), heading = 35.0, minZ = 81.796, maxZ = 82.796, width = 1.4, height = 1.4, prop = nil, type = 'food' },
            { coords = vector3(-563.138, 285.659, 82.396), heading = 35.0, minZ = 81.646, maxZ = 82.646, width = 1.4, height = 1.4, prop = nil, type = 'food' },
        },

        craftablesFoods = {
            'burrito',
            'nachos_con_queso',
            'papas_rancheras',
            'quesadillas',
            'taco',
        },

        craftablesDrinks = {
            'acapulco_noche',
            'margarita',
            'mezcal',
            'michelada',
            'tequila',
            'jugo_durazno',
            'sprite',
        }
    },
    -- ['pizzeria'] = {
    --     -- ===== Para visualizar los perímetros temporalmente
    --     debug   = false,

    --     -- ===== Nombre del job (qb-core/shared/jobs.lua)
    --     jobName = 'pizzeria',

        --     -- ===== Refrigeradores (para artículos ya preparados y cosas así)
    --     stashesInventory = {
    --         { coords = vector3(-1159.196, -1443.675, 4.653), heading = 35.00, minZ = 4.00, maxZ = 6.00, width = 1.4, height = 1.4 },
    --     },

    --     -- ===== Bandejas (para poder facilitar los artículos a los clientes)
    --     stashesBar = {
    --         { coords = vector3(-1165.88, -1442.07, 4.51), heading = 84.93, minZ = 4.00, maxZ = 6.00, width = 0.5, height = 0.7, prop = 'prop_food_tray_01' },
    --     },

    --     -- ===== Mesas del comercio
    --     stashesTables = {
    --         { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
    --         { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
    --     },

    --     -- ===== Áreas de Crafteo
    --     craftingArea = {
    --         { coords = vector3(-1160.633, -1447.763, 4.353), heading = 35.0, minZ = 4.053, maxZ = 6.653, width = 1.4, height = 1.4, prop = nil, type = 'food' },
    --         { coords = vector3(-1161.632, -1448.963, 4.353), heading = 35.0, minZ = 4.053, maxZ = 6.653, width = 1.4, height = 1.4, prop = nil, type = 'food' },
    --     },

    --     craftablesFoods = {
    --         'pizza_box_muzzarella',
    --         'pizza_box_pepperoni',
    --         'pizza_box_burger',
    --         'pizza_box_chicken_bbq',
    --         'pizza_box_jamon_queso',
    --         'pizza_box_jamon_verduras',
    --         'pizza_box_onion_bacon',
    --         'pizza_box_vegetariana'
    --     },

    --     craftablesDrinks = {
    --     }
    -- },
}