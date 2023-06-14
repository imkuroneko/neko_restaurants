local QBCore = exports["qb-core"]:GetCoreObject()

-- ========= Eventos del Script =============================================================================================================================
RegisterNetEvent('neko_restaurants:client:createBarTrays', function(trayName, trayEvent, num, trayParams, config)
    exports['qb-target']:AddBoxZone(
        trayName,
        trayParams.coords,
        trayParams.width,
        trayParams.height,
        { name = trayName, heading = trayParams.heading, debugPoly = config.debug, minZ = trayParams.minZ, maxZ = trayParams.maxZ },
        { distance = 3.0, options = { { icon = "fas fa-box", label = "Mostrador "..num, event = trayEvent } } }
    )

    RegisterNetEvent(trayEvent, function()
        TriggerServerEvent("inventory:server:OpenInventory", "stash", trayName, { maxweight = 125000, slots = 10 })
        TriggerEvent("inventory:client:SetCurrentStash", trayName)
    end)
end)

RegisterNetEvent('neko_restaurants:client:createTablesTrays', function(trayName, trayEvent, num, trayParams, config)
    exports['qb-target']:AddBoxZone(
        trayName,
        trayParams.coords,
        trayParams.width,
        trayParams.height,
        { name = trayName, heading = trayParams.heading, debugPoly = config.debug, minZ = trayParams.minZ, maxZ = trayParams.maxZ },
        { distance = 3.0, options = { { icon = "fas fa-box", label = "Mesa "..num, event = trayEvent } } }
    )

    RegisterNetEvent(trayEvent, function()
        TriggerServerEvent("inventory:server:OpenInventory", "stash", trayName, { maxweight = 125000, slots = 10 })
        TriggerEvent("inventory:client:SetCurrentStash", trayName)
    end)
end)

RegisterNetEvent('neko_restaurants:client:createFridge', function(refriName, refriEvent, num, refriParams, config)
    exports['qb-target']:AddBoxZone(
        refriName,
        refriParams.coords,
        refriParams.width,
        refriParams.height,
        { name = refriName, heading = refriParams.heading, debugPoly = config.debug, minZ = refriParams.minZ, maxZ = refriParams.maxZ },
        { distance = 2.0, options = { { icon = "", label = "📦 Abrir refrigerador", event = refriEvent, job = jobName } } }
    )

    RegisterNetEvent(refriEvent, function()
        TriggerEvent("inventory:client:SetCurrentStash", refriName)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", refriName, { maxweight = 250000, slots = 20 })
    end)
end)

RegisterNetEvent('neko_restaurants:client:createCraftArea', function(craftAreaName, craftAreaEvent, num, craftAreaParams, config)
    local craftAreaLabel
    if craftAreaParams.type == 'food' then
        craftAreaLabel = Config.foodCraftAreaLabel
    else
        craftAreaLabel = Config.drinkCraftAreaLabel
    end

    exports['qb-target']:AddBoxZone(
        craftAreaName,
        craftAreaParams.coords,
        craftAreaParams.width,
        craftAreaParams.height,
        { name = craftAreaName, heading = craftAreaParams.heading, debugPoly = config.debug, minZ = craftAreaParams.minZ, maxZ = craftAreaParams.maxZ },
        { distance = 2.0, options = { { icon = "", label = craftAreaLabel, event = craftAreaEvent, job = jobName } } }
    )
end)

-- ========= Preparar las zonas para los comercios ==========================================================================================================
CreateThread(function()
    for commerceId, commerceData in pairs(Config.shops) do
        local jobName = commerceData.jobName

        -- ========= Bandejas del mostrador
        for stashKey, stashData in ipairs(commerceData.stashesBar) do
            local trayName  = "Bandeja del Mostrador "..stashKey.." ("..jobName..")"
            local trayEvent = "neko_restaurants:TrayMostrador:"..jobName..':'..stashKey

            if stashData.prop ~= nil then
                local obj = CreateObject(stashData.prop, stashData.coords.x, stashData.coords.y, stashData.coords.z, true, true, false)
                FreezeEntityPosition(obj, true)
            end

            TriggerEvent("neko_restaurants:client:createBarTrays", trayName, trayEvent, stashKey, stashData, commerceData)
        end

        -- ========= Bandejas para mesas
        for stashKey, stashData in ipairs(commerceData.stashesTables) do
            local trayName  = "Bandeja de la Mesa "..stashKey.." ("..jobName..")"
            local trayEvent = "neko_restaurants:TrayClientes:"..jobName..':'..stashKey

            TriggerEvent("neko_restaurants:client:createTablesTrays", trayName, trayEvent, stashKey, stashData, commerceData)
        end

        -- ========= Refrigeradores (Inventario)
        for inventoryKey, inventoryData in ipairs(commerceData.stashesInventory) do
            local refriName  = jobName.."_refrigerador_"..inventoryKey
            local refriEvent = "neko_restaurants:refrigerador"..jobName..'_'..inventoryKey

            TriggerEvent("neko_restaurants:client:createFridge", refriName, refriEvent, inventoryKey, inventoryData, Config)
        end

        -- ========= Bandejas para mesas
        for craftKey, craftData in ipairs(commerceData.craftingArea) do
            local craftAreaName  = "craftArea__"..jobName.."_"..craftKey.."_"..craftData.type
            local craftAreaEvent = "neko_restaurants:serviceCraftArea:"..jobName..':'..craftData.type

            TriggerEvent("neko_restaurants:client:createCraftArea", craftAreaName, craftAreaEvent, craftKey, craftData, commerceData)
        end

        -- ========= Listar crafteables para sistema crafteo
        local listaCrafteables = {}
        for foodKey, foodData in ipairs(commerceData.craftablesFoods) do
            table.insert(listaCrafteables, { valor = foodData, tipo = 'food' })
        end
        for drinkKey, drinkData in ipairs(commerceData.craftablesDrinks) do
            table.insert(listaCrafteables, { valor = drinkData, tipo = 'drink' })
        end

        -- ========= Crafteables
        for craftableKey, craftableItem in pairs(listaCrafteables) do
            local craftableItemName = craftableItem.valor
            local craftClientEvent    = 'neko_restaurants:client:craftConsumable:'..craftableItemName:lower()
            local craftServerEvent    = 'neko_restaurants:server:validateItems:'..craftableItemName:lower()
            local itemGiveServerEvent = 'neko_restaurants:server:giveItem:'..craftableItemName:lower()

            RegisterNetEvent(craftClientEvent, function()
                QBCore.Functions.TriggerCallback(craftServerEvent, function(HasItems)
                    if HasItems then
                        local rewardName = QBCore.Shared.Items[craftableItemName:lower()].label

                        QBCore.Functions.Progressbar("pickup_sla", "Preparando "..rewardName, 4000, false, true,
                            { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true },
                            { animDict = "amb@prop_human_bbq@male@base", anim = "base", flags = 8 },
                            {},
                            {},
                            function()
                                local itemToRemove = nil
                                if craftableItem.tipo == 'food' then
                                    if Config.foodCraftItem ~= '' then
                                        itemToRemove = QBCore.Shared.Items[Config.foodCraftItem]
                                    end
                                    TriggerServerEvent('neko_restaurants:server:remove_food_ingredients')
                                    TriggerServerEvent(itemGiveServerEvent)
                                else
                                    if Config.drinkCraftItem ~= '' then
                                        itemToRemove = QBCore.Shared.Items[Config.drinkCraftItem]
                                    end
                                    TriggerServerEvent('neko_restaurants:server:remove_drink_ingredients')
                                    TriggerServerEvent(itemGiveServerEvent)
                                end

                                if itemToRemove ~= nil then
                                    TriggerEvent("inventory:client:ItemBox", itemToRemove, "remove")
                                end

                                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[craftableItemName], "add")

                                QBCore.Functions.Notify("Has preparado exitosamente x1 "..rewardName, "success")
                            end,
                            function()
                                QBCore.Functions.Notify("Has cancelado la preparación de la "..rewardName, "error")
                            end
                        )
                    else
                        QBCore.Functions.Notify("No cuentas con los ingredientes", "error")
                    end
                end)
            end)
        end

        -- ========= Menú de Crafteo alimentos
        if #commerceData.craftablesFoods > 0 then
            local craftName = 'neko_restaurants:serviceCraftArea:'..jobName..':food'

            RegisterNetEvent(craftName, function(data)
                local craftMenu = {
                    { header = "🍳 Estación de alimentos", txt = "¿Qué deseas preparar?", isMenuHeader = true }
                }

                for itemId, itemCod in pairs(commerceData.craftablesFoods) do
                    table.insert(craftMenu, { header = QBCore.Shared.Items[itemCod:lower()].label, txt = "", params = { event = 'neko_restaurants:client:craftConsumable:'..itemCod:lower() } })
                end

                table.insert(craftMenu, { header = "Cerrar", txt = "", params = { event = "qb-menu:closeMenu" } })

                exports['qb-menu']:openMenu(craftMenu)
            end)
        end

        -- ========= Menú de Crafteo bebidas
        if #commerceData.craftablesDrinks > 0 then
            local craftName = 'neko_restaurants:serviceCraftArea:'..jobName..':drink'

            RegisterNetEvent(craftName, function(data)
                local craftMenu = {
                    { header = "🥤 Estación de bebidas", txt = "¿Qué deseas preparar?", isMenuHeader = true }
                }

                for itemId, itemCod in pairs(commerceData.craftablesDrinks) do
                    table.insert(craftMenu, { header = QBCore.Shared.Items[itemCod:lower()].label, txt = "", params = { event = 'neko_restaurants:client:craftConsumable:'..itemCod:lower() } })
                end

                table.insert(craftMenu, { header = "Cerrar", txt = "", params = { event = "qb-menu:closeMenu" } })

                exports['qb-menu']:openMenu(craftMenu)
            end)
        end
    end
end)