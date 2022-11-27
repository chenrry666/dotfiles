local plugins = {
  ['wbthomason/packer.nvim'] = {
    cmd = {
      'PackerSnapshot',
      'PackerSnapshotRollback',
      'PackerSnapshotDelete',
      'PackerInstall',
      'PackerUpdate',
      'PackerSync',
      'PackerClean',
      'PackerCompile',
      'PackerStatus',
      'PackerProfile',
      'PackerLoad',
    },
    config = function() require 'plugins' end,
  },

  ['lewis6991/impatient.nvim'] = {},
}

local status_ok, packer = pcall(require, 'packer')
if status_ok then
  packer.startup {
    function(use)
      for key, plugin in pairs(plugins) do
        if type(key) == 'string' and not plugin[1] then plugin[1] = key end
        use(plugin)
      end
      use(require 'module.tree-sitter')
      use(require 'module.statusline')
      use(require 'module.theme')
      use(require 'module.dashboard')
      use(require 'module.tree')
      use(require 'module.cmp')
      use(require 'module.lsp')
    end,
    config = {
      compile_path = vim.fn.stdpath 'data' .. '/packer_compiled.lua',
      display = {
        open_fn = function() return require 'packer.util'.float { border = 'rounded' } end,
      },
      profile = {
        enable = true,
        threshold = 0.0001,
      },
      git = {
        clone_timeout = 300,
        subcommands = {
          update = 'pull --rebase',
        },
      },
      auto_clean = true,
      compile_on_sync = true,
    },
  }
end
