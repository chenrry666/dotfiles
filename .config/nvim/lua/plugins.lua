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

  ['rcarriga/nvim-notify'] = {
    event = 'UIEnter',
    config = function()
      vim.notify = require 'notify'
    end,
  },

  ['stevearc/dressing.nvim'] = {
    event = 'UIEnter',
    config = function()
      require 'dressing'.setup {}
    end,
  },

  ['nvim-treesitter/nvim-treesitter'] = {
    module = 'nvim-treesitter',
    cmd = {
      'TSBufDisable',
      'TSBufEnable',
      'TSBufToggle',
      'TSDisable',
      'TSEnable',
      'TSToggle',
      'TSInstall',
      'TSInstallInfo',
      'TSInstallSync',
      'TSModuleInfo',
      'TSUninstall',
      'TSUpdate',
      'TSUpdateSync',
    },
    run = function()
      require 'nvim-treesitter.install'.update { with_sync = true } ()
    end,
    config = function()
      require 'module.tree-sitter'
    end,
  },

  ['p00f/nvim-ts-rainbow'] = { after = 'nvim-treesitter' },

  ['glepnir/galaxyline.nvim'] = {
    branch = 'main',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'module.statusline'
    end,
  },

  ['rmehri01/onenord.nvim'] = {
    config = function()
      require 'onenord'.setup {
        disable = {
          background = true,
        },
        custom_highlights = {
          NotifyBackground = {
            bg = "#333333",
          },
        },
      }
    end,
  },

  ['akinsho/toggleterm.nvim'] = {
    tag = '*',
    config = function()
      require 'toggleterm'.setup {
        open_mapping = [[<C-\>]]
      }
    end,
  },


  ["kylechui/nvim-surround"] = {
    event = "InsertEnter",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    event = "UIEnter",
    config = function()

      require("indent_blankline").setup {
        -- space_char_blankline = " ",
        -- show_current_context = true,
      }
    end
  }
}

local status_ok, packer = pcall(require, 'packer')
if status_ok then
  packer.startup {
    function(use)
      for key, plugin in pairs(plugins) do
        if type(key) == 'string' and not plugin[1] then plugin[1] = key end
        use(plugin)
      end
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
