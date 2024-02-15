Config = {}

-- ===== Configuraciones Generales del script
Config.Settings = {
    -- ===== Script de inventario
    Inventory       = 'ox_inventory',  -- 'ox_inventory' || 'qb-inventory'

    -- ===== Script de teléfono
    Phone           = 'qs-smartphone', -- esto se concatena a eventos en server/billing.lua:53 & 59

    -- ===== Crafteos
    Crafting = {
        ItemsPrice = 20, -- precio del item
        foodItem   = 'item_craft_comidas', -- nombre del item para crafteo de alimentos
        drinkItem  = 'item_craft_bebidas', -- nombre del item para crafteo de bebidas
    },

    -- ===== Sistema de Managements/Cobros
    Management      = 'Renewed-Banking', -- 'Renewed-Banking' || 'qb-management'

    -- ===== Tienda de insumos para crafteos
    StoreCraftItems = {
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
        pedModel = 'a_m_m_eastsa_02',
        pedHash  = 0x07DD91AC
    },

    -- ===== Config stashes
    Stashes = {
        maxSlots  = 20,
        maxWeight = 125000
    }
}

-- ===== i18n
Config.i18n = {
    foodCraftAreaLabel  = '🍳 Estación de alimentos',
    drinkCraftAreaLabel = '🥤 Estación de bebidas',
    commerceOpen        = '¡%s está abierto!',
    commerceClosed      = '¡%s está cerrado!',
}

-- ===== Facciones
Config.Shops = {
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
            enableOptions = true,
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

        -- ===== Estacionamiento
        parking = {},
    },
}