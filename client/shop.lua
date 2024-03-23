lib.locale()
local QBCore = exports["qb-core"]:GetCoreObject()
local ox_inventory = exports.ox_inventory
local foodItem   = Config.Settings.Preparation.foodItem
local drinkItem  = Config.Settings.Preparation.drinkItem

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
    if foodItem ~= '' and drinkItem ~= '' and foodItem ~= nil and drinkItem ~= nil then

        RequestModel( GetHashKey( Config.Settings.StorePrepareItems.pedModel ) )
        while ( not HasModelLoaded( GetHashKey( Config.Settings.StorePrepareItems.pedModel ) ) ) do
            Wait(1)
        end
        local ped = CreatePed(1, Config.Settings.StorePrepareItems.pedHash, Config.Settings.StorePrepareItems.coords, false, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)

        exports['qb-target']:AddBoxZone(
            'nekoRestaurantsShop',
            Config.Settings.StorePrepareItems.targetZone,
            1, 1,
            {
                name = 'nekoRestaurantsShop',
                heading = Config.Settings.StorePrepareItems.targetHeading,
                debugPoly = false,
                minZ = Config.Settings.StorePrepareItems.minZ,
                maxZ = Config.Settings.StorePrepareItems.maxZ
            },
            {
                options = {
                    {
                        type = "client",
                        event = "neko_restaurants:client:openStore",
                        icon = "fas fa-shopping-basket",
                        label = locale('store__target_label'),
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
        lib.notify({ description = locale('store__not_available'), type = 'error' })
    else
        if not PlayerJob.onduty then
            lib.notify({ description = locale('store__not_duty'), type = 'error' })
        else
            ox_inventory:openInventory('shop', { type = 'nekoRestaurantOxShop', id = 1 })
        end
    end
end)

