local plugin = {
  'glepnir/zephyr-nvim',
  requires = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require 'zephyr'
  end,
}

return plugin
