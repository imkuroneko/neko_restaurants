lib.locale()
local QBCore = exports['qb-core']:GetCoreObject()
local listaJobs  = {}
PlayerData = nil

for commerceId, commerceData in pairs(Config.Shops) do
    local jobName = commerceData.jobName
    listaJobs[jobName] = jobName
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerData = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData = JobInfo
end)


RegisterNetEvent('nekorestaurants:client:notif_abierto')
AddEventHandler('nekorestaurants:client:notif_abierto', function(jobName)
    if listaJobs[jobName] == nil then return end
    local jobInfo = Config.Shops[jobName]

    SendNUIMessage({
        type                = 'nekorestaurants_abierto',
        mensaje             = locale('commerce_status_open', jobInfo.jobLabel),
        backgroundcolor     = jobInfo.radialMenuStatus.customize.open.backgroundcolor,
        iconbackgroundcolor = jobInfo.radialMenuStatus.customize.open.iconbackgroundcolor,
        icon                = jobInfo.radialMenuStatus.customize.open.icon,
        iconcolor           = jobInfo.radialMenuStatus.customize.open.iconcolor,
    })
end)

RegisterNetEvent('nekorestaurants:client:notif_cerrado')
AddEventHandler('nekorestaurants:client:notif_cerrado', function(jobName)
    if listaJobs[jobName] == nil then return end
    local jobInfo = Config.Shops[jobName]

    SendNUIMessage({
        type                = 'nekorestaurants_cerrado',
        mensaje             = locale('commerce_status_closed', jobInfo.jobLabel),
        backgroundcolor     = jobInfo.radialMenuStatus.customize.closed.backgroundcolor,
        iconbackgroundcolor = jobInfo.radialMenuStatus.customize.closed.iconbackgroundcolor,
        icon                = jobInfo.radialMenuStatus.customize.closed.icon,
        iconcolor           = jobInfo.radialMenuStatus.customize.closed.iconcolor,
    })
end)