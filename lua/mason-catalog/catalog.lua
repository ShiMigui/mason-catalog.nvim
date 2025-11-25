local registry = require("mason-registry")
local package_model = require("mason-catalog.package_model")

---@alias MsnCatalogCache {
---  installed: table<string, MsnCatalogPackage>,
---  by_cat: table<MsnCatalogPackageCategories, table<string, MsnCatalogPackage>>,
---}
local _cache = nil

local M = {}

---Builds or returns the cached package metadata.
---@param reset_values boolean? Reset cache if true
---@return MsnCatalogCache
function M.cache(reset_values)
	if reset_values or not _cache then
		local installed, by_cat = {}, { LSP = {}, DAP = {}, Linter = {}, Runtime = {}, Formatter = {} }
		for _, raw in pairs(registry.get_installed_packages()) do
			local pkg = package_model.from(raw)
			installed[pkg.name] = pkg
			for _, cat in ipairs(pkg.categories) do
				by_cat[cat][pkg.name] = pkg
			end
		end
		_cache = { installed = installed, by_cat = by_cat }
	end
	return _cache
end

return M
