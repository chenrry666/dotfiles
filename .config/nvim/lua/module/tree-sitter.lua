local module = {}
table.insert(module,
    { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })

local plugin = {
  'nvim-treesitter/nvim-treesitter',
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
    require 'nvim-treesitter.install'.update { with_sync = true }
  end,
}

function plugin.config()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = { 'lua' },
    indent = {
      enable = true,
    },
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
  ---WORKAROUND: https://github.com/nvim-treesitter/nvim-treesitter/issues/1469
  -- vim.opt.foldmethod     = 'expr'
  -- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
  })
  ---ENDWORKAROUND
end

table.insert(module, plugin)


return module
