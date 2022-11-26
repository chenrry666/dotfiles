-- TODO: update commands:
--  $> nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
-- use impatient and enable profiling if it is installed
local ok, impatient = pcall(require, 'impatient')
if ok then impatient.enable_profile() end
require 'core'

require 'bootstrap'
require 'plugins'
