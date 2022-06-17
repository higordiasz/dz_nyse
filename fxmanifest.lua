fx_version "bodacious"
game "gta5"

ui_page "web/index.html"

client_scripts {
	"@PolyZone/client.lua",
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/vehicles.lua",
	'@mysql-async/lib/MySQL.lua',
	"@vrp/lib/utils.lua",
	"server/*"
}

files {
	"web/*",
	"web/**/*"
}
