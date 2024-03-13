local QBCore = exports["qb-core"]:GetCoreObject()
local ox_inventory = exports.ox_inventory
local SpawnedProps = {}
local itemNames = {}

local foodItem  = Config.Settings.Crafting.foodItem
local drinkItem = Config.Settings.Crafting.drinkItem

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
        { distance = 3.0, options = { { icon = "fas fa-box", label = "Mostrador "..num, event = trayEvent } } }
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
        { distance = 3.0, options = { { icon = "fas fa-box", label = "Mesa "..num, event = trayEvent } } }
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
        { distance = 2.0, options = { { icon = "", label = "📦 Abrir refrigerador", event = refriEvent, job = jobName } } }
    )

    RegisterNetEvent(refriEvent, function()
        OpenStash(refriId, config.jobName)
    end)
end)

RegisterNetEvent('neko_restaurants:client:createCraftArea', function(craftAreaName, craftAreaEvent, num, craftAreaParams, config, jobName)
    local craftAreaLabel
    if craftAreaParams.type == 'food' then
        craftAreaLabel = Config.i18n.foodCraftAreaLabel
    else
        craftAreaLabel = Config.i18n.drinkCraftAreaLabel
    end

    exports['qb-target']:AddBoxZone(
        craftAreaName,
        craftAreaParams.coords,
        craftAreaParams.width,
        craftAreaParams.height,
        { name = craftAreaName, heading = craftAreaParams.heading, debugPoly = config.debug, minZ = craftAreaParams.minZ, maxZ = craftAreaParams.maxZ },
        { options = { { icon = "", label = craftAreaLabel, event = craftAreaEvent, job = jobName } }, distance = 2.0 }
    )
end)

CreateThread(function()
    for commerceId, commerceData in pairs(Config.Shops) do
        local jobName = commerceData.jobName

        -- ========= Bandejas del mostrador
        for stashKey, stashData in ipairs(commerceData.stashes.bar) do
            local trayName  = "Mostrador "..stashKey.." ("..jobName..")"
            local trayId    = jobName..':TrayMostrador:'..stashKey
            local trayEvent = "neko_restaurants:TrayMostrador:"..jobName..':'..stashKey

            if stashData.prop ~= nil then
                local obj = CreateObject(GetHashKey(stashData.prop), stashData.coords.x, stashData.coords.y, stashData.coords.z, true, true, false)
                FreezeEntityPosition(obj, true)
                PlaceObjectOnGroundProperly(obj)
                table.insert(SpawnedProps, obj)
            end

            TriggerEvent("neko_restaurants:client:createBarTrays", trayName, trayId, trayEvent, stashKey, stashData, commerceData)
        end

        -- ========= Bandejas para mesas
        for stashKey, stashData in ipairs(commerceData.stashes.tables) do
            local trayName  = "Bandeja de la Mesa "..stashKey.." ("..jobName..")"
            local trayId    = jobName..':TrayClientes:'..stashKey
            local trayEvent = "neko_restaurants:TrayClientes:"..jobName..':'..stashKey

            TriggerEvent("neko_restaurants:client:createTablesTrays", trayName, trayId, trayEvent, stashKey, stashData, commerceData)
        end

        -- ========= Refrigeradores (Inventario)
        for inventoryKey, inventoryData in ipairs(commerceData.stashes.inventory) do
            local refriName  = jobName.."_refrigerador_"..inventoryKey
            local refriId    = jobName..':refrigerador:'..inventoryKey
            local refriEvent = "neko_restaurants:refrigerador"..jobName..'_'..inventoryKey

            TriggerEvent("neko_restaurants:client:createFridge", refriName, refriId, refriEvent, inventoryKey, inventoryData, commerceData, jobName)
        end

        -- ========= Puntos de crafteo
        for craftKey, craftData in ipairs(commerceData.consumables.craftingArea) do
            local craftAreaName  = "craftArea__"..jobName.."_"..craftKey.."_"..craftData.type
            local craftAreaEvent = "neko_restaurants:serviceCraftArea:"..jobName..':'..craftData.type

            if craftData.prop ~= nil then
                local obj = CreateObject(GetHashKey(craftData.prop), craftData.coords.x, craftData.coords.y, craftData.coords.z, true, true, false)
                FreezeEntityPosition(obj, true)
                PlaceObjectOnGroundProperly(obj)
                table.insert(SpawnedProps, obj)
            end

            TriggerEvent("neko_restaurants:client:createCraftArea", craftAreaName, craftAreaEvent, craftKey, craftData, commerceData, jobName)
        end

        -- ========= Listar crafteables para sistema crafteo
        local listaCrafteables = {}
        for foodKey, foodData in ipairs(commerceData.consumables.foods) do
            table.insert(listaCrafteables, { valor = foodData, tipo = 'food' })
        end
        for drinkKey, drinkData in ipairs(commerceData.consumables.drinks) do
            table.insert(listaCrafteables, { valor = drinkData, tipo = 'drink' })
        end

        -- ========= Crafteables (se utiliza solo con el sistema de lista ♥)
        if Config.Settings.UseListMenu then
            for craftableKey, craftableItem in pairs(listaCrafteables) do
                local craftableItemName = craftableItem.valor
                local craftClientEvent    = 'neko_restaurants:client:craftConsumable:'..craftableItemName:lower()
                local craftServerEvent    = 'neko_restaurants:server:validateItems:'..craftableItemName:lower()
                local itemGiveServerEvent = 'neko_restaurants:server:giveItem:'..craftableItemName:lower()

                RegisterNetEvent(craftClientEvent, function()
                    local HasItems = lib.callback.await(craftServerEvent, false)
                    if HasItems then
                        local rewardName = itemNames[craftableItemName]

                        local craftParams = {
                            duration = 4000,
                            label = 'Preparando '..rewardName,
                            useWhileDead = false,
                            position = 'bottom',
                            canCancel = true,
                            disable = { car = true, move = true, combat = true },
                            anim = { dict = 'amb@prop_human_bbq@male@base', clip = 'base' },
                        }

                        if lib.progressCircle(craftParams) then
                            if craftableItem.tipo == 'food' then
                                if foodItem ~= '' and foodItem ~= nil then
                                    TriggerServerEvent('neko_restaurants:server:remove_food_ingredients')
                                end
                            else
                                if drinkItem ~= '' and drinkItem ~= nil then
                                    TriggerServerEvent('neko_restaurants:server:remove_drink_ingredients')
                                end
                            end

                            TriggerServerEvent(itemGiveServerEvent)

                            lib.notify({ description = 'Has preparado exitosamente x1 '..rewardName, type = 'success' })
                        else
                            lib.notify({ description = 'Has dejado de preparar el alimento', type = 'error' })
                        end
                    else
                        lib.notify({ description = 'No cuentas con los ingredientes necesarios', type = 'error' })
                    end
                end)
            end
        end

        -- ========= Menú de Crafteo alimentos
        if #commerceData.consumables.foods > 0 then
            local craftName = 'neko_restaurants:serviceCraftArea:'..jobName..':food'
            if Config.Settings.UseListMenu then
                RegisterNetEvent(craftName, function()
                    local CraftMenu = {
                        id    = 'neko_restaurants_craft_options:'..jobName..':food',
                        title = Config.i18n.foodCraftAreaLabel,
                        options = {}
                    }

                    for itemId, itemCod in pairs(commerceData.consumables.foods) do
                        table.insert(CraftMenu.options, {
                            title = itemNames[itemCod],
                            icon  = 'fas fa-fw fa-hamburger',
                            event = 'neko_restaurants:client:craftConsumable:'..itemCod:lower(),
                        })
                    end

                    lib.registerContext(CraftMenu)
                    lib.showContext(CraftMenu.id)
                end)
            else
                RegisterNetEvent(craftName, function()
                    ox_inventory:openInventory('shop', { type = 'neko_restaurants_'..jobName..'_food', id = 1 })
                end)
            end
        end

        -- ========= Menú de Crafteo bebidas
        if #commerceData.consumables.drinks > 0 then
            local craftName = 'neko_restaurants:serviceCraftArea:'..jobName..':drink'
            if Config.Settings.UseListMenu then
                RegisterNetEvent(craftName, function()
                    local CraftMenu = {
                        id      = 'neko_restaurants_craft_options:'..jobName..':drink',
                        title   = Config.i18n.drinkCraftAreaLabel,
                        options = {}
                    }

                    for itemId, itemCod in pairs(commerceData.consumables.drinks) do
                        table.insert(CraftMenu.options, {
                            title = itemNames[itemCod],
                            icon  = 'fas fa-fw fa-glass-whiskey',
                            event = 'neko_restaurants:client:craftConsumable:'..itemCod:lower(),
                        })
                    end

                    lib.registerContext(CraftMenu)
                    lib.showContext(CraftMenu.id)
                end)
            else
                RegisterNetEvent(craftName, function()
                    ox_inventory:openInventory('shop', { type = 'neko_restaurants_'..jobName..'_drink', id = 1 })
                end)
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
        for craftKey, craftData in ipairs(commerceData.consumables.craftingArea) do
            if craftData.prop ~= nil then SpawnProps(craftData) end
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