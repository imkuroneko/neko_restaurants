lib.locale()
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
                label = locale('billing__target_label'),
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
            local input = lib.inputDialog(locale('billing__creation_label'), {
                {
                    type        = 'number',
                    required    = true,
                    icon        = { 'fas', 'money-bill' },
                    label       = locale('billing__ammount_label'),
                    description = locale('billing__ammount_description'),
                    min         = 1,
                    max         = 1000000,
                },
                {
                    type        = 'textarea',
                    required    = true,
                    icon        = { 'fas', 'receipt' },
                    label       = locale('billing__concept_label'),
                    description = locale('billing__concept_description'),
                    min         = 2,
                    max         = 4,
                    autosize    = false,
                },
                {
                    type        = 'select',
                    required    = true,
                    icon        = { 'fas', 'credit-card' },
                    label       = locale('billing__gatewaypay_label'),
                    default     = 'bank',
                    disabled    = true,
                    options     = { { value = 'bank', label = locale('billing__gatewaypay_debitcard') } }
                }
            })

            if not input then return lib.notify({ description = locale('billing__cancelled_creation'), type = 'info' }) end

            local importe   = input[1]
            local concepto  = input[2]
            local formaPago = input[3] -- decorativo; no se usa en realidad

            TriggerServerEvent("neko_restaurants:billing:server:sendBill", { cliente = billedId, faccion = jobName, importe = importe, concepto = concepto })
        else
            lib.notify({ description = locale('billing__employee_not_duty'), type = 'error' })
        end
    else
        lib.notify({ description = locale('billing__faction_not_allowed'), type = 'error' })
    end
end)

RegisterNetEvent('neko_restaurants:billing:client:popupBillMenu', function(billerId, ammount, concepto, jobName)
    local cabecera =
        locale('billing__header_invoice_number')..":\t"..jobName.."-00"..tostring(math.random(1,9)).."-0"..tostring(math.random(1,999)).."-00"..tostring(math.random(213,999)).."\n"..
        locale('billing__header_payment_form')..":\t\t"..locale('billing__header_payment_label').."\n"..
        locale('billing__header_ammount')..":\t\t$"..ammount

    lib.registerContext({
        id = 'invoice_menu',
        title = locale('billing__header_label'),
        options = {
            { readOnly = true, title = '', description = cabecera },
            { readOnly = true, title = 'Conceptos', icon = 'box', description = concepto },
            {
                title = locale('billing__payment_accept'),
                icon = 'check',
                serverEvent = 'neko_restaurants:billing:server:BillPlayer',
                args = { accept = 1, ammount = ammount, biller = billerId, job = jobName }
            },
            {
                title = locale('billing__payment_reject'),
                icon = 'times',
                serverEvent = 'neko_restaurants:billing:server:BillPlayer',
                args = { accept = 0, ammount = ammount, biller = billerId, job = jobName }
            },
        }
    })
    lib.showContext('invoice_menu')
end)