local plugin = {
    'glepnir/lspsaga.nvim',
    branch = 'main',
}

function plugin.config()
  local saga = require 'lspsaga'
  saga.init_lsp_saga()
end

return plugin
