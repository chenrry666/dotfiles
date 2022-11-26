local plugin = {
    'L3MON4D3/LuaSnip',
    module = 'luasnip',
    requires = {
      'rafamadriz/friendly-snippets',
    },
}

function plugin.config()
  require 'luasnip.loaders.from_vscode'.lazy_load()
end

return plugin
