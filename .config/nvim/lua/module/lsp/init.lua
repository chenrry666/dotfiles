local module = {}
table.insert(module, require 'module.lsp.saga')

-- TODO split keymaps.lua from cmp and lsp
-- TODO lazyloading
local plugin = {
  'neovim/nvim-lspconfig',
}

function plugin.config()
  -- Float terminal
  vim.keymap.set('n', '<A-d>', '<cmd>Lspsaga open_floaterm<CR>', { noremap = true, silent = true })
  -- close floaterm
  vim.keymap.set('t', '<A-d>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { noremap = true, silent = true })

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  ---@diagnostic disable-next-line: unused-local
  local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- Code action
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', bufopts)

    -- Rename
    vim.keymap.set('n', '<space>rn', '<cmd>Lspsaga rename<CR>', bufopts)

    -- Peek Definition
    --   you can edit the definition file in this flaotwindow
    --   also support open/vsplit/etc operation check definition_action_keys
    --   support tagstack C-t jump back
    -- Lsp finder find the symbol definition implement reference
    --   if there is no implement it will hide
    --   when you use action in finder like open vsplit then you can
    --   use <C-t> to jump back
    vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', bufopts)
    vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)

    -- Diagnsotics
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>', bufopts)
    vim.keymap.set('n', '<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<CR>', bufopts)
    -- Diagnsotic jump can use `<c-o>` to jump back
    vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', bufopts)
    vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', bufopts)
    -- Only jump to error
    vim.keymap.set('n', '[E', function()
      require 'lspsaga.diagnostic'.goto_prev { severity = vim.diagnostic.severity.ERROR }
    end, bufopts)
    vim.keymap.set('n', ']E', function()
      require 'lspsaga.diagnostic'.goto_next { severity = vim.diagnostic.severity.ERROR }
    end, bufopts)

    -- Outline
    vim.keymap.set('n', '<leader>o', '<cmd>LSoutlineToggle<CR>', bufopts)

    -- Hover Doc
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', bufopts)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, bufopts)
  end

  local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
  require 'module.lsp.lua'.setup { capabilities = capabilities, on_attach = on_attach }
end

table.insert(module, plugin)
return module
