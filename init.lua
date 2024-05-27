local astal = require("astal")
local App = astal.App

local Bar = require("src.widget.bar")
local src = require("src.lib").src

App:start({
	instance_name = "lua",
	request_handler = function(msg, res)
		if msg == "q" or msg == "quit" then
			os.exit(0)
		end
		if msg == "i" or msg == "inspector" then
			res(App:inspector())
		end
	end,
	css = src("style/style.css"),
}, function()
	Bar(0)
end)
