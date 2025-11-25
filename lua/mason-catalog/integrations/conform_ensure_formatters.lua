local mason = require('mason-catalog.mason')
return {
  setup = function ()
    local fmts = require('conform').list_all_formatters()
    for _, fmt in ipairs(fmts) do mason.install.pkg(fmt.name) end
  end
}
