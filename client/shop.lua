local QBCore = exports["qb-core"]:GetCoreObject()
local ox_inventory = exports.ox_inventory

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
    if Config.Settings.Crafting.foodItem ~= '' and Config.Settings.Crafting.drinkItem ~= '' and Config.Settings.Crafting.foodItem ~= nil and Config.Settings.Crafting.drinkItem ~= nil then

        RequestModel( GetHashKey( Config.Settings.StoreCraftItems.pedModel ) )
        while ( not HasModelLoaded( GetHashKey( Config.Settings.StoreCraftItems.pedModel ) ) ) do
            Wait(1)
        end
        local ped = CreatePed(1, Config.Settings.StoreCraftItems.pedHash, Config.Settings.StoreCraftItems.coords, false, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)

        exports['qb-target']:AddBoxZone(
            'nekoRestaurantsShop',
            Config.Settings.StoreCraftItems.targetZone,
            1, 1,
            { name = 'nekoRestaurantsShop', heading = Config.Settings.StoreCraftItems.targetHeading, debugPoly = false, minZ = Config.Settings.StoreCraftItems.minZ, maxZ = Config.Settings.StoreCraftItems.maxZ, },
            {
                options = {
                    {
                        type = "client",
                        event = "neko_restaurants:client:openStore",
                        icon = "fas fa-shopping-basket",
                        label = "Abrir tienda",
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
        lib.notify({ description = 'No tienes un empleo habilitado para acceder a esta tienda', type = 'error' })
    else
        if not PlayerJob.onduty then
            lib.notify({ description = 'No te encuentras en servicio', type = 'error' })
        else
            ox_inventory:openInventory('shop', { type = 'nekoRestaurantOxShop', id = 1 })
        end
    end
end)

