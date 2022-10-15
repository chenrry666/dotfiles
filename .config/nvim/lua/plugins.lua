local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

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
      return require('packer.util').float { border = 'single' }
    end,
    prompt_border = 'single',
    keybindings = {
      quit = 'q',
      toggle_update = 'u',
      continue = 'c',
      toggle_info = '<CR>',
      diff = 'd',
      prompt_revert = 'r',
    },
  },
  log = { level = 'warn' },
  profile = {
    enable = false,
    threshold = 1,
  },
}

local use = packer.use

use 'wbthomason/packer.nvim'

use {
  'glepnir/galaxyline.nvim',
  branch = 'main',
  config = function()
    require 'statusline'
  end,
  requires = 'kyazdani42/nvim-web-devicons',
}

use {
  'glepnir/zephyr-nvim',
  requires = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require 'zephyr'
  end,
}

use {
  'nvim-treesitter/nvim-treesitter',
  run = function()
    require('nvim-treesitter.install').update { with_sync = true }
  end,
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'lua' },
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      auto_install = false,
      ignore_install = { 'javascript', 'c', 'rust' },
      -- parser_install_dir = "/some/path/to/store/parsers",
      -- If you want to change install path,
      -- remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
      highlight = {
        enable = true,
        -- disable slow treesitter highlight for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}

if packer_bootstrap then
  require('packer').sync()
end
