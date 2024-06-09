local astal = require("astal")
local Widget, App = astal.Widget, astal.App
local date = require("src.lib").date

local function LeftBar()
	return Widget.Box({
		class_name = "left",
		halign = "START",
		Widget.Label({
			label = "Welcome to Astal.lua!",
		}),
	})
end

local function CenterBar()
	return Widget.Box({
		class_name = "center",
		Widget.Label({
			label = date(),
		}),
	})
end

local function RightBar()
	local function on_clicked()
		print("Hello")
	end

	return Widget.Box({
		class_name = "right",
		halign = "END",

		Widget.Button({
			on_clicked = on_clicked,
			"Click Me!",
		}),
	})
end

return function(monitor)
	return Widget.Window({
		application = App,
		id = "bar",
		name = "bar" .. tostring(monitor),
		class_name = "bar",
		monitor = monitor,
		anchor = astal.Astal.WindowAnchor.TOP + astal.Astal.WindowAnchor.LEFT + astal.Astal.WindowAnchor.RIGHT,
		exclusivity = "EXCLUSIVE",

		Widget.CenterBox({
			class_name = "bar",
			LeftBar(),
			CenterBar(),
			RightBar(),
		}),
	})
end
