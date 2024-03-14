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
            local input = lib.inputDialog('🧾 Crear Factura', {
                {
                    type        = 'number',
                    required    = true,
                    icon        = { 'fas', 'money-bill' },
                    label       = 'Importe a cobrar',
                    description = 'El importe total de la factura',
                    min         = 1,
                    max         = 1000000,
                },
                {
                    type        = 'textarea',
                    required    = true,
                    icon        = { 'fas', 'receipt' },
                    label       = 'Concepto',
                    description = 'Productos/Servicios adquiridos',
                    min         = 2,
                    max         = 4,
                    autosize    = false,
                },
                {
                    type        = 'select',
                    required    = true,
                    icon        = { 'fas', 'credit-card' },
                    label       = 'Forma de pago',
                    default     = 'bank',
                    disabled    = true,
                    options     = { { value = 'bank', label = 'Tarjeta de Débito' } }
                }
            })

            if not input then return lib.notify({ description = 'Has cancelado la emisión de la factura', type = 'info' }) end

            local importe   = input[1]
            local concepto  = input[2]
            local formaPago = input[3] -- decorativo; no se usa en realidad

            TriggerServerEvent("neko_restaurants:billing:server:sendBill", { cliente = billedId, faccion = jobName, importe = importe, concepto = concepto })
        else
            lib.notify({ description = 'Debes estar en servicio para emitir facturas', type = 'error' })
        end
    else
        lib.notify({ description = 'No eres empleado de un comercio para emitir facturas', type = 'error' })
    end
end)

RegisterNetEvent('neko_restaurants:billing:client:popupBillMenu', function(billerId, ammount, concepto, jobName)
    local cabecera =
        "Número de Boleta:\t"..jobName.."-00"..tostring(math.random(1,9)).."-0"..tostring(math.random(1,999)).."-00"..tostring(math.random(213,999)).."\n"..
        "Forma de Pago:\t\tTransferencia\n"..
        "Importe a pagar:\t\t$"..ammount

    lib.registerContext({
        id = 'invoice_menu',
        title = '🧾 Tu Factura Digital 🧾',
        options = {
            { readOnly = true, title = '', description = cabecera },
            { readOnly = true, title = 'Conceptos', icon = 'box', description = concepto },
            {
                title = 'Aceptar factura',
                icon = 'check',
                serverEvent = 'neko_restaurants:billing:server:BillPlayer',
                args = { accept = 1, ammount = ammount, biller = billerId, job = jobName }
            },
            {
                title = 'Cancelar factura',
                icon = 'times',
                serverEvent = 'neko_restaurants:billing:server:BillPlayer',
                args = { accept = 0, ammount = ammount, biller = billerId, job = jobName }
            },
        }
    })
    lib.showContext('invoice_menu')
end)