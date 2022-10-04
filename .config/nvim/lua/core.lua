local default_setting = {}

default_setting['opt'] = {
    number = true,
    relativenumber = true,
    ignorecase = true,
    undofile = false, -- use undo file
    swapfile = false, -- use swap file
    maxmempattern = 2000, -- max match pattern
    autochdir = true, -- auto change directory to current file
    lazyredraw = true, -- true will speed up in macro repeat
    ttyfast = true, -- true maybe as lazyredraw ? TODO
    wrap = false,
    mouse = 'a',
    hidden = true, -- permit of change buffer when the buffer is not been written
    fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,latin1",
    encoding = "utf-8",
    path = vim.o.path .. ",./**",
--    omnifunc = 'v:lua.vim.lsp.omnifunc', -- for default lsp
    tabstop = 4, -- replace tab as white space
    expandtab = true,
    shiftwidth = 4,
--    conceallevel = 2,
--    concealcursor = '', -- if set to nc, char will always fold except in insert mode
    softtabstop = 4,
    foldenable = true, -- enable fold
    foldmethod = 'marker',
    foldlevel = 99, -- disable fold for opened file
    foldminlines = 2, -- 0 means even the child is only one line, fold always works
--    foldmethod = 'expr', -- for most filetype, fold by syntax
--    foldnestmax = 5, -- max fold nest
--    foldexpr = "nvim_treesitter#foldexpr()",
    --completeopt = "menu,menuone,noselect",
    completeopt = "menuone,noselect",
    --t_ut = " ",                               -- disable Backgroud color Erase（BCE）
    termguicolors = true, -- TODO
--    colorcolumn = "99999" -- FIXED: for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
}

for key, value in pairs(default_setting['opt']) do
    vim.o[key] = value
end

