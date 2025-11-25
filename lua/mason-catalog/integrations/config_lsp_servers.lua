local catalog = require("mason-catalog.catalog")

local M = {
	---@param config_fn vim.lsp.Config
	setup = function(config_fn)
		local LSPs = catalog.cache().by_cat["LSP"]
		for _, pkg in pairs(LSPs) do
			local server = pkg.lsp_server
			vim.lsp.enable(server)
			vim.lsp.config(server, config_fn)
		end
	end,
}

return M
