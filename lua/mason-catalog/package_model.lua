--- Represents the known categories a package can belong to.
--- These reflect the roles a package may play inside the Mason ecosystem.
---@alias MsnCatalogPackageCategories
---| "LSP" # Language Server
---| "DAP" # Debug Adapter Protocol
---| "Linter" # Source code linting tool
---| "Runtime" # Language runtime or interpreter
---| "Formatter" # Code formatter

--- A normalized representation of a Mason catalog package.
--- This structure extracts only the relevant metadata that consumers
--- of your catalog might need.
---@class MsnCatalogPackage
---@field languages string[] # List of language identifiers supported by the package
---@field categories MsnCatalogPackageCategories[] # Classification of the package
---@field name string # Display name of the package
---@field lsp_server? string # Optional: LSP server identifier (if provided by the spec)

---@alias MapOfMsnCatalogPackage table<string, MsnCatalogPackage>

local M = {}

--- Converts a Mason Package into a normalized MsnCatalogPackage object.
---
--- The function extracts:
--- - `categories` and `languages` directly from the package spec.
--- - `lsp_server` only when the package exposes neovim-specific metadata.
---
--- @param pkg Package # The Mason registry package instance
--- @return MsnCatalogPackage
function M.from(pkg)
	local spec = pkg.spec
	return {
		categories = spec.categories,
		languages = spec.languages,
		name = pkg.name,
		-- Expose LSP server name if available
		lsp_server = spec.neovim and spec.neovim.lspconfig,
	}
end

return M
