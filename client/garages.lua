local QBCore = exports['qb-core']:GetCoreObject()
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


CreateThread(function()
    for commerceId, commerceData in pairs(Config.Shops) do
        local jobName = commerceData.jobName

        if commerceData.vehiclesMenu ~= nil then
            -- === Datos base
            local dataCoords = commerceData.vehiclesMenu.menuCoords
            local listaVehs  = commerceData.vehiclesMenu.vehicleList
            local dataVec3   = vector3(dataCoords.x, dataCoords.y, dataCoords.z)

            -- === Spawnear NPC
            RequestModel(GetHashKey(Config.Settings.Garages.pedModel))
            while (not HasModelLoaded(GetHashKey(Config.Settings.Garages.pedModel))) do
                Wait(1)
            end
            local ped = CreatePed(1, Config.Settings.Garages.pedHash, dataCoords, false, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            PlaceObjectOnGroundProperly(ped)

            local eventGetVehicle  = "neko_restaurants:client:garage:vehiclelist_"..commerceId
            local eventSaveVehicle = "neko_restaurants:client:garage:returnvehicle_"..commerceId

            -- === Crear target
            exports['qb-target']:AddBoxZone("garage_"..commerceId, dataVec3, 2.5, 2.5, {
                name = "garage_"..commerceId,
                heading = dataCoords.h,
                debugPoly = false,
                minZ = -40.0,
                maxZ = 285.0,
            }, {
                options = {
                    {
                        event = eventGetVehicle,
                        icon = "fas fa-car",
                        label = "Quitar Vehículo",
                        canInteract = function(entity, distance, data)
                            if PlayerData == nil or listaJobs[PlayerData.name] == nil or not PlayerData.onduty then return false end -- no usar si no tenemos el job o estamos fuera de servicio
                            return true
                        end,
                    },
                    {
                        event = eventSaveVehicle,
                        icon = "fas fa-circle",
                        label = "Devolver vehículo",
                        canInteract = function(entity, distance, data)
                            if PlayerData == nil or listaJobs[PlayerData.name] == nil or not PlayerData.onduty then return false end -- no usar si no tenemos el job o estamos fuera de servicio
                            return true
                        end,
                    },
                },
                job = { [commerceId] = 0 },
                distance = 3.5
            })

            -- === Crear Eventos
            RegisterNetEvent(eventGetVehicle, function()
                for i = 1, #listaVehs do
                    local MenuOptions = {
                        { header = "Vehículos Disponibles", isMenuHeader = true },
                    }

                    for k, v in pairs(listaVehs) do
                        MenuOptions[#MenuOptions + 1] = {
                            header = v.name,
                            params = {
                                event = "neko_restaurants:client:garage:spawnvehicle",
                                args = {
                                    id = v.model,
                                    cs = commerceData.vehiclesMenu.spawnCoords,
                                    pf = commerceData.vehiclesMenu.patentPrefix
                                }
                            }
                        }
                    end
                    exports['qb-menu']:openMenu(MenuOptions)
                end
            end)

            RegisterNetEvent(eventSaveVehicle, function()
                local car = GetVehiclePedIsIn(PlayerPedId(), true)

                if car ~= 0 then
                    local plate = GetVehicleNumberPlateText(car)
                    if string.find(tostring(plate), commerceData.vehiclesMenu.patentPrefix) then
                        DeleteVehicle(car)
                        DeleteEntity(car)
                    else
                        QBCore.Functions.Notify("Este vehículo no es de tu trabajo", "error")
                    end
                else
                    QBCore.Functions.Notify("No veo el vehículo, asegurate haberlo dejado cerca", "error")
                end
            end)
        end
    end
end)

RegisterNetEvent("neko_restaurants:client:garage:spawnvehicle", function(vehicle)
    local model  = vehicle.id
    local spawn  = vehicle.cs
    local prefix = vehicle.pf

    QBCore.Functions.SpawnVehicle(model, function(veh)
        SetVehicleNumberPlateText(veh, prefix..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, spawn.w)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, spawn, true)
end)