local M = {}

local function hls(hl)
  for k, v in pairs(hl) do
    if type(v) == 'table' then
      vim.api.nvim_set_hl(0, k, v)
    else
      vim.api.nvim_set_hl(0, k, hl[v])
    end
  end
end

function M.update(cmp_conf)
  -- Define highlight groups for the window.completion.winhighlight below
  -- Completion menu highlighting
  hls {
    PmenuSel = { bg = '#282C34', fg = 'NONE' },
    Pmenu = { fg = '#C5CDD9', bg = '#22252A' },

    CmpItemAbbrDeprecated = { fg = '#7E8294', bg = 'NONE', strikethrough = true },
    CmpItemMenu = { fg = '#C792EA', bg = 'NONE', italic = true },
    CmpItemAbbrMatch = { fg = '#82AAFF', bg = 'NONE', bold = true },
    CmpItemAbbrMatchFuzzy = 'CmpItemAbbrMatch',

    CmpItemKindField = { fg = '#EED8DA', bg = '#B5585F' },
    CmpItemKindProperty = 'CmpItemKindField',
    CmpItemKindEvent = 'CmpItemKindField',

    CmpItemKindText = { fg = '#C3E88D', bg = '#9FBD73' },
    CmpItemKindEnum = 'CmpItemKindText',
    CmpItemKindKeyword = 'CmpItemKindText',

    CmpItemKindConstant = { fg = '#FFE082', bg = '#D4BB6C' },
    CmpItemKindConstructor = 'CmpItemKindConstant',
    CmpItemKindReference = 'CmpItemKindConstant',

    CmpItemKindFunction = { fg = '#EADFF0', bg = '#A377BF' },
    CmpItemKindStruct = 'CmpItemKindFunction',
    CmpItemKindClass = 'CmpItemKindFunction',
    CmpItemKindModule = 'CmpItemKindFunction',
    CmpItemKindOperator = 'CmpItemKindFunction',

    CmpItemKindVariable = { fg = '#C5CDD9', bg = '#7E8294' },
    CmpItemKindFile = 'CmpItemKindVariable',

    CmpItemKindUnit = { fg = '#F5EBD9', bg = '#D4A959' },
    CmpItemKindSnippet = 'CmpItemKindUnit',
    CmpItemKindFolder = 'CmpItemKindUnit',

    CmpItemKindMethod = { fg = '#DDE5F5', bg = '#6C8ED4' },
    CmpItemKindValue = 'CmpItemKindMethod',
    CmpItemKindEnumMember = 'CmpItemKindMethod',

    CmpItemKindInterface = { fg = '#D8EEEB', bg = '#58B5A8' },
    CmpItemKindColor = 'CmpItemKindInterface',
    CmpItemKindTypeParameter = 'CmpItemKindInterface',
  }

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
