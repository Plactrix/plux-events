local active = false

-- Commands
RegisterCommand(Config.commandName, function(source, args, rawCommand)
  if IsPlayerAceAllowed(source, Config.AcePermission) then
		if args[1] then
			if args[1] == "purge" and Config.ThePurge["enabled"] then
				TriggerClientEvent("plux-events:client:typeAlert", -1, Config.Language["purgealertmsg"], Config.ThePurge["alertDept"], true)
				TriggerClientEvent("plux-events:client:playSound", -1, Config.ThePurge["audioFile"])
				Notify(source, Config.Language["purgeactivated"], "success")
			elseif args[1] == "purge" and not Config.ThePurge["enabled"] then
				Notify(source, "The purge event is currently disabled in the config.lua. Please set enabled to true if you would like to use it.", "error")
			end
			if args[1] == "earthquake" and Config.EarthQuake["enabled"] then
				TriggerClientEvent("plux-events:client:typeAlert", -1, Config.Language["earthquakealertmsg"], Config.EarthQuake["alertDept"], true)
				TriggerClientEvent("plux-events:client:startEarthQuake", -1)
				Notify(source, Config.Language["earthquakeactivated"], "success")
				TriggerClientEvent("plux-events:client:playSound", -1, "alert")
				Wait(21500)
				active = true
				CreateThread(function()
					while active do
						TriggerClientEvent("plux-events:client:playSound", -1, Config.EarthQuake["audioFile"])
						Wait(10000)
					end
				end)
				Wait(120000)
				active = false
			elseif args[1] == "earthquake" and not Config.EarthQuake["enabled"] then
				Notify(source, "The earthquake event is currently disabled in the config.lua. Please set enabled to true if you would like to use it.", "error")
			end
		else
			Notify(source, Config.Language["invalidargs"]:format("/" .. Config.commandName .. " [Event]"), "error")
		end
	else
		Notify(source, Config.Language["nopermission"], "error")
	end
end)

RegisterCommand(Config.Alerts.commandName, function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, Config.AcePermission) then
		TriggerClientEvent("plux-events:client:typeAlert", source, table.concat(args, " "), Config.Alerts.departments)
	else
		Notify(source, Config.Language["nopermission"], "error")
	end
end)

-- Events
RegisterServerEvent("plux-events:server:syncAlert")
AddEventHandler("plux-events:server:syncAlert", function(msg, msg2, eventalert)
	if IsPlayerAceAllowed(source, Config.AcePermission) then
		TriggerClientEvent("plux-events:client:sendAlert", -1, msg, msg2, eventalert)
	end
end)

function Notify(source, string, type)
	if Config.UseMythicNotify then
		TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = type, text = string, length = 2500, style = { ["color"] = "#ffffff" } })
	else
		TriggerClientEvent("plux-events:client:Notify", source, string)
	end
end

CreateThread(function()
  Wait(250)
  PerformHttpRequest("https://raw.githubusercontent.com/Plactrix/versions/main/events.json", function(code, res, headers)
    if code == 200 then
      local data = json.decode(res)
      if data["version"] ~= GetResourceMetadata(GetCurrentResourceName(), "version") then
        print("^1Notice^7: There is an update available for ^3plux-events^7. Please head to our github page to update it - https://github.com/Plactrix/plux-events")
      end
    end
  end, "GET
end)