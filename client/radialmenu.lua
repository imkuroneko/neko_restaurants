local QBCore = exports['qb-core']:GetCoreObject()
local menuID
local listaJobs  = {}
PlayerData = nil

for commerceId, commerceData in pairs(Config.Shops) do
    local jobName = commerceData.jobName
    listaJobs[jobName] = 0
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerData = PlayerData.job
        CreateMenu(PlayerData)
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData = JobInfo
    CreateMenu(PlayerData)
end)

function DeleteMenu()
    if menuID and GetResourceState('qb-radialmenu') == "started" then
        exports['qb-radialmenu']:RemoveOption(menuID)
    end
end

function CreateMenu(PlayerData)
    if GetResourceState('qb-radialmenu') ~= "started" then return end
    DeleteMenu()

    if PlayerData == nil then
        QBCore.Functions.GetPlayerData(function(data)
            PlayerData = data.job
        end)
    end

    if PlayerData == nil or listaJobs[PlayerData.name] == nil or not PlayerData.onduty then
        return -- no necesitamos crearle menú a este job
    end

    local menu = {
        id = 'nekorestaurants',
        title = 'Trabajo',
        icon = 'mug-hot',
        items = {
            {
                id = 'nekorestaurants_menumanager',
                title = 'Carta',
                icon = 'clipboard',
                items = {
                    {
                        id = 'nekorestaurants_updatemenu',
                        title = 'Actualizar Menú',
                        icon = 'clipboard',
                        type = 'client',
                        event = 'neko_restaurants:client:updateMenu',
                        shouldClose = true
                    },
                    {
                        id = 'nekorestaurants_getmenu',
                        title = 'Obtener Menú',
                        icon = 'copy',
                        type = 'server',
                        event = 'neko_restaurants:server:giveitem_restaurantmenu',
                        shouldClose = true
                    },
                }
            },
            {
                id = 'nekorestaurants_avisos',
                title = 'Enviar Anuncio',
                icon = 'business-time',
                type = 'server',
                event = 'nekorestaurants:server:togglenotif_abierto',
                items = {
                    {
                        id = 'nekorestaurants_aviso_abierto',
                        title = 'Abierto',
                        icon = 'business-time',
                        type = 'server',
                        event = 'nekorestaurants:server:togglenotif_abierto',
                        shouldClose = true
                    },
                    {
                        id = 'nekorestaurants_aviso_cerrado',
                        title = 'Cerrado',
                        icon = 'business-time',
                        type = 'server',
                        event = 'nekorestaurants:server:togglenotif_cerrado',
                        shouldClose = true
                    }
                }
            },
            {
                id = 'nekorestaurants_vestido',
                title = 'Vestidor',
                icon = 'shirt',
                type = 'client',
                event = 'neko_restaurants:client:openJobOutfitsMenu',
                shouldClose = true
            },
        }
    }

    if PlayerData.isboss then
        table.insert(menu.items, {
            id = 'nekorestaurants_boss',
            title = 'Menú de jefatura',
            icon = 'briefcase',
            type = 'client',
            event = 'qb-bossmenu:client:OpenMenu',
            shouldClose = true,
        })
    end

    menuID = exports['qb-radialmenu']:AddOption(menu)
end

-- ===== Handler para menú de ropas <3
RegisterNetEvent('neko_restaurants:client:openJobOutfitsMenu', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        TriggerEvent("illenium-apearance:client:outfitsCommand", PlayerData.name)
    end)
end)


-- ===== Eventos a nivel FiveM
AddEventHandler('playerSpawned', function(_)
    CreateMenu()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateMenu()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeleteMenu()
    end
end)
