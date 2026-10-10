vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 3 -- BAD? usr_30.txt
vim.o.softtabstop = 3
vim.o.shiftwidth = 3
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.signcolumn = 'yes' -- for diagnostics signs
vim.o.laststatus = 2
vim.o.cmdheight = 1 -- if 0, pops up cmd only when you start typing :
vim.o.cursorline = true -- highlight current line
-- vim.o.showmode = false -- for lualine
vim.o.inccommand = 'split'

vim.o.list = true
vim.o.listchars = 'tab:>-,trail:-,nbsp:+'

vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.clipboard = 'unnamedplus'
vim.o.lazyredraw = true -- do not redraw on macro execution (shows every character pasted)
vim.o.synmaxcol = 300
vim.o.undofile = true
vim.o.autoread = true
vim.o.title = true
vim.o.updatetime = 300 -- For CursorHold hl, in particular used for LSP highlight
-- vim.o.fillchars = May be useful

vim.o.pumborder = 'bold'
vim.o.winborder = 'rounded'
vim.o.pumheight = 15
vim.o.pumblend = 10

vim.o.textwidth = 79
vim.cmd('set formatoptions-=t') -- Don't autowrap after textwidth
-- vim.cmd("set formatoptions+=n") Useful with markdown, autoindent bullet list
-- vim.o.conceallevel = 0 Latex? Play around with
-- vim.cmd("set iskeyword+="-") May be useful

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- use treesitter for folding
vim.o.foldlevel = 99 -- start with all folds open

vim.o.wildmode = 'longest:full,full'
-- vim.o.diffopt May be useful
