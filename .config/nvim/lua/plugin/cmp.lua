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

  -- General configurations
  cmp.setup {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
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
      -- Intellij-like mapping:
      -- If a completion is selected, insert this one.
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if entry then
            cmp.confirm()
          end
        else
          fallback()
        end
      end, { 'i', 's', 'c' }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol_text',
        maxwidth = 50, 
        before = function(entry, vim_item)
          vim_item.menu = '[' .. string.upper(entry.source.name) .. ']'
          return vim_item
        end,
      },
    },
  }

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
    enable_check_bracket_line = false
  }
end

return plugin
