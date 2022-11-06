local plugin = {
  'hrsh7th/nvim-cmp',
  requires = {
    -- Completion sources
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-calc',

    -- Snippet engine
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    'windwp/nvim-autopairs',

    -- For LSPs
    'hrsh7th/cmp-nvim-lsp',
    'neovim/nvim-lspconfig',
    'onsails/lspkind.nvim',
  },
}

function plugin:config()
  -- Set up nvim-cmp.
  local cmp = require 'cmp'
  local lspkind = require 'lspkind'
  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
  end

  local luasnip = require 'luasnip'
  -- General configurations
  cmp.setup {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      completion = {
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
        col_offset = -3,
        side_padding = 0,
      },
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      -- Accept currently selected item. And only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm { select = true },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        local kind = require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 50 }(entry, vim_item)
        local strings = vim.split(kind.kind, '%s', { trimempty = true })
        kind.kind = ' ' .. strings[1] .. ' '
        kind.menu = '    (' .. strings[2] .. ')'

        return kind
      end,
    },
    view = {
      entries = { name = 'custom', selection_order = 'near_cursor' },
    },
  }

  -- Completion menu highlighting
  local highlight_group = {
    PmenuSel = { bg = '#282C34', fg = 'NONE' },
    Pmenu = { fg = '#C5CDD9', bg = '#22252A' },

    CmpItemAbbrDeprecated = { fg = '#7E8294', bg = 'NONE', strikethrough = true },
    CmpItemAbbrMatch = { fg = '#82AAFF', bg = 'NONE', bold = true },
    CmpItemAbbrMatchFuzzy = { fg = '#82AAFF', bg = 'NONE', bold = true },
    CmpItemMenu = { fg = '#C792EA', bg = 'NONE', italic = true },

    CmpItemKindField = { fg = '#EED8DA', bg = '#B5585F' },
    CmpItemKindProperty = { fg = '#EED8DA', bg = '#B5585F' },
    CmpItemKindEvent = { fg = '#EED8DA', bg = '#B5585F' },

    CmpItemKindText = { fg = '#C3E88D', bg = '#9FBD73' },
    CmpItemKindEnum = { fg = '#C3E88D', bg = '#9FBD73' },
    CmpItemKindKeyword = { fg = '#C3E88D', bg = '#9FBD73' },

    CmpItemKindConstant = { fg = '#FFE082', bg = '#D4BB6C' },
    CmpItemKindConstructor = { fg = '#FFE082', bg = '#D4BB6C' },
    CmpItemKindReference = { fg = '#FFE082', bg = '#D4BB6C' },

    CmpItemKindFunction = { fg = '#EADFF0', bg = '#A377BF' },
    CmpItemKindStruct = { fg = '#EADFF0', bg = '#A377BF' },
    CmpItemKindClass = { fg = '#EADFF0', bg = '#A377BF' },
    CmpItemKindModule = { fg = '#EADFF0', bg = '#A377BF' },
    CmpItemKindOperator = { fg = '#EADFF0', bg = '#A377BF' },

    CmpItemKindVariable = { fg = '#C5CDD9', bg = '#7E8294' },
    CmpItemKindFile = { fg = '#C5CDD9', bg = '#7E8294' },

    CmpItemKindUnit = { fg = '#F5EBD9', bg = '#D4A959' },
    CmpItemKindSnippet = { fg = '#F5EBD9', bg = '#D4A959' },
    CmpItemKindFolder = { fg = '#F5EBD9', bg = '#D4A959' },

    CmpItemKindMethod = { fg = '#DDE5F5', bg = '#6C8ED4' },
    CmpItemKindValue = { fg = '#DDE5F5', bg = '#6C8ED4' },
    CmpItemKindEnumMember = { fg = '#DDE5F5', bg = '#6C8ED4' },

    CmpItemKindInterface = { fg = '#D8EEEB', bg = '#58B5A8' },
    CmpItemKindColor = { fg = '#D8EEEB', bg = '#58B5A8' },
    CmpItemKindTypeParameter = { fg = '#D8EEEB', bg = '#58B5A8' },
  }
  function add_hl(hls)
    for k, v in pairs(hls) do
      if type(v) == 'table' then
        vim.api.nvim_set_hl(0, k, v)
      else
        vim.highlight.link(k, v, true)
      end
    end
  end
  add_hl(highlight_group)
  cmp.setup.filetype('text', {
    sources = {
      { name = 'calc' },
    },
  })
  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- TODO: You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    }),
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })

  -- TODO
  -- Set up lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities,
  -- }

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  require('nvim-autopairs').setup {
    enable_check_bracket_line = false,
  }
end

return plugin
