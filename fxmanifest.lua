fx_version "bodacious"
game "gta5"

ui_page "web/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"@vrp/lib/utils.lua",
	"server/*"
}

files {
	"web/*",
	"web/**/*"
}
