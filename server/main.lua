local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('sr-notes:SaveNote')
AddEventHandler('sr-notes:SaveNote', function(mensage)
  local src = source
  local Player = RSGCore.Functions.GetPlayer(src)
  local info = {
    mensage = mensage,
  }
  Player.Functions.AddItem('notes', 1, nil, info)
  TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['notes'], "add")
end)

RSGCore.Functions.CreateUseableItem('notes_empty', function(source, item)
  TriggerClientEvent('sr-notes:note', source)
    TriggerClientEvent('sr-notes:OpenNotepadGui', source)
end)

RSGCore.Functions.CreateUseableItem('notes', function(source, item)
  TriggerClientEvent('sr-notes:note', source)
  TriggerClientEvent('sr-notes:OpenNotepadGuiRead', source, item.info.mensage)
end)

RegisterServerEvent('sr-notes:server:removeitem')
AddEventHandler('sr-notes:server:removeitem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'remove')
end)