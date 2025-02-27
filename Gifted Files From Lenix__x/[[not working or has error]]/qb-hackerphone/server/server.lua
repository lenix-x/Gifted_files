local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("hackerphone", function(source)
   local src = source
   local Player = QBCore.Functions.GetPlayer(src)
   local name = Player.PlayerData.charinfo.firstname
   TriggerClientEvent('qb-hackerphone:client:openphone',src,name)
end)

QBCore.Functions.CreateUseableItem("tracker", function(source)
   TriggerClientEvent('qb-hackerphone:client:vehicletracker',source)
end)

QBCore.Functions.CreateUseableItem("centralchip", function(source)
   TriggerClientEvent('qb-hackerphone:client:centralchip',source)
end)

RegisterNetEvent('qb-hackerphone:server:removeitem', function(item)
   local Player = QBCore.Functions.GetPlayer(source)
   Player.Functions.RemoveItem(item, 1)
end)

RegisterNetEvent('qb-hackerphone:server:targetinformation', function()
   local src = source
   local PlayerPed = GetPlayerPed(src)
   local pCoords = GetEntityCoords(PlayerPed)
   local found = false
      for k, v in pairs(QBCore.Functions.GetPlayers()) do
         local TargetPed = GetPlayerPed(v)
         local tCoords = GetEntityCoords(TargetPed)
         local dist = #(pCoords - tCoords)
         if PlayerPed ~= TargetPed and dist < 3.0 then
            found = true
            TargetPlayer = QBCore.Functions.GetPlayer(v)
         end
     end
  if found then 
         local targetinfo = {
            ['targetname'] = TargetPlayer.PlayerData.charinfo.firstname,
            ['targetlastname'] = TargetPlayer.PlayerData.charinfo.lastname,
            ['targetdob'] = TargetPlayer.PlayerData.charinfo.birthdate,
            ['targetphone'] = TargetPlayer.PlayerData.charinfo.phone,
            ['targetbank'] = TargetPlayer.PlayerData.money['bank']
          }
      TriggerClientEvent('qb-hackerphone:client:targetinfornui',src,targetinfo)
   else
      TriggerClientEvent('qb-hackerphone:client:notify',src)
   end
end)

