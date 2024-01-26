# aimedic

A simple NPC Medic script for QBcore. Drag the file into your resources, open the config, and set prices to match your server's economy. Use the command `/medic`. 

## Installation

1. Drag the script file into your resources.
2. Open the configuration file and adjust prices to match your server's economy.
3. Use the command `/medic` to activate the script.

## Usage

Add the following code in your `qb-ambulancejob` client/main.lua file:

```lua
RegisterNetEvent('hospital:client:npcHospital', function()
    print("Hello")
    local bedId = GetAvailableBed()
    print(bedId)
    if bedId then
        TriggerServerEvent("hospital:server:SendToBed", bedId, true)
    else
        QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
    end
end)
