vim.opt.rtp:prepend(vim.fn.getcwd())

---@alias MsnCatalogPkgCategory "LSP" | "Runtime" | "Linter" | "Formatter" | "DAP" | string

---@class MsnCatalogPkg
---@field id string
---@field lspname? string
---@field categories MsnCatalogPkgCategory[]
---@field languages string[]

---@class MsnCatalogDefaultOpts
---@field ensure_installed? string[]
local default = { ensure_installed = {}, integrations = {} }

local M = {}
M.mason = require("mason-catalog.mason")

---@param opts MsnCatalogDefaultOpts
function M.setup(opts)
	---@type MsnCatalogDefaultOpts
	opts = vim.tbl_extend("force", default, opts or {})
	M.mason.install.pkgs(opts.ensure_installed)
end

M.setup({ensure_installed = {"typescript-language-server"}})

return M
