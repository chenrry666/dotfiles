local packer = require 'packer'
-- global variable
packer.reset()
packer.use 'wbthomason/packer.nvim'

local function plugin(path)
  packer.use(require(path))
end

plugin 'plugin.theme'
plugin 'plugin.statusline'
plugin 'plugin.tree-sitter'
plugin 'plugin.cmp'
