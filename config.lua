Config = {}

Config.Debug = false -- Set to true to enable debug
Config.UseMythicNotify = true -- Set to true to use mythic_notify instead of default GTA notifications
Config.defaultVolume = 0.15 -- The default volume for when playing sounds
Config.commandName = "event" -- The command name for the script, by default, the command is /event <arg>
Config.AcePermission = "command.event" -- The ace permission for the specified command above

-- Alerts
Config.Alerts = {
    enabled = true,
    commandName = "alert",
    departments = {
        LSPD = { name = "Los Santos Police Department" },
        BCSO = { name = "Blaine County Sheriff's Office" },
        SAST = { name = "San Andreas State Police" },
        SANG = { name = "San Andreas National Guard" },
        USGVT = { name = "United States Government" },
        SCP = { name = "SCP Foundation" }
    }
}

-- The Purge Event
Config.ThePurge = {
    enabled = true,
    audioFile = "thepurge",
    alertDept = "USGVT"
}

-- Earth Quake Event
Config.EarthQuake = {
    enabled = true,
    effect = "SKY_DIVING_SHAKE",
    audioFile = "earthquake",
    alertDept = "USGVT",
    buildUpMs = 60000,
    wearOffMs = 60000,
    tickIntervalMs = 500,
    intensity = {
        min = 0.1,
        step = 0.5,
        max = 1.0
    }
}

Config.Language = {
    -- General
    nopermission = "ERROR: No Permission",
    invalidargs = "Invalid Arguements. Please use %s",
    -- The Purge
    purgealertmsg = "This is not a test. This is your emergency broadcast system announcing the commencement of the Annual Purge sanctioned by the U.S. Government. Weapons of class 4 and lower have been authorized for use during the Purge. All other weapons are restricted. Government officials of ranking 10 have been granted immunity from the Purge and shall not be harmed. Commencing at the siren, any and all crime, including murder, will be legal for 12 continuous hours. Police, fire, and emergency medical services will be unavailable until tomorrow morning until 7 a.m., when The Purge concludes. Blessed be our New Founding Fathers and America, a nation reborn. May God be with you all.",
    purgeactivated = "You have successfully activated the purge!",
    -- Earthquake
    earthquakealertmsg = "This is not a test. San Andreas is currently under a heavy earthquake. Please remain inside your home at all times.",
    earthquakeactivated = "You have successfully activated an earthquake!"
}
