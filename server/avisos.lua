local QBCore = exports['qb-core']:GetCoreObject()
local listaJobs  = {}

for commerceId, commerceData in pairs(Config.Shops) do
    local jobName = commerceData.jobName
    listaJobs[jobName] = jobName
end

local cooldown = 10 * 1000
local lastUsage = 0

RegisterNetEvent('nekorestaurants:server:togglenotif_abierto')
AddEventHandler('nekorestaurants:server:togglenotif_abierto', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if listaJobs[Player.PlayerData.job.name] == nil then return end

    if not Player.PlayerData.job.onduty then
        TriggerClientEvent('ox_lib:notify', source, { description = 'Debes estar en servicio para enviar el anuncio', type = 'error' })
        return
    end

    local currentTime = GetGameTimer()

    if (currentTime - lastUsage) < cooldown then
        TriggerClientEvent('ox_lib:notify', source, { description = 'Debes esperar unos segundos mas para enviar el anuncio', type = 'error' })
        return
    end


    TriggerClientEvent('nekorestaurants:client:notif_abierto', -1, Player.PlayerData.job.name)
    lastUsage = currentTime
end)

RegisterNetEvent('nekorestaurants:server:togglenotif_cerrado')
AddEventHandler('nekorestaurants:server:togglenotif_cerrado', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if listaJobs[Player.PlayerData.job.name] == nil then return end

    if not Player.PlayerData.job.onduty then
        TriggerClientEvent('ox_lib:notify', source, { description = 'Debes estar en servicio para enviar el anuncio', type = 'error' })
        return
    end

    local currentTime = GetGameTimer()

    if (currentTime - lastUsage) < cooldown then
        TriggerClientEvent('ox_lib:notify', source, { description = 'Debes esperar unos segundos mas para enviar el anuncio', type = 'error' })
        return
    end


    TriggerClientEvent('nekorestaurants:client:notif_cerrado', -1, Player.PlayerData.job.name)
    lastUsage = currentTime
end)