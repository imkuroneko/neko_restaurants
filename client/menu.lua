local QBCore = exports["qb-core"]:GetCoreObject()
local playerJob = nil

-- ========= Eventos QBCore =================================================================================================================================
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        playerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    playerJob = JobInfo
end)


-- ========= Eventos del Script =============================================================================================================================
RegisterNetEvent('neko_restaurants:client:updateMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "📋 Menú del local",
        submitText = "Guardar",
        inputs = {
            { text = "Enlace del menú (imgur)", name = "url", type = "url", isRequired = true },
        },
    })

    if dialog ~= nil and dialog.url then
        if ValidarUrlImgur(dialog.url) then
            TriggerServerEvent('neko_restaurants:server:updatemenu', dialog.url)
        else
            QBCore.Functions.Notify("Solo se permiten imágenes subidas a imgur", 'error')
        end
    end
end)

RegisterNetEvent('neko_restaurants:client:listImagesMenu', function()
    QBCore.Functions.TriggerCallback('neko_restaurants:server:getMenuImages', function(menuInfo)
        for menuFaccion, menuUrl in pairs(menuInfo) do
            if menuUrl ~= 'sin_url' then
                RegisterNetEvent('neko_restaurants:client:showmenuimage:'..menuFaccion, function(urlMenu)
                    TriggerEvent('animations:client:EmoteCommandStart', { "clipboard" })
                    exports['ps-ui']:ShowImage(urlMenu)
                end)
            end
        end
    end)
end)

TriggerEvent('neko_restaurants:client:listImagesMenu')

-- ========= Funciones del Script ===========================================================================================================================
function ValidarUrlImgur(input)
    local dominio = string.match(input, "https://([^/]+)")
    if dominio ~= "i.imgur.com" then
        return false
    end
    return true
end