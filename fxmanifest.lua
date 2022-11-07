fx_version "adamant"
game "gta5"

author "Plux Modifications || https://discord.gg/DEQ95eVmQ3"
description "A script used for Event Nights on FiveM"
version "1.0.0"

files {
	"html/sounds/*.ogg",
    "html/css/*.css",
    "html/js/*.js",
    "html/mp3/*.mp3",
    "html/fonts/*.*",
	"html/index.html"
}

ui_page "html/index.html"

shared_scripts {
    "config.lua"
}

client_scripts {
    "client/main.lua"
}

server_scripts {
    "server/main.lua"
}