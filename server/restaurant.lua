lib.locale()
local ox_inventory = exports.ox_inventory
local foodItem  = Config.Settings.Preparation.foodItem
local drinkItem = Config.Settings.Preparation.drinkItem

CreateThread(function()
    -- ========= Crear eventos para el crafteo de consumibles
    for commerceId, commerceData in pairs(Config.Shops) do
        local jobName = commerceData.jobName
        local stashes = commerceData.stashes
        local consumables = commerceData.consumables

        if Config.Settings.UseListMenu then
            for itemId, itemName in ipairs(consumables.foods) do
                local craftServerEvent = 'neko_restaurants:server:validateItems:'..itemName:lower()

                lib.callback.register(craftServerEvent, function(source, cb)
                    if foodItem == '' or foodItem == nil then return true end
                    local items = ox_inventory:Search(source, 'count', { foodItem })
                    if not items or items == 0 then
                        return false
                    end
                    return true
                end)

                RegisterNetEvent('neko_restaurants:server:giveItem:'..itemName:lower(), function()
                    ox_inventory:AddItem(source, itemName, 1)
                end)
            end

            for itemId, itemName in ipairs(consumables.drinks) do
                local craftServerEvent = 'neko_restaurants:server:validateItems:'..itemName:lower()

                lib.callback.register(craftServerEvent, function(source, cb)
                    if drinkItem == '' or drinkItem == nil then return true end
                    local items = ox_inventory:Search(source, 'count', { drinkItem })
                    if not items or items == 0 then
                        return false
                    end
                    return true
                end)

                RegisterNetEvent('neko_restaurants:server:giveItem:'..itemName:lower(), function()
                    ox_inventory:AddItem(source, itemName, 1)
                end)
            end
        else
            local foodCraftCoords = {}
            local drinkCraftCoords = {}

            if #consumables.serviceAreaFood > 0 then
                for i = 1, #consumables.serviceAreaFood do
                    table.insert(foodCraftCoords, consumables.serviceAreaFood[i].coords)
                end
            end

            if #consumables.serviceAreaDrink > 0 then
                for i = 1, #consumables.serviceAreaDrink do
                    table.insert(drinkCraftCoords, consumables.serviceAreaDrink[i].coords)
                end
            end

            local foodStoreName = 'neko_restaurants_'..jobName..'_food'
            local itemsFoods = {}
            for _k, foodData in ipairs(consumables.foods) do
                if foodItem == '' or foodItem == nil then
                    table.insert(itemsFoods, { name = foodData })
                else
                    table.insert(itemsFoods, { name = foodData, currency = foodItem, price = 1 })
                end
            end
            ox_inventory:RegisterShop(foodStoreName, { groups = { [jobName] = 0 }, locations = foodCraftCoords, name = locale('area__service_food'),  inventory = itemsFoods })

            local drinkStoreName = 'neko_restaurants_'..jobName..'_drink'
            local itemsDrinks = {}
            for _k, drinkData in ipairs(consumables.drinks) do
                if drinkItem == '' or drinkItem == nil then
                    table.insert(itemsDrinks, { name = drinkData })
                else
                    table.insert(itemsDrinks, { name = drinkData, currency = drinkItem, price = 1 })
                end
            end
            ox_inventory:RegisterShop(drinkStoreName, { groups = { [jobName] = 0 }, locations = drinkCraftCoords, name = locale('area__service_drink'), inventory = itemsDrinks })
        end

        for stashId, stashData in ipairs(stashes.inventory) do
            local jobName = commerceData.jobName
            local Settings = Config.Settings.Stashes
            CreateStash(
                jobName..':refrigerador:'..stashId,
                locale('stash__label_fridge', stashId, jobName),
                Settings.maxSlots,
                Settings.maxWeight,
                { [commerceData.jobName] = 0 },
                stashData.coords
            )
        end

        for stashId, stashData in ipairs(stashes.bar) do
            local jobName = commerceData.jobName
            local Settings = Config.Settings.Stashes
            CreateStash(
                jobName..':TrayMostrador:'..stashId,
                locale('stash__label_bar', stashId, jobName),
                Settings.maxSlots,
                Settings.maxWeight,
                nil,
                stashData.coords
            )
        end

        for stashId, stashData in ipairs(stashes.tables) do
            local jobName = commerceData.jobName
            local Settings = Config.Settings.Stashes
            CreateStash(
                jobName..':TrayClientes:'..stashId,
                locale('stash__label_tray', stashId, jobName),
                Settings.maxSlots,
                Settings.maxWeight,
                nil,
                stashData.coords
            )
        end
    end
end)

RegisterNetEvent('neko_restaurants:server:remove_food_ingredients', function()
    if foodItem == '' or foodItem == nil then return end
    ox_inventory:RemoveItem(source, foodItem, 1)
end)

RegisterNetEvent('neko_restaurants:server:remove_drink_ingredients', function()
    if drinkItem == '' or drinkItem == nil then return end
    ox_inventory:RemoveItem(source, drinkItem, 1)
end)

function CreateStash(id, label, slots, maxWeight, groups, coords)
    ox_inventory:RegisterStash(id, label, slots, maxWeight, nil, groups, coords)
end