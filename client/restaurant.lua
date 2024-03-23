lib.locale()
local ox_inventory = exports.ox_inventory
local SpawnedProps = {}
local itemNames = {}

local foodItem  = Config.Settings.Preparation.foodItem
local drinkItem = Config.Settings.Preparation.drinkItem

for item, data in pairs(ox_inventory:Items()) do
    itemNames[item] = data.label
end

-- ========= Eventos del Script =============================================================================================================================
RegisterNetEvent('neko_restaurants:client:createBarTrays', function(trayName, trayId, trayEvent, num, trayParams, config)
    exports['qb-target']:AddBoxZone(
        trayName,
        trayParams.coords,
        trayParams.width,
        trayParams.height,
        { name = trayName, heading = trayParams.heading, debugPoly = config.debug, minZ = trayParams.minZ, maxZ = trayParams.maxZ },
        { distance = 3.0, options = { { icon = 'fas fa-box', label = locale('stash__target_bar', num), event = trayEvent } } }
    )

    RegisterNetEvent(trayEvent, function()
        OpenStash(trayId, config.jobName)
    end)
end)

RegisterNetEvent('neko_restaurants:client:createTablesTrays', function(trayName, trayId, trayEvent, num, trayParams, config)
    exports['qb-target']:AddBoxZone(
        trayName,
        trayParams.coords,
        trayParams.width,
        trayParams.height,
        { name = trayName, heading = trayParams.heading, debugPoly = config.debug, minZ = trayParams.minZ, maxZ = trayParams.maxZ },
        { distance = 3.0, options = { { icon = 'fas fa-box', label = locale('stash__target_tray', num), event = trayEvent } } }
    )

    RegisterNetEvent(trayEvent, function()
        OpenStash(trayId, config.jobName)
    end)
end)

RegisterNetEvent('neko_restaurants:client:createFridge', function(refriName, refriId, refriEvent, num, refriParams, config, jobName)
    exports['qb-target']:AddBoxZone(
        refriName,
        refriParams.coords,
        refriParams.width,
        refriParams.height,
        { name = refriName, heading = refriParams.heading, debugPoly = config.debug, minZ = refriParams.minZ, maxZ = refriParams.maxZ },
        { distance = 2.0, options = { { icon = '', label = locale('stash__target_fridge'), event = refriEvent, job = jobName } } }
    )

    RegisterNetEvent(refriEvent, function()
        OpenStash(refriId, config.jobName)
    end)
end)

RegisterNetEvent('neko_restaurants:client:createServiceArea', function(serviceAreaName, serviceAreaEvent, num, serviceAreaParams, debug, jobName, type)
    local serviceAreaLabel
    if type == 'food' then
        serviceAreaLabel = locale('area__service_food')
    else
        serviceAreaLabel = locale('area__service_drink')
    end

    exports['qb-target']:AddBoxZone(
        serviceAreaName,
        serviceAreaParams.coords,
        serviceAreaParams.width,
        serviceAreaParams.height,
        { name = serviceAreaName, heading = serviceAreaParams.heading, debugPoly = debug, minZ = serviceAreaParams.minZ, maxZ = serviceAreaParams.maxZ },
        { options = { { icon = '', label = serviceAreaLabel, event = serviceAreaEvent, job = jobName } }, distance = 2.0 }
    )
end)

CreateThread(function()
    for commerceId, commerceData in pairs(Config.Shops) do
        local jobName = commerceData.jobName

        -- ========= Bandejas del mostrador
        for stashKey, stashData in ipairs(commerceData.stashes.bar) do
            local trayName  = 'Mostrador '..stashKey..' ('..jobName..')'
            local trayId    = jobName..':TrayMostrador:'..stashKey
            local trayEvent = 'neko_restaurants:TrayMostrador:'..jobName..':'..stashKey

            if stashData.prop ~= nil then
                local obj = CreateObject(GetHashKey(stashData.prop), stashData.coords.x, stashData.coords.y, stashData.coords.z, true, true, false)
                FreezeEntityPosition(obj, true)
                PlaceObjectOnGroundProperly(obj)
                table.insert(SpawnedProps, obj)
            end

            TriggerEvent('neko_restaurants:client:createBarTrays', trayName, trayId, trayEvent, stashKey, stashData, commerceData)
        end

        -- ========= Bandejas para mesas
        for stashKey, stashData in ipairs(commerceData.stashes.tables) do
            local trayName  = 'Bandeja de la Mesa '..stashKey..' ('..jobName..')'
            local trayId    = jobName..':TrayClientes:'..stashKey
            local trayEvent = 'neko_restaurants:TrayClientes:'..jobName..':'..stashKey

            TriggerEvent('neko_restaurants:client:createTablesTrays', trayName, trayId, trayEvent, stashKey, stashData, commerceData)
        end

        -- ========= Refrigeradores (Inventario)
        for inventoryKey, inventoryData in ipairs(commerceData.stashes.inventory) do
            local refriName  = jobName..'_refrigerador_'..inventoryKey
            local refriId    = jobName..':refrigerador:'..inventoryKey
            local refriEvent = 'neko_restaurants:refrigerador'..jobName..'_'..inventoryKey

            TriggerEvent('neko_restaurants:client:createFridge', refriName, refriId, refriEvent, inventoryKey, inventoryData, commerceData, jobName)
        end

        -- ========= Puntos de crafteo
        local serviceAreaFood = commerceData.consumables.serviceAreaFood
        if #serviceAreaFood > 0 then
            for i = 1, #serviceAreaFood do
                local serviceAreaName  = 'serviceArea__'..jobName..'_'..i..'_food'

                local serviceAreaEvent = ''
                if Config.Settings.UseListMenu then
                    serviceAreaEvent = 'neko_restaurants:serviceArea:'..jobName..':food'
                else
                    serviceAreaEvent = 'neko_restaurants:serviceArea:'..jobName..':food:'..i
                end

                if serviceAreaFood[i].prop ~= nil then
                    local obj = CreateObject(GetHashKey(serviceAreaFood[i].prop), serviceAreaFood[i].coords.x, serviceAreaFood[i].coords.y, serviceAreaFood[i].coords.z, true, true, false)
                    FreezeEntityPosition(obj, true)
                    PlaceObjectOnGroundProperly(obj)
                    table.insert(SpawnedProps, obj)
                end

                TriggerEvent('neko_restaurants:client:createServiceArea', serviceAreaName, serviceAreaEvent, i, serviceAreaFood[i], serviceAreaFood[i].debug, jobName, 'food')
            end
        end

        local serviceAreaDrink = commerceData.consumables.serviceAreaDrink
        if #serviceAreaDrink > 0 then
            for i = 1, #serviceAreaDrink do
                local serviceAreaName  = 'serviceArea__'..jobName..'_'..i..'_drink'

                local serviceAreaEvent = ''
                if Config.Settings.UseListMenu then
                    serviceAreaEvent = 'neko_restaurants:serviceArea:'..jobName..':drink'
                else
                    serviceAreaEvent = 'neko_restaurants:serviceArea:'..jobName..':drink:'..i
                end

                if serviceAreaDrink[i].prop ~= nil then
                    local obj = CreateObject(GetHashKey(serviceAreaDrink[i].prop), serviceAreaDrink[i].coords.x, serviceAreaDrink[i].coords.y, serviceAreaDrink[i].coords.z, true, true, false)
                    FreezeEntityPosition(obj, true)
                    PlaceObjectOnGroundProperly(obj)
                    table.insert(SpawnedProps, obj)
                end

                TriggerEvent('neko_restaurants:client:createServiceArea', serviceAreaName, serviceAreaEvent, i, serviceAreaDrink[i], serviceAreaDrink[i].debug, jobName, 'drink')
            end
        end

        -- ========= Listar consumibles para sistema crafteo
        local listaConsumibles = {}
        for foodKey, foodData in ipairs(commerceData.consumables.foods) do
            table.insert(listaConsumibles, { valor = foodData, tipo = 'food' })
        end
        for drinkKey, drinkData in ipairs(commerceData.consumables.drinks) do
            table.insert(listaConsumibles, { valor = drinkData, tipo = 'drink' })
        end

        -- ========= Consumibles (se utiliza solo con el sistema de lista ♥)
        if Config.Settings.UseListMenu then
            for consumableKey, consumableItem in pairs(listaConsumibles) do
                local consumableItemName  = consumableItem.valor
                local craftClientEvent    = 'neko_restaurants:client:createConsumable:'..consumableItemName:lower()
                local craftServerEvent    = 'neko_restaurants:server:validateItems:'..consumableItemName:lower()
                local itemGiveServerEvent = 'neko_restaurants:server:giveItem:'..consumableItemName:lower()

                RegisterNetEvent(craftClientEvent, function()
                    local HasItems = lib.callback.await(craftServerEvent, false)
                    if HasItems then
                        local rewardName = itemNames[consumableItemName]

                        local progressParams = {
                            duration = 4000,
                            label = locale('preparing_food_progress', rewardName),
                            useWhileDead = false,
                            position = 'bottom',
                            canCancel = true,
                            disable = { car = true, move = true, combat = true },
                            anim = { dict = 'amb@prop_human_bbq@male@base', clip = 'base' },
                        }

                        if lib.progressCircle(progressParams) then
                            if consumableItem.tipo == 'food' then
                                if foodItem ~= '' and foodItem ~= nil then
                                    TriggerServerEvent('neko_restaurants:server:remove_food_ingredients')
                                end
                            else
                                if drinkItem ~= '' and drinkItem ~= nil then
                                    TriggerServerEvent('neko_restaurants:server:remove_drink_ingredients')
                                end
                            end

                            TriggerServerEvent(itemGiveServerEvent)

                            lib.notify({ description = locale('preparing_food_success', rewardName), type = 'success' })
                        else
                            lib.notify({ description = locale('preparing_food_cancelled'), type = 'error' })
                        end
                    else
                        lib.notify({ description = locale('preparing_food_not_items'), type = 'error' })
                    end
                end)
            end
        end

        -- ========= Menú de Preparación de alimentos
        if #commerceData.consumables.foods > 0 then
            local eventName = 'neko_restaurants:serviceArea:'..jobName..':food'
            if Config.Settings.UseListMenu then
                RegisterNetEvent(eventName, function()
                    local FoodMenu = {
                        id    = 'neko_restaurants_menu_options:'..jobName..':food',
                        title = locale('area__service_food'),
                        options = {}
                    }

                    for itemId, itemCod in pairs(commerceData.consumables.foods) do
                        table.insert(FoodMenu.options, {
                            title = itemNames[itemCod],
                            icon  = 'fas fa-fw fa-hamburger',
                            event = 'neko_restaurants:client:createConsumable:'..itemCod:lower(),
                        })
                    end

                    lib.registerContext(FoodMenu)
                    lib.showContext(FoodMenu.id)
                end)
            else
                if #commerceData.consumables.serviceAreaFood > 0 then
                    for i = 1, #commerceData.consumables.serviceAreaFood do
                        RegisterNetEvent(eventName..':'..i, function()
                            ox_inventory:openInventory('shop', { type = 'neko_restaurants_'..jobName..'_food', id = i })
                        end)
                    end
                end
            end
        end

        -- ========= Menú de Preparación de bebidas
        if #commerceData.consumables.drinks > 0 then
            local eventName = 'neko_restaurants:serviceArea:'..jobName..':drink'
            if Config.Settings.UseListMenu then
                RegisterNetEvent(eventName, function()
                    local DrinkMenu = {
                        id      = 'neko_restaurants_menu_options:'..jobName..':drink',
                        title   = locale('area__service_drink'),
                        options = {}
                    }

                    for itemId, itemCod in pairs(commerceData.consumables.drinks) do
                        table.insert(DrinkMenu.options, {
                            title = itemNames[itemCod],
                            icon  = 'fas fa-fw fa-glass-whiskey',
                            event = 'neko_restaurants:client:createConsumable:'..itemCod:lower(),
                        })
                    end

                    lib.registerContext(DrinkMenu)
                    lib.showContext(DrinkMenu.id)
                end)
            else
                if #commerceData.consumables.serviceAreaDrink > 0 then
                    for i = 1, #commerceData.consumables.serviceAreaDrink do
                        RegisterNetEvent(eventName..':'..i, function()
                            ox_inventory:openInventory('shop', { type = 'neko_restaurants_'..jobName..'_drink', id = i })
                        end)
                    end
                end
            end
        end
    end
end)

-- ========= Spawn de Props =================================================================================================================================
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    for commerceId, commerceData in pairs(Config.Shops) do
        for stashKey, stashData in ipairs(commerceData.stashes.bar) do
            if stashData.prop ~= nil then SpawnProps(stashData) end
        end
        for propKey, propData in ipairs(commerceData.consumables.serviceAreaFood) do
            if propData.prop ~= nil then SpawnProps(propData) end
        end
        for propKey, propData in ipairs(commerceData.consumables.serviceAreaDrink) do
            if propData.prop ~= nil then SpawnProps(propData) end
        end
    end
end)

-- ========= Limpieza de props ==============================================================================================================================
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    ClearProps()
end)

-- ========= Funciones Varias ===============================================================================================================================
function OpenStash(stashId, factionId)
    ox_inventory:openInventory('stash', { id = stashId, groups = factionId })
end

function SpawnProps(propItem)
    local obj = CreateObject(GetHashKey(propItem.prop), propItem.coords.x, propItem.coords.y, propItem.coords.z, true, true, false)
    FreezeEntityPosition(obj, true)
    PlaceObjectOnGroundProperly(obj)
    table.insert(SpawnedProps, obj)
end

function ClearProps()
    if #SpawnedProps > 0 then
        for _, object in ipairs(SpawnedProps) do
            SetModelAsNoLongerNeeded(object)
            DeleteObject(object)
            DeleteEntity(object)
        end
        SpawnedProps = {}
    end
end