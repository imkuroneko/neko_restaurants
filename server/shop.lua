lib.locale()
local ox_inventory = exports.ox_inventory
local listaJobs  = {}
local listaItems = {}

local foodItem   = Config.Settings.Preparation.foodItem
local drinkItem  = Config.Settings.Preparation.drinkItem
local itemsPrice = Config.Settings.Preparation.ItemsPrice

for commerceId, commerceData in pairs(Config.Shops) do
    local jobName = commerceData.jobName
    listaJobs[jobName] = 0
end

if foodItem ~= '' and foodItem ~= nil then
    table.insert(listaItems, { name = foodItem, price = itemsPrice })
end
if drinkItem ~= '' and drinkItem ~= nil then
    table.insert(listaItems, { name = drinkItem, price = itemsPrice })
end

if foodItem ~= '' and drinkItem ~= '' and foodItem ~= nil and drinkItem ~= nil then
    ox_inventory:RegisterShop('nekoRestaurantOxShop', {
        name = locale('store__inventory_label'),
        inventory = listaItems,
        locations = { Config.Settings.StorePrepareItems.targetZone },
        groups = listaJobs
    })
end