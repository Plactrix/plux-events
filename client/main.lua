-- Events
RegisterNetEvent("plux-events:client:sendAlert")
AddEventHandler("plux-events:client:sendAlert", function(msg, msg2, eventalert)
	if eventalert then
        SendNUIMessage({
            type    = "alert",
            enable  = true,
            issuer  = msg,
            message = msg2,
            volume  = 0.0
        })
	else
        SendNUIMessage({
            type    = "alert",
            enable  = true,
            issuer  = msg,
            message = msg2,
            volume  = Config.defaultVolume
        })
	end
end)

RegisterNetEvent("plux-events:client:typeAlert")
AddEventHandler("plux-events:client:typeAlert", function(msg, departments, eventalert)
	if eventalert then
		TriggerServerEvent("plux-events:server:syncAlert", Config.Alerts.departments[departments].name, msg, true)
	else
        for i, v in pairs(departments) do
            if msg == i then
                DisplayOnscreenKeyboard(1, "Message to Alert", "", "", "", "", "", 600)
                while UpdateOnscreenKeyboard() == 0 do
                    DisableAllControlActions(0)
                    Wait(0)
                end
                if GetOnscreenKeyboardResult() then
                    msg = departments[i].name
                    local msg2 = GetOnscreenKeyboardResult()
                    TriggerServerEvent("plux-events:server:syncAlert", msg, msg2, false)
                end
            end
        end
	end
end)

RegisterNetEvent("plux-events:client:Notify")
AddEventHandler("plux-events:client:Notify", function(string)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(string)
	DrawNotification(true, true)
end)

RegisterNetEvent("plux-events:client:playSound")
AddEventHandler("plux-events:client:playSound", function(soundFile)
    SendNUIMessage({
        transactionType     = "playSound",
        transactionFile     = soundFile,
        transactionVolume   = Config.defaultVolume
    })
end)

local earthquaking = false
RegisterNetEvent("plux-events:client:startEarthQuake")
AddEventHandler("plux-events:client:startEarthQuake", function()
	if earthquaking then
		return
	end
	earthquaking = true
    local activeMs = 0
    local intensity = Config.EarthQuake.intensity.min
    local totalDurationMs = Config.EarthQuake.buildUpMs + Config.EarthQuake.wearOffMs
    ShakeGameplayCam(Config.EarthQuake.effect, intensity)
    while (activeMs < totalDurationMs) do
        if (activeMs < Config.EarthQuake.buildUpMs) then
            SetGameplayCamShakeAmplitude(intensity)
            intensity = intensity + Config.EarthQuake.intensity.step
            if (intensity > Config.EarthQuake.intensity.max) then
                intensity = Config.EarthQuake.intensity.max
            end
        else
            intensity = intensity - Config.EarthQuake.intensity.step
            if (intensity < Config.EarthQuake.intensity.min) then
                intensity = Config.EarthQuake.intensity.min
            end 
            SetGameplayCamShakeAmplitude(intensity)
        end
        Wait(Config.EarthQuake.tickIntervalMs)
        activeMs = activeMs + Config.EarthQuake.tickIntervalMs
    end
    ShakeGameplayCam(Config.EarthQuake.effect, 0.0)
    earthquaking = false
end)

-- Threads
CreateThread(function()
	TriggerEvent("chat:addSuggestion", "/" .. Config.commandName, "Used for server events", {
    	{ name="Event", help="List of Events: purge, earthquake" }
	})
	TriggerEvent("chat:addSuggestion", "/" .. Config.Alerts.commandName, "Used for alerting for server events", {
    	{ name="Department", help="Example: USVG" }
	})
end)

-- Functions
function Notify(string, type)
	if Config.UseMythicNotify then
		exports['mythic_notify']:SendAlert(type, string, 2580, { ["color"] = "#ffffff" })
	else
		SetNotificationTextEntry("STRING")
		AddTextComponentSubstringPlayerName(string)
		DrawNotification(true, true)
	end
end