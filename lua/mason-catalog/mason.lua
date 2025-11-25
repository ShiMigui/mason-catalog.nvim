local registry = require("mason-registry")
local function err(message)
	return function() vim.notify(message, vim.log.levels.ERROR) end
end

local M = {}
M.install = {}
M.uninstall = {}

function M.get_package(pkg_name)
	local ok, pkg = pcall(registry.get_package, pkg_name)
	if ok then return pkg end
	vim.notify("Package not found: " .. pkg_name, vim.log.levels.ERROR)
	return nil
end

function M.install.pkg(pkg_name)
	local pkg = M.get_package(pkg_name)
	if pkg and not pkg:is_installed() then
		pkg:install():on("failure", err("Failed to install package: " .. pkg_name))
	end
end

function M.install.pkgs(pkgs)
	for _, p in ipairs(pkgs) do
		M.install.pkg(p)
	end
end

function M.uninstall.pkg(pkg_name)
	local pkg = M.get_package(pkg_name)
	if pkg and pkg:is_installed() then
		pkg:uninstall():on("failure", err("Failed to uninstall package: " .. pkg_name))
	end
end

function M.uninstall.pkgs(pkgs)
	for _, p in ipairs(pkgs) do
		M.uninstall.pkg(p)
	end
end

return M

