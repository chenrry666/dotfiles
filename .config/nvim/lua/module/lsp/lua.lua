local lspconfig = require 'lspconfig'
local M = {}

function M.setup(settings)
  local lua_library = vim.api.nvim_get_runtime_file('lua/', true)
  table.insert(lua_library, '/usr/share/luajit-2.1.0-beta3')
  lspconfig.sumneko_lua.setup {
    capabilities = settings.capabilities,
    on_attach = settings.on_attach,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          path = {
            '?.lua',
            '?/init.lua',
            '/usr/share/5.1/?.lua',
            '/usr/share/lua/5.1/?/init.lua',
            '/usr/share/luajit-2.1.0-beta3/?.lua',
            '/usr/share/luajit-2.1.0-beta3/?/init.lua',
          },
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = lua_library,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
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
    },
  }
end

return M
