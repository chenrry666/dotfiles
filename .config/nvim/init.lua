-- TODO: update commands:
--  $> nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

require 'core'
local bootstrap require 'bootstrap'.ensure_packer()

require 'plugin'

if bootstrap then
  local packer = require 'packer'
  packer.sync()
end
