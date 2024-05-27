local astal = require("astal")
local Widget, Variable, App, bind = astal.Widget, astal.Variable, astal.App, astal.bind

local date = Variable(""):poll(1000, "date")

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
			label = bind(date),
		}),
	})
end

local function RightBar()
	return Widget.Box({
		class_name = "right",
		halign = "END",
		Widget.Button({
			label = "Click Me!",
			on_clicked = function()
				print("Hello")
			end,
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
			start_widget = LeftBar(),
			center_widget = CenterBar(),
			end_widget = RightBar(),
		}),
	})
end
