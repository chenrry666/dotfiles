local M = {}
function M.bootstrap()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
  end
  -- TODO:
  -- check if it clones successfully
end

function M.init()
  -- TODO
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
        return require 'packer.util'.float { border = 'rounded' }
      end,
    },
  }

  packer.reset()
  -- manage packer itself
  packer.use 'wbthomason/packer.nvim'
end

function M.add_plugin(name)
  -- must be under folder plugin
  require 'packer'.use(require('module.' .. name))
end

return M
