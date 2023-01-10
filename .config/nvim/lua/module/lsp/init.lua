local module = {}
table.insert(module, require 'module.lsp.saga')

-- TODO lazyloading
local plugin = {
  'neovim/nvim-lspconfig',
}

function plugin.config()
  local on_attach = function(client, bufnr)
    require 'keymap'.attach_lsp(client, bufnr)
  end
  require 'neodev'.setup {}
  local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
  local configs = {
    'clangd',
    'sumneko_lua',
    'vscode-json-language-server',
    -- 'nimlsp',
    -- 'lemminx',
  }
  for _, config in ipairs(configs) do
    require('module.lsp.' .. config).setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end
end

table.insert(module, plugin)
return module
