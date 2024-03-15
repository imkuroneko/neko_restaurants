lib.locale()
local QBCore = exports['qb-core']:GetCoreObject()
local listaJobs  = {}

local function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces > 0 then
        local mult = 10 ^ numDecimalPlaces
        return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

for commerceId, commerceData in pairs(Config.Shops) do
    local jobName = commerceData.jobName
    listaJobs[jobName] = 0
end

RegisterNetEvent('neko_restaurants:billing:server:sendBill', function(data)
    local src = source
    local biller = QBCore.Functions.GetPlayer(src)
    local billed = QBCore.Functions.GetPlayer(tonumber(data.cliente))

    if listaJobs[data.faccion] ~= nil then
        if billed ~= nil then
            if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if tonumber(data.importe) and tonumber(data.importe) > 0 then
                    local balance = billed.Functions.GetMoney('bank')
                    if balance < tonumber(data.importe) then
                        TriggerClientEvent('ox_lib:notify', src, { description = locale('billing__client_no_enough_money'), type = 'error' })
                        TriggerClientEvent('ox_lib:notify', tonumber(data.cliente), { description = locale('billing__you_has_no_money'), type = 'error' })
                    else
                        TriggerClientEvent('neko_restaurants:billing:client:popupBillMenu', tonumber(data.cliente), src, tonumber(data.importe), data.concepto, data.faccion)
                        TriggerClientEvent('ox_lib:notify', src, { description = locale('billing__invoice_sent'), type = 'success' })
                    end
                else
                    TriggerClientEvent('ox_lib:notify', src, { description = locale('billing__no_invoice_0'), type = 'error' })
                end
            else
                TriggerClientEvent('ox_lib:notify', src, { description = locale('billing__no_invoice_yourself'), type = 'error' })
            end
        else
            TriggerClientEvent('ox_lib:notify', src, { description = locale('billing__player_offline'), type = 'error' })
        end
    else
        TriggerClientEvent('ox_lib:notify', src, { description = locale('billing__faction_not_allowed'), type = 'error' })
    end
end)

RegisterNetEvent('neko_restaurants:billing:server:BillPlayer', function(data)
    if listaJobs[data.job] ~= nil then
        if data.accept == 1 then
            local biller = QBCore.Functions.GetPlayer(data.biller)
            local billed = QBCore.Functions.GetPlayer(source)

            if Config.Shops[data.job].comissionPerSale == nil or Config.Shops[data.job].comissionPerSale == 0 then
                billed.Functions.RemoveMoney('bank', data.ammount, "neko_restaurants:billing:payedInvoice")

                if Config.Settings.Management == 'qb-management' then
                    exports['qb-management']:AddMoney(data.job, data.ammount)
                else
                    exports['Renewed-Banking']:addAccountMoney(data.job, data.ammount)
                end

                TriggerClientEvent('ox_lib:notify', source, { description = locale('billing__invoice_accepted'), type = 'success' })
                TriggerClientEvent('ox_lib:notify', data.biller, { description = locale('billing__invoice_payed'), type = 'success' })

                SendEmail(
                    biller.PlayerData.citizenid,
                    locale('billing__email_sender', biller.Job.label),
                    locale('billing__email_subject'),
                    locale('billing__email_content_employee_without_comm', data.ammount)
                )

                SendEmail(
                    billed.PlayerData.citizenid,
                    locale('billing__email_sender', biller.Job.label),
                    locale('billing__email_subject'),
                    locale('billing__email_content_client', data.ammount)
                )
            else
                local sellerComission = round(data.ammount * ( Config.Shops[data.job].comissionPerSale / 100 ))
                local jobMoney = data.ammount - sellerComission

                billed.Functions.RemoveMoney('bank', data.ammount, "neko_restaurants:billing:payedInvoice")
                biller.Functions.AddMoney('bank', sellerComission, "neko_restaurants:billing:comission")

                if Config.Settings.Management == 'qb-management' then
                    exports['qb-management']:AddMoney(data.job, jobMoney)
                else
                    exports['Renewed-Banking']:addAccountMoney(data.job, jobMoney)
                end

                TriggerClientEvent('ox_lib:notify', source, { description = locale('billing__invoice_accepted'), type = 'success' })
                TriggerClientEvent('ox_lib:notify', data.biller, { description = locale('billing__invoice_payed'), type = 'success' })

                SendEmail(
                    biller.PlayerData.citizenid,
                    locale('billing__email_sender', biller.PlayerData.job.label),
                    locale('billing__email_subject'),
                    locale('billing__email_content_employee_with_comm', data.ammount, sellerComission)
                )
                SendEmail(
                    billed.PlayerData.citizenid,
                    locale('billing__email_sender', biller.PlayerData.job.label),
                    locale('billing__email_subject'),
                    locale('billing__email_content_client', data.ammount)
                )
            end

        else
            TriggerClientEvent('ox_lib:notify', source, { description = locale('billing__invoice_rejected'), type = 'error' })
            TriggerClientEvent('ox_lib:notify', data.biller, { description = locale('billing__invoice_not_payed'), type = 'error' })
        end
    end
end)

function SendEmail(citizenId, Sender, Subject, Message)
    TriggerEvent(Config.Settings.Phone..':server:sendNewMailToOffline', citizenId, { sender  = Sender, subject = Subject, message = Message })
end