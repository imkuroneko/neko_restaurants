Config = {}

-- ===== Configuraciones Generales del script
Config.Settings = {
    -- ===== Script de teléfono
    Phone              = 'qs-smartphone', -- esto se concatena a eventos en server/billing.lua:53 & 59

    -- ===== Sistema de Managements/Cobros
    Management         = 'Renewed-Banking', -- 'Renewed-Banking' || 'qb-management'

    -- ===== Crafteos
    Crafting = {
        ItemsPrice = 45, -- precio del item
        foodItem   = 'item_craft_comidas', -- nombre del item para crafteo de alimentos
        drinkItem  = 'item_craft_bebidas', -- nombre del item para crafteo de bebidas
    },

    -- ===== Visualización de items
    -- true   : mostrará una lista de opciones para cada facción y se prepararán uno a uno
    -- false  : se desplegará un menú como tienda, se utilizarán los items de craft como moneda de compra
    UseListMenu        = false,

    -- ===== Tienda de insumos para crafteos
    StoreCraftItems    = {
        targetZone = vector3(81.37, -219.27, 53.64),
        targetHeading = 346.91,
        coords = vector4(81.37, -219.27, 53.64, 346.91),
        minZ = 50.00,
        maxZ = 70.00,
        pedModel = 'ig_mp_agent14',
        pedHash  = 0xFBF98469
    },

    -- ===== Sistema de garages
    Garages = {
        pedModel       = 'a_m_m_eastsa_02',
        pedHash        = 0x07DD91AC
    },

    -- ===== Config stashes
    Stashes = {
        maxSlots       = 20,
        maxWeight      = 125000
    }
}

-- ===== Facciones
Config.Shops = {
    ['burgershot'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'burgershot',

        -- ===== Nombre de la facción (qb-core/shared/jobs.lua)
        jobLabel = 'Burgershot',

        -- ===== Porcentaje de comisión para el vendedor
        comissionPerSale = 25,

        -- ===== Opciones de alertas de abierto/cerrado en qb-radialmenu
        radialMenuStatus = {
            customize = {
                open = {
                    icon                = 'fas fa-coffee fa-shake',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                },
                closed = {
                    icon                = 'fas fa-shop-lock',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                }
            }
        },

        -- ===== Inventarios
        stashes = {
            -- ===== Refrigeradores (para artículos ya preparados y cosas así)
            inventory = {
                { coords = vector3(-1194.428, -896.772, 13.886), heading = 345.00, minZ = 12.936, maxZ = 14.836, width = 1.0, height = 1.5 },
                { coords = vector3(-1195.828, -896.372, 13.886), heading = 345.00, minZ = 12.936, maxZ = 14.836, width = 1.0, height = 1.5 },
                { coords = vector3(-1203.569, -897.004, 14.186), heading = 305.00, minZ = 12.886, maxZ = 15.486, width = 1.1, height = 3.4 },
            },

            -- ===== Bandejas (para poder facilitar los artículos a los clientes)
            bar = {
                { coords = vector3(-1196.81, -892.78, 13.98), heading = 245.89, minZ = 13.436, maxZ = 14.336, width = 1.0, height = 1.0, prop = nil }, -- 'prop_food_tray_01'
                { coords = vector3(-1194.67, -893.31, 13.98), heading = 245.89, minZ = 13.436, maxZ = 14.336, width = 1.0, height = 1.0, prop = nil }, -- 'prop_food_tray_01'
                { coords = vector3(-1192.83, -893.83, 13.98), heading = 331.82, minZ = 13.436, maxZ = 14.336, width = 1.0, height = 1.0, prop = nil }, -- 'prop_food_tray_01'
                { coords = vector3(-1190.93, -894.31, 13.98), heading = 216.98, minZ = 13.436, maxZ = 14.336, width = 1.0, height = 1.0, prop = nil }, -- 'prop_food_tray_01'
            },

            -- ===== Mesas del comercio
            tables = {
                -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
                -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            },
        },

        -- ===== Comestibles
        consumables = {
            -- ===== Áreas de Crafteo
            craftingArea = {
                { coords = vector3(-1195.294, -900.373, 13.386), heading = 345.0, minZ = 12.886, maxZ = 13.886, width = 1.0, height = 1.0, prop = nil, type = 'food' },
                { coords = vector3(-1196.294, -899.974, 13.386), heading = 345.0, minZ = 12.886, maxZ = 13.886, width = 1.0, height = 1.0, prop = nil, type = 'food' },
                { coords = vector3(-1196.993, -899.874, 13.386), heading = 345.0, minZ = 12.886, maxZ = 13.886, width = 1.0, height = 1.0, prop = nil, type = 'food' },
                { coords = vector3(-1195.894, -897.174, 13.486), heading = 345.0, minZ = 12.986, maxZ = 13.986, width = 1.0, height = 1.0, prop = nil, type = 'food' },

                { coords = vector3(-1190.195, -898.874, 13.786), heading = 305.0, minZ = 12.836, maxZ = 14.736, width = 1.2, height = 1.3, prop = nil, type = 'drink' },
                { coords = vector3(-1191.095, -899.674, 13.786), heading = 305.0, minZ = 12.836, maxZ = 14.736, width = 1.2, height = 1.3, prop = nil, type = 'drink' },
            },

            foods = {
                'burgershot_classic',
                'burgershot_smash',
                'burgershot_royal',
                'burgershot_chicken_crispy',
                'burgershot_papasfritas',
                'burgershot_papasrusticas',
            },

            drinks = {
            }
        },
    },

    ['vanilla'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'vanilla',

        -- ===== Nombre de la facción (qb-core/shared/jobs.lua)
        jobLabel = 'Vanilla Unicorn',

        -- ===== Porcentaje de comisión para el vendedor
        comissionPerSale = 25,

        -- ===== Opciones de alertas de abierto/cerrado en qb-radialmenu
        radialMenuStatus = {
            customize = {
                open = {
                    icon                = 'fas fa-glass-cheers fa-shake',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#66117A',
                    backgroundcolor     = '#A034B8',
                },
                closed = {
                    icon                = 'fas fa-shop-lock',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#66117A',
                    backgroundcolor     = '#A034B8',
                }
            }
        },

        -- ===== Inventarios
        stashes = {
            -- ===== Refrigeradores (para artículos ya preparados y cosas así)
            inventory = {
                { coords = vector3(132.716, -1288.894, 29.655), heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.6, height = 1.6 },
                { coords = vector3(129.616, -1277.197, 29.655), heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.6, height = 1.6 },
            },

            -- ===== Bandejas (para poder facilitar los artículos a los clientes)
            bar = {
                { coords = vector3(129.82, -1286.81, 29.30), heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.5, height = 0.7, prop = 'prop_whiskey_bottle' },
                { coords = vector3(129.11, -1285.77, 29.30), heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.5, height = 0.7, prop = 'prop_whiskey_bottle' },
                { coords = vector3(128.4, -1284.52, 29.30),  heading = 30.0, minZ = 29.155, maxZ = 30.155, width = 1.5, height = 0.7, prop = 'prop_whiskey_bottle' },
            },

            -- ===== Mesas del comercio
            tables = {
                -- { coords = vector3(128.816, -1284.495, 29.655), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            },
        },

        -- ===== Comestibles
        consumables = {
            -- ===== Áreas de Crafteo
            craftingArea = {
                { coords = vector3(136.917, -1283.695, 29.255), heading = 30.0, minZ = 28.755, maxZ = 29.755, width = 1.8, height = 1.8, prop = 'prop_food_tray_01', type = 'food' },
                { coords = vector3(134.817, -1279.996, 29.255), heading = 30.0, minZ = 28.755, maxZ = 29.755, width = 1.8, height = 1.8, prop = 'prop_food_tray_01', type = 'drink' },
                { coords = vector3(135.917, -1281.896, 29.255), heading = 30.0, minZ = 28.755, maxZ = 29.755, width = 1.8, height = 1.8, prop = 'prop_food_tray_01', type = 'drink' },
            },

            foods = {
                'caviar',
                'tabla_quesos',
                'sushi',
                'choricitos_al_vino',
                'coctel_de_mariscos'
            },

            drinks = {
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
    },

    ['bahama'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'bahama',

        -- ===== Nombre de la facción (qb-core/shared/jobs.lua)
        jobLabel = 'Bahama Mamas',

        -- ===== Porcentaje de comisión para el vendedor
        comissionPerSale = 25,

        -- ===== Opciones de alertas de abierto/cerrado en qb-radialmenu
        radialMenuStatus = {
            customize = {
                open = {
                    icon                = 'fas fa-coffee fa-shake',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                },
                closed = {
                    icon                = 'fas fa-shop-lock',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                }
            }
        },

        -- ===== Inventarios
        stashes = {
            -- ===== Refrigeradores (para artículos ya preparados y cosas así)
            inventory = {
                -- publicos
                { coords = vector3(-1394.98, -611.242, 30.319), heading = 30.0, minZ = 30.219, maxZ = 31.219, width = 1.4, height = 1.4 },
                { coords = vector3(-1392.676, -614.567, 30.319), heading = 30.0, minZ = 30.219, maxZ = 31.219, width = 1.4, height = 1.4 },

                -- oficina jefe
                { coords = vector3(-1364.804, -616.221, 30.32), heading = 30.0, minZ = 29.82, maxZ = 30.82, width = 1.4, height = 1.4 },
            },

            -- ===== Bandejas (para poder facilitar los artículos a los clientes)
            bar = {
                { coords = vector3(-1393.976, -608.668, 30.519), heading = 40.00, minZ = 30.019, maxZ = 31.019, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
                { coords = vector3(-1390.977, -606.569, 30.519), heading = 40.00, minZ = 30.019, maxZ = 31.019, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
                { coords = vector3(-1388.677, -614.267, 30.519), heading = 40.00, minZ = 30.019, maxZ = 31.019, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
                { coords = vector3(-1386.378, -612.467, 30.519), heading = 40.00, minZ = 30.019, maxZ = 31.019, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
            },

            -- ===== Mesas del comercio
            tables = {
                -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
                -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            },
        },

        -- ===== Comestibles
        consumables = {
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

            foods = {
                'camarones_fritos',
                'ceviche',
                'croqueta_merluza',
                'empanadas_calamar',
                'mejillones_ajillo',
            },

            drinks = {
                'caipirinha',
                'ginebra',
                'mojito',
                'pina_colada',
                'tequila_sunrise',
                'limonada',
                'fanta',
            }
        },
    },

    ['galaxy'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'galaxy',

        -- ===== Nombre de la facción (qb-core/shared/jobs.lua)
        jobLabel = 'Galaxy Club',

        -- ===== Porcentaje de comisión para el vendedor
        comissionPerSale = 25,

        -- ===== Opciones de alertas de abierto/cerrado en qb-radialmenu
        radialMenuStatus = {
            customize = {
                open = {
                    icon                = 'fas fa-coffee fa-shake',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                },
                closed = {
                    icon                = 'fas fa-shop-lock',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                }
            }
        },

        -- ===== Inventarios
        stashes = {
            -- ===== Refrigeradores (para artículos ya preparados y cosas así)
            inventory = {
                { coords = vector3(353.496, 288.42, 91.03), heading = 30.0, minZ = 90.53, maxZ = 91.53, width = 1.4, height = 1.4 },
                { coords = vector3(355.145, 280.808, 94.291), heading = 345.02, minZ = 93.891, maxZ = 94.191, width = 1.55, height = 1.55 },
            },

            -- ===== Bandejas (para poder facilitar los artículos a los clientes)
            bar = {
                { coords = vector3(353.094, 285.404, 91.29), heading = 75.00, minZ = 90.94, maxZ = 91.64, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
                { coords = vector3(351.594, 285.604, 91.29), heading = 75.00, minZ = 90.94, maxZ = 91.64, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
                { coords = vector3(350.094, 286.004, 91.29), heading = 75.00, minZ = 90.94, maxZ = 91.64, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },

                { coords = vector3(356.966, 277.297, 94.291), heading = 75.00, minZ = 93.941, maxZ = 94.641, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
                { coords = vector3(358.566, 279.397, 94.291), heading = 75.00, minZ = 93.941, maxZ = 94.641, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
                { coords = vector3(359.266, 281.897, 94.291), heading = 75.00, minZ = 93.941, maxZ = 94.641, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
                { coords = vector3(358.866, 283.897, 94.291), heading = 75.00, minZ = 93.941, maxZ = 94.641, width = 0.8, height = 0.8, prop = 'p_wine_glass_s' },
            },

            -- ===== Mesas del comercio
            tables = {
                -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
                -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            },
        },

        -- ===== Comestibles
        consumables = {
            -- ===== Áreas de Crafteo
            craftingArea = {
                { coords = vector3(353.444, 288.87, 92.11), heading = 30.0, minZ = 91.61, maxZ = 92.61, width = 1.4, height = 1.4, prop = nil, type = 'food' },
                { coords = vector3(351.242, 289.647, 92.01), heading = 30.0, minZ = 91.61, maxZ = 92.61, width = 1.4, height = 1.4, prop = nil, type = 'food' },
                { coords = vector3(355.058, 282.574, 95.291), heading = 345.01, minZ = 94.791, maxZ = 95.791, width = 4.3, height = 1.4, prop = nil, type = 'food' },

                { coords = vector3(352.905, 288.71, 90.92), heading = 30.0, minZ = 90.42, maxZ = 91.42, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
                { coords = vector3(351.245, 289.13, 91.19), heading = 30.0, minZ = 90.42, maxZ = 91.42, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
                { coords = vector3(355.684, 282.795, 93.891), heading = 345.01, minZ = 93.391, maxZ = 94.391, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
            },

            foods = {
                'palitos_muzzarella',
                'alitas_pollo',
                'aros_cebolla',
                'hamburguesa',
                'nuggets',
            },

            drinks = {
                'vodka',
                'old_fashioned',
                'daikiri_frutilla',
                'coco_loco',
                'skyblue',
                'jugo_naranja',
                'guarana',
            }
        },
    },

    ['yellow'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'yellow',

        -- ===== Nombre de la facción (qb-core/shared/jobs.lua)
        jobLabel = 'Yellow Jack',

        -- ===== Porcentaje de comisión para el vendedor
        comissionPerSale = 25,

        -- ===== Opciones de alertas de abierto/cerrado en qb-radialmenu
        radialMenuStatus = {
            customize = {
                open = {
                    icon                = 'fas fa-coffee fa-shake',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                },
                closed = {
                    icon                = 'fas fa-shop-lock',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                }
            }
        },

        -- ===== Inventarios
        stashes = {
            -- ===== Refrigeradores (para artículos ya preparados y cosas así)
            inventory = {
                { coords = vector3(1983.269, 3052.403, 47.035), heading = 30.00, minZ = 46.535, maxZ = 47.535, width = 1.4, height = 1.4 },
                { coords = vector3(1985.027, 3048.214, 47.195), heading = 30.00, minZ = 46.535, maxZ = 47.535, width = 1.4, height = 1.4 },
            },

            -- ===== Bandejas (para poder facilitar los artículos a los clientes)
            bar = {
                { coords = vector3(1985.188, 3055.269, 47.315), heading = 40.00, minZ = 46.815, maxZ = 47.815, width = 0.8, height = 0.8, prop = 'prop_peanut_bowl_01' },
                { coords = vector3(1984.089, 3052.866, 47.315), heading = 40.00, minZ = 46.815, maxZ = 47.815, width = 0.8, height = 0.8, prop = nil },
                { coords = vector3(1985.088, 3050.264, 47.615), heading = 40.00, minZ = 46.815, maxZ = 47.815, width = 0.8, height = 0.8, prop = 'prop_food_chips' },
            },

            -- ===== Mesas del comercio
            tables = {
                -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
                -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            },
        },

        -- ===== Comestibles
        consumables = {
            -- ===== Áreas de Crafteo
            craftingArea = {
                { coords = vector3(1984.33, 3050.212, 47.215), heading = 30.0, minZ = 46.715, maxZ = 47.715, width = 1.4, height = 1.4, prop = nil, type = 'food' },

                { coords = vector3(1982.045, 3053.672, 46.785), heading = 30.0, minZ = 46.285, maxZ = 47.285, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
                { coords = vector3(1981.364, 3052.851, 46.785), heading = 30.0, minZ = 46.285, maxZ = 47.285, width = 1.4, height = 1.4, prop = nil, type = 'drink' },
            },

            foods = {
                'empanada',
                'papas_fritas',
                'croquetas_pollo',
                'choripan',
                'brochetas',
            },

            drinks = {
                'chopp_cerveza',
                'whisky',
                'destornillador',
                'cuba_libre',
                'fernet_coca',
                'sangria',
                'drpepper',
            }
        },
    },

    ['tequila'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = true,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'tequila',

        -- ===== Nombre de la facción (qb-core/shared/jobs.lua)
        jobLabel = 'Tequila-la',

        -- ===== Porcentaje de comisión para el vendedor
        comissionPerSale = 25,

        -- ===== Opciones de alertas de abierto/cerrado en qb-radialmenu
        radialMenuStatus = {
            customize = {
                open = {
                    icon                = 'fas fa-coffee fa-shake',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                },
                closed = {
                    icon                = 'fas fa-shop-lock',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                }
            }
        },

        -- ===== Inventarios
        stashes = {
            -- ===== Refrigeradores (para artículos ya preparados y cosas así)
            inventory = {
                { coords = vector3(-563.029, 284.506, 82.376), heading = 355.0, minZ = 81.826, maxZ = 82.926, width = 0.8, height = 0.8 }, -- planta baja
                { coords = vector3(-568.503, 276.709, 77.776), heading = 355.0, minZ = 76.776, maxZ = 78.776, width = 0.8, height = 2.6 }, -- subsuelo
            },

            -- ===== Bandejas (para poder facilitar los artículos a los clientes)
            bar = {
                { coords = vector3(-560.829, 286.406, 82.276), heading = 355.00, minZ = 82.126, maxZ = 82.426, width = 0.4, height = 0.4, prop = 'prop_peanut_bowl_01' }, -- planta baja
                { coords = vector3(-560.629, 289.206, 82.276), heading = 355.00, minZ = 82.126, maxZ = 82.426, width = 0.4, height = 0.4, prop = 'prop_peanut_bowl_01' }, -- planta baja
                { coords = vector3(-560.929, 284.606, 82.276), heading = 355.00, minZ = 82.126, maxZ = 82.426, width = 0.4, height = 0.4, prop = 'prop_peanut_bowl_01' }, -- planta baja

                { coords = vector3(-569.604, 279.225, 77.776), heading = 355.00, minZ = 77.626, maxZ = 77.926, width = 0.6, height = 0.6, prop = 'prop_peanut_bowl_01' }, -- subsuelo
                { coords = vector3(-566.305, 279.025, 77.776), heading = 355.00, minZ = 77.626, maxZ = 77.926, width = 0.6, height = 0.6, prop = 'prop_peanut_bowl_01' }, -- subsuelo
            },

            -- ===== Mesas del comercio
            tables = {
                -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
                -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            },
        },

        -- ===== Comestibles
        consumables = {
            -- ===== Áreas de Crafteo
            craftingArea = {
                { coords = vector3(-563.029, 288.706, 82.376), heading = 355.0, minZ = 82.076, maxZ = 82.676, width = 1.7, height = 0.9, prop = nil, type = 'food' },  -- planta baja
                { coords = vector3(-563.329, 285.906, 82.376), heading = 355.0, minZ = 82.076, maxZ = 82.676, width = 1.7, height = 0.9, prop = nil, type = 'food' },  -- planta baja
                { coords = vector3(-561.229, 285.406, 82.376), heading = 355.0, minZ = 82.076, maxZ = 82.676, width = 1.0, height = 0.7, prop = nil, type = 'drink' }, -- planta baja
                { coords = vector3(-561.029, 288.106, 82.376), heading = 355.0, minZ = 82.076, maxZ = 82.676, width = 1.0, height = 0.7, prop = nil, type = 'drink' }, -- planta baja
                { coords = vector3(-567.903, 278.709, 77.476), heading = 355.0, minZ = 76.676, maxZ = 78.276, width = 0.6, height = 1.3, prop = nil, type = 'drink' }, -- subsuelo
            },

            foods = {
                'burrito',
                'nachos_con_queso',
                'papas_rancheras',
                'quesadillas',
                'taco',
            },

            drinks = {
                'acapulco_noche',
                'margarita',
                'mezcal',
                'michelada',
                'tequila',
                'jugo_durazno',
                'sprite',
            }
        },
    },

    ['cafeday'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'cafeday',

        -- ===== Nombre de la facción (qb-core/shared/jobs.lua)
        jobLabel = 'Cafe Day',

        -- ===== Porcentaje de comisión para el vendedor
        comissionPerSale = 25,

        -- ===== Opciones de alertas de abierto/cerrado en qb-radialmenu
        radialMenuStatus = {
            customize = {
                open = {
                    icon                = 'fas fa-coffee fa-shake',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                },
                closed = {
                    icon                = 'fas fa-shop-lock',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                }
            }
        },

        -- ===== Vehiculos & Garage
        vehiclesMenu = {
            menuCoords  = vector4(-521.3588, -40.0200, 43.5175, 45.7777),
            spawnCoords = vector4(-524.8734, -38.1566, 44.5166, 1.3293),

            patentPrefix = 'CF',

            vehicleList = {
                { name = "🛵 Faggio", model = "faggio" },
                { name = "🚗 Issi", model = "issi2" },
                { name = "🚗 Panto", model = "panto" },
                { name = "🚗 Blista", model = "blista" },
            }
        },

        -- ===== Inventarios
        stashes = {
            -- ===== Refrigeradores (para artículos ya preparados y cosas así)
            inventory = {
                { coords = vector3(-512.582, -33.055, 45.625), heading = 355.0, minZ = 44.475, maxZ = 46.775, width = 1.2, height = 0.7 },
                { coords = vector3(-511.482, -35.755, 45.625), heading = 355.0, minZ = 44.475, maxZ = 46.775, width = 0.9, height = 0.7 },
            },

            -- ===== Bandejas (para poder facilitar los artículos a los clientes)
            bar = {
                { coords = vector3(-509.968, -33.976, 45.825), heading = 355.0, minZ = 45.725, maxZ = 45.925, width = 0.7, height = 1.0, prop = 'prop_food_cb_donuts' },
                { coords = vector3(-508.068, -35.376, 45.825), heading = 90.0, minZ = 45.725, maxZ = 45.925, width = 0.7, height = 1.0, prop = 'prop_food_cb_donuts' },
            },

            -- ===== Mesas del comercio
            tables = {
                -- { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
                -- { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            },
        },

        -- ===== Comestibles
        consumables = {
            -- ===== Áreas de Crafteo
            craftingArea = {
                { coords = vector3(-508.082, -36.455, 45.925), heading = 0.0, minZ = 45.675, maxZ = 46.175, width = 1.0, height = 1.1, prop = nil, type = 'drink' },
                { coords = vector3(-514.882, -33.255, 46.025), heading = 0.0, minZ = 45.675, maxZ = 46.175, width = 1.6, height = 0.7, prop = nil, type = 'drink' },

                { coords = vector3(-514.782, -37.455, 45.425), heading = 355.0, minZ = 44.875, maxZ = 45.975, width = 1.2, height = 1.5, prop = nil, type = 'food' },
                { coords = vector3(-512.682, -35.255, 45.625), heading = 355.0, minZ = 45.075, maxZ = 46.175, width = 1.2, height = 0.7, prop = nil, type = 'food' },
            },

            foods = {
                'cafeday_cheesecake',
                'cafeday_muffin_vainilla',
                'cafeday_muffin_chocolate',
                'cafeday_rol_canela',
                'cafeday_croissant_jq',
                'cafeday_mixto_jq',
                'cafeday_focaccia',
            },

            drinks = {
                'cafeday_hot_cocoa',
                'cafeday_americano',
                'cafeday_lemonade_black_tea',
                'cafeday_lemonade_green_tea',
                'cafeday_latte',
                'cafeday_frapuccino',
                'cafeday_caramel_frapuccino',
            }
        },
    },
}

-- ===== No utilizados (se quedan por si se llega a revivir la facción para tener una base pre-hecha)
Config.ShopsRemovidos = {
    ['pizzeria'] = {
        -- ===== Para visualizar los perímetros temporalmente
        debug   = false,

        -- ===== Nombre del job (qb-core/shared/jobs.lua)
        jobName = 'pizzeria',

        -- ===== Nombre de la facción (qb-core/shared/jobs.lua)
        jobLabel = 'Pizza This',

        -- ===== Porcentaje de comisión para el vendedor
        comissionPerSale = 25,

        -- ===== Opciones de alertas de abierto/cerrado en qb-radialmenu
        radialMenuStatus = {
            customize = {
                open = {
                    icon                = 'fas fa-coffee fa-shake',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                },
                closed = {
                    icon                = 'fas fa-shop-lock',
                    iconcolor           = '#ede0d5',
                    iconbackgroundcolor = '#57372a',
                    backgroundcolor     = '#a87058',
                }
            }
        },

        -- ===== Inventarios
        stashes = {
            -- ===== Refrigeradores (para artículos ya preparados y cosas así)
            inventory = {
                { coords = vector3(-1159.196, -1443.675, 4.653), heading = 35.00, minZ = 4.00, maxZ = 6.00, width = 1.4, height = 1.4 },
            },

            -- ===== Bandejas (para poder facilitar los artículos a los clientes)
            bar = {
                { coords = vector3(-1165.88, -1442.07, 4.51), heading = 84.93, minZ = 4.00, maxZ = 6.00, width = 0.5, height = 0.7, prop = 'prop_food_tray_01' },
            },

            -- ===== Mesas del comercio
            tables = {
                { coords = vector3(-1168.002, -1439.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
                { coords = vector3(-1169.502, -1437.736, 4.553), heading = 35.0, minZ = 4.253, maxZ = 6.853, width = 0.95, height = 1.5 },
            },
        },

        -- ===== Comestibles
        consumables = {
            -- ===== Áreas de Crafteo
            craftingArea = {
                { coords = vector3(-1160.633, -1447.763, 4.353), heading = 35.0, minZ = 4.053, maxZ = 6.653, width = 1.4, height = 1.4, prop = nil, type = 'food' },
                { coords = vector3(-1161.632, -1448.963, 4.353), heading = 35.0, minZ = 4.053, maxZ = 6.653, width = 1.4, height = 1.4, prop = nil, type = 'food' },
            },

            foods = {
                'pizza_box_muzzarella',
                'pizza_box_pepperoni',
                'pizza_box_burger',
                'pizza_box_chicken_bbq',
                'pizza_box_jamon_queso',
                'pizza_box_jamon_verduras',
                'pizza_box_onion_bacon',
                'pizza_box_vegetariana'
            },

            drinks = {
            }
        },
    },
}