local QBCore = exports["qb-core"]:GetCoreObject()

CreateThread(function()
    -- ========= Crear eventos para el crafteo de consumibles
    for commerceId, commerceData in pairs(Config.shops) do
        for itemId, itemName in ipairs(commerceData.craftablesFoods) do
            local craftServerEvent = 'neko_restaurants:server:validateItems:'..itemName:lower()
            QBCore.Functions.CreateCallback(craftServerEvent, function(source, cb)
                local src = source
                local Player = QBCore.Functions.GetPlayer(src)
                if Config.foodCraftItem == '' then cb(true) end
                if Player.Functions.GetItemByName(Config.foodCraftItem) == nil or Player.Functions.GetItemByName(Config.foodCraftItem).amount < 0 then
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

        for itemId, itemName in ipairs(commerceData.craftablesDrinks) do
            local craftServerEvent = 'neko_restaurants:server:validateItems:'..itemName:lower()
            QBCore.Functions.CreateCallback(craftServerEvent, function(source, cb)
                local src = source
                local Player = QBCore.Functions.GetPlayer(src)
                if Config.drinkCraftItem == '' then cb(true) end
                if Player.Functions.GetItemByName(Config.drinkCraftItem) == nil or Player.Functions.GetItemByName(Config.drinkCraftItem).amount < 0 then
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
    end
end)

RegisterNetEvent('neko_restaurants:server:remove_food_ingredients', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    if Config.foodCraftItem == '' then return end
    Player.Functions.RemoveItem(Config.foodCraftItem, 1)
end)

RegisterNetEvent('neko_restaurants:server:remove_drink_ingredients', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    if Config.drinkCraftItem == '' then return end
    Player.Functions.AddItem(Config.drinkCraftItem, 1)
end)
