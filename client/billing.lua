local QBCore = exports['qb-core']:GetCoreObject()

local listaJobs  = {}
PlayerData = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerData = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData = JobInfo
end)


for commerceId, commerceData in pairs(Config.Shops) do
    local jobName = commerceData.jobName
    listaJobs[jobName] = 0
end


-- ===== Crear interacción con qb-target
Citizen.CreateThread(function()
    exports['qb-target']:AddGlobalPlayer({
        options = {
            {
                type  = "client",
                event = "neko_restaurants:billing:client:openBillingMenu",
                icon  = 'fa-solid fa-receipt',
                label = 'Enviar Factura',
                canInteract = function(entity, distance, data)
                    if not IsPedAPlayer(entity) then return false end -- ignorar npc
                    if PlayerData == nil or listaJobs[PlayerData.name] == nil or not PlayerData.onduty then return false end -- no usar si no tenemos el job o estamos fuera de servicio
                    return true
                end,
                job = listaJobs
            }
        },
        distance = 5.0,
    })
end)


RegisterNetEvent('neko_restaurants:billing:client:openBillingMenu', function(data)
    -- Target
    local playerTarget = GetNearestPlayerToEntity(data.entity)
    local billedId     = GetPlayerServerId(playerTarget)

    -- Empleado
    local billerData = QBCore.Functions.GetPlayerData()
    local jobName = billerData.job.name
    local JobDuty = billerData.job.onduty

    if listaJobs[jobName] ~= nil then
        if JobDuty then
            local bill = exports['qb-input']:ShowInput({
                header = '🧾 Crear Factura',
                submitText = 'Enviar Factura Digital',
                inputs  = {
                    { text = 'Importe a cobrar', name = 'ammount', type = 'number', isRequired = true }
                }
            })
            if bill ~= nil then
                if bill.ammount == nil then return false end
                TriggerServerEvent("neko_restaurants:billing:server:sendBill", billedId, bill.ammount, jobName)
                lib.notify({ description = 'La factura se envió al cliente', type = 'success' })
            end
        else
            lib.notify({ description = 'Debes estar en servicio para emitir facturas', type = 'error' })
        end
    else
        lib.notify({ description = 'No eres empleado de un comercio para emitir facturas', type = 'error' })
    end
end)

RegisterNetEvent('neko_restaurants:billing:client:popupBillMenu', function(billerId, ammount, jobName)
    exports['qb-menu']:openMenu({
        { isMenuHeader = true, header = "🧾 Factura Digital 🧾", txt = "" },
        {
            isMenuHeader = true,
            header = "<h4>Detalles:</h4>",
            txt =
                "<b>Boleta:</b> "..jobName.."-00"..tostring(math.random(1,9)).."-0"..tostring(math.random(1,999)).."-00"..tostring(math.random(213,999)).."<br>"..
                "<b>Forma de Pago:</b> Transferencia<br>"..
                "<b>Importe a pagar:</b> $"..ammount
        },
        {
            icon = "fas fa-circle-check",
            header = "Aceptar la factura",
            txt = "Acepto el importe total para realizar el pago automático",
            params = {
                isServer = true,
                event = "neko_restaurants:billing:server:BillPlayer",
                args = { accept = 1, ammount = ammount, biller = billerId, job = jobName }
            }
        },
        {
            icon = "fas fa-circle-xmark",
            header = "Rechazar la factura",
            txt = "Niego el importe total de la transacción",
            params = {
                isServer = true,
                event = "neko_restaurants:billing:server:BillPlayer",
                args = { accept = 0, ammount = ammount, biller = billerId, job = jobName }
            }
        }
    })
end)
