local lspconfig = require 'lspconfig'
local M = {}

function M.setup(settings)
  lspconfig.sumneko_lua.setup {
    capabilities = settings.capabilities,
    on_attach = settings.on_attach,
    settings = {
      format = {
        enable = true,
        -- Put format options here
        -- NOTE: the value should be STRING!!
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
        },
      },
    },
  }
end

return M
