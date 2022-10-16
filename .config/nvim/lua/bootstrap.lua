local module = {}

module.bootstrap = function()
  local first_run = false
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
    first_run = true
  end
    
  local packer_ok, packer = pcall(require, 'packer')
  if not packer_ok then
    print 'can not load packer.'
    return
  end

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

  require 'plugin'
  
  if first_run then
    packer.sync()
  end
end

return module
