-- TODO: update commands:
--  $> nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

require 'core'

local plugins = require 'plugins'
plugins.init()
plugins.add_plugin 'tree-sitter'
plugins.add_plugin 'statusline'
plugins.add_plugin 'theme'
plugins.add_plugin 'tree'
plugins.add_plugin 'cmp'
plugins.add_plugin 'lsp'
