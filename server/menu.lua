local QBCore = exports['qb-core']:GetCoreObject()

-- ========= Eventos del Script =============================================================================================================================
RegisterServerEvent('neko_restaurants:server:updatemenu', function(url)
    local Player = QBCore.Functions.GetPlayer(source)

    local hasPermission = false
    for key, value in pairs(Config.Shops) do
        if Player.PlayerData.job.name == value.jobName then hasPermission = true end
    end

    if not hasPermission then
        TriggerClientEvent('ox_lib:notify', source, { description = 'No tienes permiso para ejecutar este comando', type = 'error' })
    end

    exports.oxmysql:execute([[
        CREATE TABLE IF NOT EXISTS `neko_restaurants_menu` (
            `job` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_general_ci',
            `url` VARCHAR(64) NOT NULL COLLATE 'utf8mb4_general_ci',
            PRIMARY KEY (`job`) USING BTREE
        ) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB ;
    ]], {})

    exports.oxmysql:execute(" INSERT INTO neko_restaurants_menu ( job, url ) VALUES ( ?, ? ) ON DUPLICATE KEY UPDATE url = ? ", {
        Player.PlayerData.job.name,
        url,
        url
    })

    TriggerClientEvent('neko_restaurants:client:listImagesMenu', source)
    TriggerClientEvent('ox_lib:notify', source, { description = 'Se ha actualizado el menú correctamente', type = 'success' })
end)

lib.callback.register('neko_restaurants:server:getMenuImages', function(source, cb)
    -- recuperar datos de la base de datos
    local result = MySQL.query.await(" SELECT job, url FROM neko_restaurants_menu ; ", {})

    -- armar una lista de los jobs
    local listaJobs = {}
    for commerceId, commerceData in pairs(Config.Shops) do
        table.insert(listaJobs, commerceData.jobName)
    end

    -- armar una lista de todas las facciones disponibles en el script, con su correspondiente imagen para el menú
    local images = {}
    for _, registro in ipairs(result) do
        for _, id in ipairs(listaJobs) do
            if registro.job == id then
                images[registro.job] = registro.url or 'sin_url'
                break
            end
        end
    end

    -- crear los items utilizables
    for commerceId, commerceUrl in pairs(images) do
        QBCore.Functions.CreateUseableItem('menu_'..commerceId, function(source)
            TriggerClientEvent("neko_restaurants:client:showmenuimage:"..commerceId, source, commerceUrl)
        end)
    end

    return images
end)

RegisterNetEvent('neko_restaurants:server:giveitem_restaurantmenu', function()
    local Player = QBCore.Functions.GetPlayer(source)

    JobName = ''
    HasPermission = false
    for key, value in pairs(Config.Shops) do
        if Player.PlayerData.job.name == value.jobName then
            HasPermission = true
            JobName = value.jobName
        end
    end

    if not HasPermission then
        TriggerClientEvent('ox_lib:notify', source, { description = 'No tienes permiso para ejecutar este comando', type = 'error' })
    end

    Player.Functions.AddItem('menu_'..JobName, 1)
end)