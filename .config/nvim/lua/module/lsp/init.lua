local module = {}
table.insert(module, require 'module.lsp.saga')

-- TODO lazyloading
local plugin = {
  'neovim/nvim-lspconfig',
}

function plugin.config()
  ---@diagnostic disable-next-line: unused-local
  local on_attach = function(client, bufnr)
    require 'keymap'.attach_lsp(bufnr)
  end
  require 'neodev'.setup {}
  local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
  require 'module.lsp.lua'.setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
  require 'module.lsp.clangd'.setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
  require 'module.lsp.lemminx'.setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
  require 'module.lsp.nimlsp'.setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

table.insert(module, plugin)
return module
