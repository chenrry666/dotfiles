-- TODO: update commands:
--  $> nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
-- use impatient and enable profiling if it is installed
local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
end
require 'core'

local plugins = require 'plugins'
plugins.init()
plugins.add_plugin 'profile'
plugins.add_plugin 'tree-sitter'
plugins.add_plugin 'statusline'
plugins.add_plugin 'theme'
plugins.add_plugin 'dashboard'
plugins.add_plugin 'tree'
plugins.add_plugin 'cmp'
plugins.add_plugin 'lsp'
