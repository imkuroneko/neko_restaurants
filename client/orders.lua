lib.locale()
MyOrders = {}

RegisterNetEvent('neko_restaurants:orders:client:loadNewOrder')
AddEventHandler('neko_restaurants:orders:client:loadNewOrder', function(data)
    local idOrder = data.client.cid..'-'..GetGameTimer()
    MyOrders[idOrder] = { client = data.client, order = data.order }
    lib.notify({ description = locale('order__new_attatched'), type = 'success' })
end)

RegisterNetEvent('neko_restaurants:orders:client:listPendingOrders', function()
    if CountItems(MyOrders) == 0 then
        lib.notify({ description = locale('order__list_empty'), type = 'success' })
    else
        local Orders = {}
        for key, value in pairs(MyOrders) do
            table.insert(Orders, {
                title = locale('orders__list_item_title', value.client.name, value.client.cid),
                description = locale('orders__list_item_description', value.order.ammount, value.order.details),
                onSelect = function()
                    TriggerEvent('neko_restaurants:orders:client:removeOrder', { order = key })
                    lib.hideContext(false)
                end,
                arrow = true,
            })
        end

        lib.registerContext({
            id = 'neko_restaurants_orders',
            title = locale('orders__list_header'),
            options = Orders
        })
        lib.showContext('neko_restaurants_orders')
    end
end)

RegisterNetEvent('neko_restaurants:orders:client:removeOrder')
AddEventHandler('neko_restaurants:orders:client:removeOrder', function(data)
    MyOrders[data.order] = nil
    lib.hideContext()
    lib.showContext('neko_restaurants_orders')
    lib.notify({ description = locale('order__removed_from_list'), type = 'success' })
end)


function CountItems(tabla)
    local contador = 0
    for _, valor in pairs(tabla) do
        if type(valor) == "table" then
            contador = contador + 1
        end
    end
    return contador
end