local mason_manager = require("mason-catalog.mason_manager")

--- Default configuration for the catalog setup.
--- `ensure_installed` defines a list of package names that should be
--- automatically installed during setup.
---@class MsnCatalogDefaultOpts
---@field ensure_installed? string[] # Optional list of package names to auto-install

--- Module table.
local default = { ensure_installed = {} }

local M = { mason_manager = mason_manager }

--- Initializes the catalog with user-provided options.
---
--- This function merges the user options with the default configuration
--- and ensures that all requested packages are installed by delegating
--- the work to `mason_manager`.
---
--- Behavior:
--- - User-supplied values override defaults.
--- - If no options are provided, defaults are used.
--- - Each entry in `ensure_installed` is passed to `mason_manager.install`.
---
--- @param opts MsnCatalogDefaultOpts? # Optional configuration table
function M.setup(opts)
	---@type MsnCatalogDefaultOpts
	opts = vim.tbl_extend("force", default, opts or {})
	mason_manager.for_each(opts.ensure_installed, mason_manager.install)
end

return M
