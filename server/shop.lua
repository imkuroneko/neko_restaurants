local listaJobs  = {}
local listaItems = {}

for commerceId, commerceData in pairs(Config.Shops) do
    local jobName = commerceData.jobName
    listaJobs[jobName] = 0
end

if Config.foodCraftItem ~= '' and Config.foodCraftItem ~= nil then
    table.insert(listaItems, { name = Config.foodCraftItem, price = Config.craftItemsPrice })
end
if Config.drinkCraftItem ~= '' and Config.drinkCraftItem ~= nil then
    table.insert(listaItems, { name = Config.drinkCraftItem, price = Config.craftItemsPrice })
end

if Config.foodCraftItem ~= '' and Config.drinkCraftItem ~= '' and Config.foodCraftItem ~= nil and Config.drinkCraftItem ~= nil then
    exports.ox_inventory:RegisterShop('nekoRestaurantOxShop', {
        name = '🍪 Tienda de insumos',
        inventory = listaItems,
        locations = { Config.StoreCraftItems.targetZone },
        groups = listaJobs
    })
end

-- alguna vez agregaremos el export de qb-shops :)