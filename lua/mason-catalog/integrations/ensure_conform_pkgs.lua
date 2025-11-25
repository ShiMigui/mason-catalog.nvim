local mason_manager = require("mason-catalog.mason_manager")
local M = {
	setup = function()
		local list = require("conform").list_all_formatters()
		for _, fmt in ipairs(list) do
			mason_manager.install(fmt.name)
		end
	end,
}
return M
