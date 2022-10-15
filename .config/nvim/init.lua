-- TODO: update commands:
--  $> nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

require 'core'
if require 'bootstrap'.ensure_packer() then
  local packer = require 'packer'	
  packer.sync()
end
require 'plugin'

