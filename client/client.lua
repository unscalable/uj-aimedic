local QBCore = exports['qb-core']:GetCoreObject()

local Active = false
local test1 = nil
local spam = true

RegisterCommand("medic", function(source, args, raw)
    if (QBCore.Functions.GetPlayerData().metadata["isdead"] or QBCore.Functions.GetPlayerData().metadata["inlaststand"]) and spam then
        QBCore.Functions.TriggerCallback('aimedic:docOnline', function(EMSOnline, hasEnoughMoney)
            if EMSOnline <= Config.Doctor and hasEnoughMoney and spam then
                SpawnMedic()
                TriggerServerEvent('aimedic:charge')
                Notify("Your medic is on the way")
            else
                if EMSOnline > Config.Doctor then
                    Notify("There are too many EMT's online", "error")
                elseif not hasEnoughMoney then
                    Notify("Not Enough Money", "error")
                else
                    Notify("Wait EMT's are on the Way", "primary")
                end	
            end
        end)
    else
        Notify("This can only be used in the last stand", "error")
    end
end)

function SpawnMedic()
    spam = false
    local pedHash = GetHashKey('s_m_m_doctor_01')
    local loc = GetEntityCoords(PlayerPedId())
    
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(1)
    end
    
    local spawnRadius = 40                                                    
    local spawnPos, spawnHeading = GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId())

    local medicPed = CreatePed(26, pedHash, spawnPos.x, spawnPos.y, spawnPos.z, spawnHeading, true, false)
    
    mechBlip = AddBlipForEntity(medicPed) 
    SetBlipFlashes(mechBlip, true)  
    SetBlipColour(mechBlip, 5)

    PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
    Wait(2000)
    TaskGoToCoordAnyMeans(medicPed, loc.x, loc.y, loc.z, 1.0, 0, 0, 786603, 0xbf800000)
    test1 = medicPed
    Active = true
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        if Active then
            local loc = GetEntityCoords(GetPlayerPed(-1))
            local ld = GetEntityCoords(test1)
            local dist1 = Vdist(loc.x, loc.y, loc.z, ld.x, ld.y, ld.z)
            if dist1 <= 1 then 
                Active = false
                ClearPedTasksImmediately(test1)
                DoctorNPC()
            end
        end
    end
end)

function DoctorNPC()
    RequestAnimDict("mini@cpr@char_a@cpr_str")
    while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
        Citizen.Wait(1000)
    end

    TaskPlayAnim(test1, "mini@cpr@char_a@cpr_str","cpr_pumpchest",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
    QBCore.Functions.Progressbar("revive_doc", "The medic is treating you", Config.ReviveTime, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(test1)
        Citizen.Wait(500)
        TriggerEvent("hospital:client:Revive") -- Change this line if your server uses a different event for player revival
        Notify("Your treatment is complete. You have been charged: "..Config.Price, "success")
        RemovePedElegantly(test1)
        spam = true
    end)
end

function Notify(msg, state)
    QBCore.Functions.Notify(msg, state)
end
