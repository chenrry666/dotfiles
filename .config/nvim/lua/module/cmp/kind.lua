local M = {}
function M.update(cmp_conf)
  cmp_conf.window = {
    completion = {
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
      col_offset = -3,
      side_padding = 0,
    },
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  }

  local lspkind = require 'lspkind'
  cmp_conf.formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format { mode = 'symbol_text', maxwidth = 50 } (entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      kind.kind = ' ' .. strings[1] .. ' '
      kind.menu = '    (' .. strings[2] .. ')'

      return kind
    end,
  }
end

return M
