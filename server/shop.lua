local listaJobs  = {}
local listaItems = {}

for commerceId, commerceData in pairs(Config.Shops) do
    local jobName = commerceData.jobName
    listaJobs[jobName] = 0
end

if Config.Settings.Crafting.foodItem ~= '' and Config.Settings.Crafting.foodItem ~= nil then
    table.insert(listaItems, { name = Config.Settings.Crafting.foodItem, price = Config.Settings.Crafting.ItemsPrice })
end
if Config.Settings.Crafting.drinkItem ~= '' and Config.Settings.Crafting.drinkItem ~= nil then
    table.insert(listaItems, { name = Config.Settings.Crafting.drinkItem, price = Config.Settings.Crafting.ItemsPrice })
end

if Config.Settings.Crafting.foodItem ~= '' and Config.Settings.Crafting.drinkItem ~= '' and Config.Settings.Crafting.foodItem ~= nil and Config.Settings.Crafting.drinkItem ~= nil then
    exports.ox_inventory:RegisterShop('nekoRestaurantOxShop', {
        name = '🍪 Tienda de insumos',
        inventory = listaItems,
        locations = { Config.Settings.StoreCraftItems.targetZone },
        groups = listaJobs
    })
end

-- alguna vez agregaremos el export de qb-shops :)