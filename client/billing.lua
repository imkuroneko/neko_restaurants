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
    -- Cliente
    local playerTarget = GetNearestPlayerToEntity(data.entity)
    local clientId     = GetPlayerServerId(playerTarget)
    local client = lib.callback.await('neko_restaurants:billing:server:getBilledData', false, { client = clientId })

    -- Empleado
    local billerData = QBCore.Functions.GetPlayerData()
    local jobName = billerData.job.name
    local JobDuty = billerData.job.onduty

    if listaJobs[jobName] ~= nil then
        if JobDuty then
            local input = lib.inputDialog(locale('billing__creation_label'), {
                {
                    type        = 'input',
                    icon        = { 'fas', 'user' },
                    required    = true,
                    disabled    = true,
                    label       = locale('billing__clientname_label'),
                    default     = client.name
                },
                {
                    type        = 'input',
                    icon        = { 'fas', 'id-card' },
                    required    = true,
                    disabled    = true,
                    label       = locale('billing__clientcid_label'),
                    default     = client.cid
                },
                {
                    type        = 'textarea',
                    icon        = { 'fas', 'receipt' },
                    required    = true,
                    label       = locale('billing__concept_label'),
                    description = locale('billing__concept_description'),
                    min         = 5,
                    max         = 5,
                    autosize    = false
                },
                {
                    type        = 'number',
                    icon        = { 'far', 'credit-card' },
                    required    = true,
                    label       = locale('billing__ammount_label'),
                    description = locale('billing__ammount_description'),
                    default     = 100,
                    min         = 1,
                    max         = 1000000
                },
                {
                    type        = 'select',
                    icon        = { 'fas', 'credit-card' },
                    required    = true,
                    disabled    = true,
                    label       = locale('billing__gatewaypay_label'),
                    default     = 'bank',
                    options     = {{ value = 'bank', label = locale('billing__gatewaypay_debitcard') }}
                },
                {
                    type        = 'checkbox',
                    label       = locale('billing__generate_order')
                },
            })

            if not input then return lib.notify({ description = locale('billing__cancelled_creation'), type = 'info' }) end

            local billData = {
                client = { id = clientId, name = client.name, cid = client.cid },
                order  = { details = input[3], ammount = input[4], createOrder = input[6] },
                job    = jobName,
            }

            TriggerServerEvent("neko_restaurants:billing:server:sendBill", billData)
        else
            lib.notify({ description = locale('billing__employee_not_duty'), type = 'error' })
        end
    else
        lib.notify({ description = locale('billing__faction_not_allowed'), type = 'error' })
    end
end)

RegisterNetEvent('neko_restaurants:billing:client:popupBillMenu', function(billerId, data)
    local cabecera =
        locale('billing__header_invoice_number')..":\t"..data.job.."-00"..tostring(math.random(1,9)).."-0"..tostring(math.random(1,999)).."-00"..tostring(math.random(213,999)).."\n"..
        locale('billing__header_payment_form')..":\t\t"..locale('billing__header_payment_label').."\n"..
        locale('billing__header_ammount')..":\t\t$"..data.order.ammount

    lib.registerContext({
        id = 'invoice_menu',
        title = locale('billing__header_label'),
        options = {
            { readOnly = true, title = '', description = cabecera },
            { readOnly = true, title = 'Conceptos', icon = 'box', description = data.order.details },
            {
                title = locale('billing__payment_accept'),
                icon = 'check',
                serverEvent = 'neko_restaurants:billing:server:BillPlayer',
                args = { accept = true, biller = billerId, order = data.order, client = data.client, job = data.job }
            },
            {
                title = locale('billing__payment_reject'),
                icon = 'times',
                serverEvent = 'neko_restaurants:billing:server:BillPlayer',
                args = { accept = false, biller = billerId, order = data.order, client = data.client, job = data.job }
            },
        }
    })
    lib.showContext('invoice_menu')
end)