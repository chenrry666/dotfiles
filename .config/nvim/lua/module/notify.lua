local notify = require 'notify'
-- TODO: set the notify float window wrap lines
notify.setup {
  max_width = 40,
  minimum_width = 40,
  -- the folling code actually doesn't work
  -- on_open = function()
  --   vim.opt_local.wrap = true
  -- end,
}
vim.notify = notify
