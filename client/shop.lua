local QBCore = exports["qb-core"]:GetCoreObject()
PlayerJob = nil
local listaJobs  = {}

for commerceId, commerceData in pairs(Config.Shops) do
    local jobName = commerceData.jobName
    listaJobs[jobName] = 0
end

-- ========= Eventos QBCore =================================================================================================================================
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

CreateThread(function()
    if Config.foodCraftItem ~= '' and Config.drinkCraftItem ~= '' and Config.foodCraftItem ~= nil and Config.drinkCraftItem ~= nil then

        RequestModel( GetHashKey( Config.StoreCraftItems.pedModel ) )
        while ( not HasModelLoaded( GetHashKey( Config.StoreCraftItems.pedModel ) ) ) do
            Wait(1)
        end
        local ped = CreatePed(1, Config.StoreCraftItems.pedHash, Config.StoreCraftItems.coords, false, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)

        exports['qb-target']:AddBoxZone(
            'nekoRestaurantsShop',
            Config.StoreCraftItems.targetZone,
            1, 1,
            { name = 'nekoRestaurantsShop', heading = Config.StoreCraftItems.targetHeading, debugPoly = false, minZ = Config.StoreCraftItems.minZ, maxZ = Config.StoreCraftItems.maxZ, },
            {
                options = {
                    {
                        type = "client",
                        event = "neko_restaurants:client:openStore",
                        icon = "fas fa-shopping-basket",
                        label = "Abrir tienda",
                        -- job = listaJobs
                        canInteract = function(entity, distance, data)
                            if PlayerJob == nil then return false end
                            if listaJobs[PlayerJob.name] == nil or not PlayerJob.onduty then return false end -- no usar si no tenemos el job o estamos fuera de servicio
                            return true
                        end,
                    },
                },
                distance = 3.0
            }
        )
    end
end)

RegisterNetEvent('neko_restaurants:client:openStore', function()
    if listaJobs[PlayerJob.name] == nil then
        QBCore.Functions.Notify('No tienes permitido acceder a esta tienda', 'error')
    else
        if not PlayerJob.onduty then
            QBCore.Functions.Notify('No te encuentras en servicio', 'error')
        else
            exports.ox_inventory:openInventory( 'shop', { type = 'nekoRestaurantOxShop', id = 1 })
        end
    end
end)

