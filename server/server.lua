local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('aimedic:docOnline', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local xPlayers = QBCore.Functions.GetPlayers()
    local doctor = 0
    local canpay = false

    local paymentMethod = Config.PaymentMethod  -- Use the default payment method from Config

    if paymentMethod == "cash" and Ply.PlayerData.money["cash"] >= Config.Price then
        canpay = true
    elseif paymentMethod == "bank" and Ply.PlayerData.money["bank"] >= Config.Price then
        canpay = true
    end

    for i=1, #xPlayers, 1 do
        local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
        if xPlayer.PlayerData.job.name == 'ambulance' then
            doctor = doctor + 1
        end
    end

    cb(doctor, canpay)
end)



RegisterServerEvent('aimedic:charge')
AddEventHandler('aimedic:charge', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    local paymentMethod = Config.PaymentMethod  -- Use the default payment method from Config

    if paymentMethod == "cash" and xPlayer.PlayerData.money["cash"] >= Config.Price then
        xPlayer.Functions.RemoveMoney("cash", Config.Price)
    elseif paymentMethod == "bank" and xPlayer.PlayerData.money["bank"] >= Config.Price then
        xPlayer.Functions.RemoveMoney("bank", Config.Price)
    else
        -- Handle other payment methods as needed
        -- You might want to add more conditions based on your specific server's economy system
    end

    TriggerEvent("qb-bossmenu:server:addAccountMoney", 'ambulance', Config.Price)
end)

