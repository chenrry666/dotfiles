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

  -- General configurations
  local cmp_conf = {}

  local function setup_highlight()
    -- Completion menu highlighting
    local hls = {
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

    for k, v in pairs(hls) do
      if type(v) == 'table' then
        vim.api.nvim_set_hl(0, k, v)
      else
        vim.api.nvim_set_hl(0, k, hls[v])
      end
    end
  end

  -- Define highlight groups for the window.completion.winhighlight below
  setup_highlight()
  cmp_conf.window = {
    completion = {
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
      col_offset = -3,
      side_padding = 0,
    },
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  }

  local luasnip = require 'luasnip'
  cmp_conf.snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  }

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
  end
  cmp_conf.mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
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
  }

  cmp_conf.sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })

  local lspkind = require 'lspkind'
  cmp_conf.formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 50 }(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      kind.kind = ' ' .. strings[1] .. ' '
      kind.menu = '    (' .. strings[2] .. ')'

      return kind
    end,
  }

  cmp_conf.view = {
    entries = { name = 'custom', selection_order = 'near_cursor' },
  }

  cmp.setup(cmp_conf)

  -- Set configuration for specific filetype.
  cmp.setup.filetype('text', {
    sources = {
      { name = 'calc' },
    },
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- TODO: You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    }),
  })

  -- Use buffer source for `/` and `?`
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':'
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

  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return plugin
