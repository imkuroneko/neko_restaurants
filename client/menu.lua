lib.locale()

-- ========= Eventos del Script =============================================================================================================================
RegisterNetEvent('neko_restaurants:client:updateMenu', function()
    local input = lib.inputDialog(locale('menu__creation_label'), {
        { type = 'input', required = true, icon = { 'fas', 'list' }, label = locale('menu__label'), description = locale('menu__description') }
    })

    if not input then
        return lib.notify({ description = locale('menu__cancelled_creation'), type = 'info' })
    else
        if ValidarEnlace(input[1]) then
            TriggerServerEvent('neko_restaurants:server:updatemenu', input[1])
        else
            lib.notify({ description = locale('menu__error_url_not_valid'), type = 'error' })
        end
    end
end)

RegisterNetEvent('neko_restaurants:client:listImagesMenu', function()
    local menuInfo = lib.callback.await('neko_restaurants:server:getMenuImages', false)
    for menuFaccion, menuUrl in pairs(menuInfo) do
        if menuUrl ~= 'sin_url' then
            RegisterNetEvent('neko_restaurants:client:showmenuimage:'..menuFaccion, function(urlMenu)
                exports['ps-ui']:ShowImage(urlMenu)
            end)
        end
    end
end)

TriggerEvent('neko_restaurants:client:listImagesMenu')

-- ========= Funciones del Script ===========================================================================================================================
function ValidarEnlace(enlace)
    if string.match(enlace, "^https?://[%w-_%.%?%.:/%+=&%@]+$") then
        return true
    else
        return false
    end
end