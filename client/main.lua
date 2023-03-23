local isUiOpen = false 
local object = 0
local TestLocalTable = {}
local editingNotpadId = nil

RegisterNUICallback('escape', function(data, cb)
    local text = data.text
    TriggerEvent("rsg-notes:CloseNotepad")
end)

RegisterNUICallback('updating', function(data, cb)
    local text = data.text
    TriggerServerEvent("server:updateNote",editingNotpadId, text)
    editingNotpadId = nil
    TriggerEvent("rsg-notes:CloseNotepad")
end)

RegisterNUICallback('save', function(data, cb)
    local text = data.text
    TriggerEvent("rsg-notes:CloseNotepad")
    TriggerServerEvent('rsg-notes:SaveNote', text)
    TriggerServerEvent("rsg-notes:server:removeitem", 'notes_empty', 1)
end)

RegisterNetEvent("rsg-notes:OpenNotepadGui")
AddEventHandler("rsg-notes:OpenNotepadGui", function()
    if not isUiOpen then
        openGui()
    end
end)

RegisterNetEvent("rsg-notes:OpenNotepadGuiRead")
AddEventHandler("rsg-notes:OpenNotepadGuiRead", function(mensage)
    if not isUiOpen then
        openGuiRead(mensage)
    end
end)

RegisterNetEvent("rsg-notes:CloseNotepad")
AddEventHandler("rsg-notes:CloseNotepad", function()
    SendNUIMessage({
        action = 'closeNotepad'
    })
    SetPlayerControl(PlayerId(), 1, 0)
    isUiOpen = false
    SetNuiFocus(false, false);
    Citizen.Wait(100)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('rsg-notes:note')
AddEventHandler('rsg-notes:note', function()
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
    TriggerEvent("rsg-notes:note")
    isUiOpen = true
    SendNUIMessage({
        action = 'openNotepadRead',
        TextRead = text,
    })
    SetNuiFocus(true, true)
end