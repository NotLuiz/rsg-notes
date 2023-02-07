local isUiOpen = false 
local object = 0
local TestLocalTable = {}
local editingNotpadId = nil

RegisterNUICallback('escape', function(data, cb)
    local text = data.text
    TriggerEvent("sr-notes:CloseNotepad")
end)

RegisterNUICallback('updating', function(data, cb)
    local text = data.text
    TriggerServerEvent("server:updateNote",editingNotpadId, text)
    editingNotpadId = nil
    TriggerEvent("sr-notes:CloseNotepad")
end)

RegisterNUICallback('save', function(data, cb)
    local text = data.text
    TriggerEvent("sr-notes:CloseNotepad")
    TriggerServerEvent('sr-notes:SaveNote', text)
    TriggerServerEvent("sr-notes:server:removeitem", 'notes_empty', 1)
end)

RegisterNetEvent("sr-notes:OpenNotepadGui")
AddEventHandler("sr-notes:OpenNotepadGui", function()
    if not isUiOpen then
        openGui()
    end
end)

RegisterNetEvent("sr-notes:OpenNotepadGuiRead")
AddEventHandler("sr-notes:OpenNotepadGuiRead", function(mensage)
    if not isUiOpen then
        openGuiRead(mensage)
    end
end)

RegisterNetEvent("sr-notes:CloseNotepad")
AddEventHandler("sr-notes:CloseNotepad", function()
    SendNUIMessage({
        action = 'closeNotepad'
    })
    SetPlayerControl(PlayerId(), 1, 0)
    isUiOpen = false
    SetNuiFocus(false, false);
    Citizen.Wait(100)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('sr-notes:note')
AddEventHandler('sr-notes:note', function()
    local player = PlayerPedId()
    if (DoesEntityExist(player) and not IsEntityDead(player)) then
		Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_WRITE_NOTEBOOK"), -1, false, false, false, false)
    end
end)

function openGui() 
    SetPlayerControl(PlayerId(), 0, 0)
    SendNUIMessage({
        action = 'openNotepad',
    })
    isUiOpen = true
    SetNuiFocus(true, true);
end

function openGuiRead(text)
    SetPlayerControl(PlayerId(), 0, 0)
    TriggerEvent("sr-notes:note")
    isUiOpen = true
    SendNUIMessage({
        action = 'openNotepadRead',
        TextRead = text,
    })
    SetNuiFocus(true, true)
end