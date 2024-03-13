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

RegisterNetEvent('neko_restaurants:billing:server:sendBill', function(billedID, ammount, jobName)
    local src = source
    local biller = QBCore.Functions.GetPlayer(src)
    local billed = QBCore.Functions.GetPlayer(tonumber(billedID))

    if listaJobs[jobName] ~= nil then
        if billed ~= nil then
            if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if tonumber(ammount) and tonumber(ammount) > 0 then
                    local balance = billed.Functions.GetMoney('bank')
                    if balance < tonumber(ammount) then
                        TriggerClientEvent('ox_lib:notify', src, { description = 'El cliente no tiene el importe suficiente para pagar', type = 'error' })
                        TriggerClientEvent('ox_lib:notify', tonumber(billedID), { description = 'No tienes suficiente dinero para pagar la factura', type = 'error' })
                        return
                    end
                    TriggerClientEvent('neko_restaurants:billing:client:popupBillMenu', tonumber(billedID), src, tonumber(ammount), jobName)
                else
                    TriggerClientEvent('ox_lib:notify', src, { description = 'No puedes emitir facturas de $0', type = 'error' })
                end
            else
                TriggerClientEvent('ox_lib:notify', src, { description = 'No te puedes enviar facturas a ti mismo', type = 'error' })
            end
        else
            TriggerClientEvent('ox_lib:notify', src, { description = 'El cliente indicado no se encuentra en la ciudad', type = 'error' })
        end
    else
        TriggerClientEvent('ox_lib:notify', src, { description = 'Esta facción no puede emitir facturas', type = 'error' })
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

                SendSucessNotify(source, 'Has aceptado la factura y realizado el pago')
                SendSucessNotify(data.biller, 'El cliente ha aceptado la factura y realizó el pago')

                SendEmail(
                    biller.PlayerData.citizenid,
                    "Factura digital de ".. biller.Job.label,
                    "Factura pagada",
                    string.format("Un cliente ha pagado una factura de $<b>%s</b>", data.ammount)
                )

                SendEmail(
                    billed.PlayerData.citizenid,
                    "Factura digital de ".. biller.Job.label,
                    "Factura pagada",
                    string.format('Has pagado una factura de $%s', data.ammount)
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

                SendSucessNotify(source, 'Has aceptado la factura y realizado el pago')
                SendSucessNotify(data.biller, 'El cliente ha aceptado la factura y realizó el pago')

                SendEmail(
                    biller.PlayerData.citizenid,
                    "Factura digital de ".. biller.PlayerData.job.label,
                    "Factura pagada",
                    string.format("Un cliente ha pagado una factura de $<b>%s</b>.<br><br>Tu comisión es de $<b>%s</b>", data.ammount, sellerComission)
                )
                SendEmail(
                    billed.PlayerData.citizenid,
                    "Factura digital de ".. biller.PlayerData.job.label,
                    "Factura pagada",
                    string.format('Has pagado una factura de $%s', data.ammount)
                )
            end

        else
            SendErrorNotify(source, 'Has rechazado la factura')
            SendErrorNotify(data.biller, 'El cliente ha rechazado la factura')
        end
    end
end)

-- QBCore.Functions.CreateUseableItem("billmachine", function(source, item)
--     local src = source
--     TriggerClientEvent("neko_restaurants:billing:client:usebillmachine", src)
-- end)


function SendErrorNotify(source, message)
    TriggerClientEvent('ox_lib:notify', source, { description = message, type = 'error' })
end

function SendSucessNotify(source, message)
    TriggerClientEvent('ox_lib:notify', source, { description = message, type = 'success' })
end

function SendEmail(citizenId, Sender, Subject, Message)
    TriggerEvent(Config.Settings.Phone..':server:sendNewMailToOffline', citizenId, { sender  = Sender, subject = Subject, message = Message })
end