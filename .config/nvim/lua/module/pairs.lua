local plugin = {
  'windwp/nvim-autopairs',
}

function plugin.config()
  require('nvim-autopairs').setup {
    enable_check_bracket_line = false,
  }

  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return plugin
