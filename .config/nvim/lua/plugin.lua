local packer = require 'packer'
-- global variable
packer.reset()
packer.use 'wbthomason/packer.nvim'

packer.use(require 'plugin/theme')
packer.use(require 'plugin/statusline')
packer.use(require 'plugin/tree-sitter')
