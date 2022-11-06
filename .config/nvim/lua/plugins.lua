local packer = require 'packer'
packer.reset()
-- manage packer itself
packer.use 'wbthomason/packer.nvim'

local function plugin(path)
  packer.use(require(path))
end

plugin 'plugin.theme'
plugin 'plugin.statusline'
plugin 'plugin.tree-sitter'
plugin 'plugin.cmp'
plugin 'plugin.pairs'
plugin 'plugin.tree'
