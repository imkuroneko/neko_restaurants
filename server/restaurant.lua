local QBCore = exports["qb-core"]:GetCoreObject()

CreateThread(function()
    -- ========= Crear eventos para el crafteo de consumibles
    for commerceId, commerceData in pairs(Config.Shops) do
        for itemId, itemName in ipairs(commerceData.consumables.foods) do
            local craftServerEvent = 'neko_restaurants:server:validateItems:'..itemName:lower()
            QBCore.Functions.CreateCallback(craftServerEvent, function(source, cb)
                local src = source
                local Player = QBCore.Functions.GetPlayer(src)
                if Config.Crafting.foodItem == '' then cb(true) end
                if Player.Functions.GetItemByName(Config.Crafting.foodItem) == nil or Player.Functions.GetItemByName(Config.Crafting.foodItem).amount < 0 then
                    cb(false)
                end
                cb(true)
            end)

            RegisterNetEvent('neko_restaurants:server:giveItem:'..itemName:lower(), function()
                local Player = QBCore.Functions.GetPlayer(source)
                if not Player then return end
                Player.Functions.AddItem(itemName, 1)
            end)
        end

        for itemId, itemName in ipairs(commerceData.consumables.drinks) do
            local craftServerEvent = 'neko_restaurants:server:validateItems:'..itemName:lower()
            QBCore.Functions.CreateCallback(craftServerEvent, function(source, cb)
                local src = source
                local Player = QBCore.Functions.GetPlayer(src)
                if Config.Crafting.drinkItem == '' then cb(true) end
                if Player.Functions.GetItemByName(Config.Crafting.drinkItem) == nil or Player.Functions.GetItemByName(Config.Crafting.drinkItem).amount < 0 then
                    cb(false)
                end
                cb(true)
            end)

            RegisterNetEvent('neko_restaurants:server:giveItem:'..itemName:lower(), function()
                local Player = QBCore.Functions.GetPlayer(source)
                if not Player then return end
                Player.Functions.AddItem(itemName, 1)
            end)
        end

        if Config.Settings.Inventory == 'ox_inventory' then
            for stashId, stashData in ipairs(commerceData.stashes.inventory) do
                CreateStash(
                    commerceData.jobName..':refrigerador:'..stashId,
                    "Refrigerador "..stashId.." ("..commerceData.jobName..")",
                    Config.Settings.Stashes.maxSlots,
                    Config.Settings.Stashes.maxWeight,
                    { [commerceData.jobName] = 0 },
                    stashData.coords
                )
            end

            for stashId, stashData in ipairs(commerceData.stashes.bar) do
                CreateStash(
                    commerceData.jobName..':TrayMostrador:'..stashId,
                    "Bandeja del Mostrador "..stashId.." ("..commerceData.jobName..")",
                    Config.Settings.Stashes.maxSlots,
                    Config.Settings.Stashes.maxWeight,
                    nil,
                    stashData.coords
                )
            end

            for stashId, stashData in ipairs(commerceData.stashes.tables) do
                CreateStash(
                    commerceData.jobName..':TrayClientes:'..stashId,
                    "Bandeja de la Mesa "..stashId.." ("..commerceData.jobName..")",
                    Config.Settings.Stashes.maxSlots,
                    Config.Settings.Stashes.maxWeight,
                    nil,
                    stashData.coords
                )
            end
        end
    end
end)

RegisterNetEvent('neko_restaurants:server:remove_food_ingredients', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    if Config.Crafting.foodItem == '' then return end
    Player.Functions.RemoveItem(Config.Crafting.foodItem, 1)
end)

RegisterNetEvent('neko_restaurants:server:remove_drink_ingredients', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    if Config.Crafting.drinkItem == '' then return end
    Player.Functions.RemoveItem(Config.Crafting.drinkItem, 1)
end)

function CreateStash(id, label, slots, maxWeight, groups, coords)
    exports.ox_inventory:RegisterStash(id, label, slots, maxWeight, nil, groups, coords)
end