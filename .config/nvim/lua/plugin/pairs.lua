local plugin = {
  'windwp/nvim-autopairs',
}

function plugin:config()
  require('nvim-autopairs').setup {
    enable_check_bracket_line = false,
  }
end

return plugin
