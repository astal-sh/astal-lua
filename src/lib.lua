local Variable = require("astal").Variable

local M = {}

function M.src(path)
	local str = debug.getinfo(2, "S").source:sub(2)
	local src = str:match("(.*/)") or str:match("(.*\\)") or "./"
	return src .. "src/" .. path
end

M.date = Variable(""):poll(1000, "date")

return M
