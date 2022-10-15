local packer = require 'packer'
packer.init {
  ensure_dependencies = true,
  git = {
    depth = 1,
    clone_timeout = 60,
    default_url_format = 'https://github.com/%s',
  },
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- global variable
use = packer.use

use 'wbthomason/packer.nvim'

require 'plugin/theme'
require 'plugin/statusline'
require 'plugin/tree-sitter'
