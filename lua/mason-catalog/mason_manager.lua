local registry = require("mason-registry")
local M = {}

---@param pkg_name string name of the package to be retrieved from `mason-registry`
function M.get_package(pkg_name)
	local ok, pkg = pcall(registry.get_package, pkg_name)
	if not ok then
		vim.notify(pkg_name .. " not found in `mason-registry`", vim.log.levels.ERROR)
		return nil
	end
	return pkg, pkg:is_installed()
end

---@param pkg_name string name of the package to be installed
function M.install(pkg_name)
	local pkg, installed = M.get_package(pkg_name)
	if not pkg then
		return
	end

	if not installed then
		local op = pkg:install()
		op:on("success", function()
			vim.notify(pkg_name .. " has been installed", vim.log.levels.INFO)
		end)
		op:on("failure", function()
			vim.notify("Mason-catalog could not install " .. pkg_name, vim.log.levels.ERROR)
		end)
		return op
	end
end

---@param pkg_name string name of the package to be uninstalled
function M.uninstall(pkg_name)
	local pkg, installed = M.get_package(pkg_name)
	if not pkg then
		return
	end

	if installed then
		local op = pkg:uninstall()
		op:on("success", function()
			vim.notify(pkg_name .. " has been uninstalled", vim.log.levels.INFO)
		end)
		op:on("failure", function()
			vim.notify("Mason-catalog could not uninstall " .. pkg_name, vim.log.levels.ERROR)
		end)
		return op
	end
end

---@param list string[] name list of packages
---@param cb fun(pkg_name: string): InstallHandle?
function M.for_each(list, cb)
	local map = {}
	for _, nm in ipairs(list) do
		map[nm] = cb(nm)
	end
	return map
end

return M
