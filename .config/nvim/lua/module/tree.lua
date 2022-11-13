local plugin = {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- for file icons
  },
  tag = 'nightly', -- updated every week. (issue #1193)
}

function plugin.config()
  require 'nvim-tree'.setup {
    hijack_cursor = true,
    hijack_netrw = true,
  }
end

return plugin
