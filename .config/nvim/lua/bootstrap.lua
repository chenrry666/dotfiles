-- try loading packer
local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
local packer_avail = vim.fn.empty(vim.fn.glob(packer_path)) == 0
-- if packer isn't availble, reinstall it
if not packer_avail then
  -- set the location to install packer
  -- delete the old packer install if one exists
  vim.fn.delete(packer_path, 'rf')
  -- clone packer
  vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    packer_path,
  }
  -- add packer and try loading it
  vim.cmd.packadd 'packer.nvim'
  local packer_loaded, _ = pcall(require, 'packer')
  packer_avail = packer_loaded
  -- if packer didn't load, print error
  if not packer_avail then vim.api.nvim_err_writeln('Failed to load packer at:' .. packer_path) end
end
-- if packer is available, check if there is a compiled packer file
if packer_avail then
  -- try to load the packer compiled file
  local run_me, _ = loadfile(
      vim.fn.stdpath 'data' .. '/packer_compiled.lua'
  )
  if run_me then
    -- if the file loads, run the compiled function
    run_me()
  else
    -- if there is no compiled file, ask user to sync packer
    require 'plugins'
    vim.api.nvim_create_autocmd('User', {
      once = true,
      pattern = 'PackerComplete',
      callback = function()
        vim.cmd.bw()
        vim.tbl_map(require, { 'nvim-treesitter' })
      end,
    })
    vim.opt.cmdheight = 1
    vim.notify 'Please wait while plugins are installed...'
    vim.cmd.PackerSync()
  end
end
