local plugin = {
  'glepnir/lspsaga.nvim',
  cmd = 'Lspsaga',
  module = { 'lspsaga.diagnostic', 'lspsaga' },
  event = 'LspAttach',
  branch = 'main',
}

function plugin.config()
  local saga = require 'lspsaga'
  saga.init_lsp_saga {
    code_action_lightbulb = {
      virtual_text = false,
    },
  }
end

return plugin
