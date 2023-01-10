-- vim: fdm=marker
-- {{{
local function setup_mapping(map_table, base)
  -- iterate over the first keys for each mode
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base or {}
        if type(options) == 'table' then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend('force', options
                                            , keymap_opts)
          keymap_opts[1] = nil
        end
        -- extend the keybinding options with the base provided and set the mapping
        vim.keymap.set(mode, keymap, cmd, keymap_opts)
      end
    end
  end
end
-- }}}


local function is_available(plugin)
  return packer_plugins ~= nil and
      packer_plugins[plugin] ~= nil
end

local map = { i = {}, n = {}, v = {}, t = {}, [''] = {} }
-- {{{
-- Smart Splits
if is_available 'smart-splits.nvim' then
  -- Better window navigation
  map.n['<C-h>'] = {
    function()
      require 'smart-splits'.move_cursor_left()
    end,
    desc = 'Move to left split',
  }
  map.n['<C-j>'] = {
    function()
      require 'smart-splits'.move_cursor_down()
    end,
    desc = 'Move to below split',
  }
  map.n['<C-k>'] = {
    function()
      require 'smart-splits'.move_cursor_up()
    end,
    desc = 'Move to above split',
  }
  map.n['<C-l>'] = {
    function()
      require 'smart-splits'.move_cursor_right()
    end,
    desc = 'Move to right split',
  }

  -- Resize with arrows
  map.n['<C-Up>'] = {
    function()
      require 'smart-splits'.resize_up()
    end,
    desc = 'Resize split up',
  }
  map.n['<C-Down>'] = {
    function()
      require 'smart-splits'.resize_down()
    end,
    desc = 'Resize split down',
  }
  map.n['<C-Left>'] = {
    function()
      require 'smart-splits'.resize_left()
    end,
    desc = 'Resize split left',
  }
  map.n['<C-Right>'] = {
    function()
      require 'smart-splits'.resize_right()
    end,
    desc = 'Resize split right',
  }
else
  map.n['<C-h>'] = { '<C-w>h', desc = 'Move to left split' }
  map.n['<C-j>'] = { '<C-w>j', desc = 'Move to below split' }
  map.n['<C-k>'] = { '<C-w>k', desc = 'Move to above split' }
  map.n['<C-l>'] = { '<C-w>l', desc = 'Move to right split' }
  map.n['<C-Up>'] = {
    '<cmd>resize -2<CR>',
    desc = 'Resize split up',
  }
  map.n['<C-Down>'] = {
    '<cmd>resize +2<CR>',
    desc = 'Resize split down',
  }
  map.n['<C-Left>'] = {
    '<cmd>vertical resize -2<CR>',
    desc = 'Resize split left',
  }
  map.n['<C-Right>'] = {
    '<cmd>vertical resize +2<CR>',
    desc = 'Resize split right',
  }
end

-- Terminal
if is_available 'toggleterm.nvim' then
  -- local toggle_term_cmd = astronvim.toggle_term_cmd
  -- if vim.fn.executable "lazygit" == 1 then
  --   maps.n["<leader>gg"] = { function() toggle_term_cmd "lazygit" end, desc = "ToggleTerm lazygit" }
  --   maps.n["<leader>tl"] = { function() toggle_term_cmd "lazygit" end, desc = "ToggleTerm lazygit" }
  -- end
  -- if vim.fn.executable "node" == 1 then
  --   maps.n["<leader>tn"] = { function() toggle_term_cmd "node" end, desc = "ToggleTerm node" }
  -- end
  -- if vim.fn.executable "gdu" == 1 then
  --   maps.n["<leader>tu"] = { function() toggle_term_cmd "gdu" end, desc = "ToggleTerm gdu" }
  -- end
  -- if vim.fn.executable "btm" == 1 then
  --   maps.n["<leader>tt"] = { function() toggle_term_cmd "btm" end, desc = "ToggleTerm btm" }
  -- end
  -- if vim.fn.executable "python" == 1 then
  --   maps.n["<leader>tp"] = { function() toggle_term_cmd "python" end, desc = "ToggleTerm python" }
  -- end
  map.n['<leader>tf'] = {
    '<cmd>ToggleTerm direction=float<cr>',
    desc = 'ToggleTerm float',
  }
  map.n['<leader>th'] = {
    '<cmd>ToggleTerm size=10 direction=horizontal<cr>',
    desc = 'ToggleTerm horizontal split',
  }
  map.n['<leader>tv'] = {
    '<cmd>ToggleTerm size=80 direction=vertical<cr>',
    desc = 'ToggleTerm vertical split',
  }
  map.n['<F7>'] = {
    '<cmd>ToggleTerm<cr>',
    desc = 'Toggle terminal',
  }
  map.t['<F7>'] = map.n['<F7>']
  map.n['<C-`>'] = map.n['<F7>']
  map.t['<C-`>'] = map.n['<F7>']
end

-- write files with sudo permission
-- this is useful when you forget to use `sudo nvim foo`
map.n["<leader>S"] = {"<cmd>w !sudo tee %<CR>", desc="write current file with sudo permission"}

-- }}}

-- {{{

-- lsp map
local lmap = { i = {}, n = {}, v = {}, t = {}, [''] = {} }

-- Code action
lmap.n['<leader>ca'] = {
  '<cmd>Lspsaga code_action<CR>',
  desc = 'run code action',
}
lmap.v['<leader>ca'] = lmap.n['<leader>ca']

-- Rename
lmap.n['<leader>rn'] = {
  '<cmd>Lspsaga rename<CR>',
  desc = 'rename symbols',
}

lmap.n['gh'] = { '<cmd>Lspsaga lsp_finder<CR>' }
lmap.n['gp'] = { '<cmd>Lspsaga peek_definition<CR>' }
lmap.n['gD'] = { vim.lsp.buf.declaration }
lmap.n['gd'] = { vim.lsp.buf.definition }
lmap.n['gi'] = { vim.lsp.buf.implementation }
lmap.n['K'] = { vim.lsp.buf.signature_help }
lmap.n['<space>D'] = { vim.lsp.buf.type_definition }

-- Diagnsotics
lmap.n['<space>e'] = { vim.diagnostic.open_float }
lmap.n['<space>q'] = { vim.diagnostic.setloclist }
lmap.n['<leader>ld'] = { '<cmd>Lspsaga show_line_diagnostics<CR>' }
lmap.n['<leader>cd'] = { '<cmd>Lspsaga show_cursor_diagnostics<CR>' }
-- Diagnsotic jump can use `<c-o>` to jump back
lmap.n['[e'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>' }
lmap.n[']e'] = { '<cmd>Lspsaga diagnostic_jump_next<CR>' }
-- Only jump to error
lmap.n['[E'] = {
  function()
    require 'lspsaga.diagnostic'.goto_prev {
      severity = vim.diagnostic.severity.ERROR,
    }
  end,
}
lmap.n[']E'] = {
  function()
    require 'lspsaga.diagnostic'.goto_next {
      severity = vim.diagnostic.severity.ERROR,
    }
  end,
}

-- Outline
lmap.n['<leader>o'] = { '<cmd>LSoutlineToggle<CR>' }

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
lmap.n['<space>wa'] = { vim.lsp.buf.add_workspace_folder }
lmap.n['<space>wr'] = { vim.lsp.buf.remove_workspace_folder }
lmap.n['<space>wl'] = {
  function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end,
}
lmap.n['<space>f'] = {
  function()
    vim.lsp.buf.format { async = true }
  end,
}
--
-- }}}

local M = {}
function M.setup()
  setup_mapping(map)
end

function M.attach_lsp(bufnr)
  local bufopts = { noremap = true, silent = true,
    buffer = bufnr, }
  setup_mapping(lmap, bufopts)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc',
                              'v:lua.vim.lsp.omnifunc')
end

return M
