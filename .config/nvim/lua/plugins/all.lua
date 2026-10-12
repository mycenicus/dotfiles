require('plugins.vim-tmux-navigator')
require('plugins.mini')
require('plugins.oil')
require('plugins.nvim-tree')
require('plugins.quicker')
require('plugins.snacks')
require('plugins.blink')
require('plugins.lsp')
require('plugins.mason')
require('plugins.lualine')
require('plugins.git')
require('plugins.smartcolumn')
require('plugins.tabout')
require('plugins.flash')
require('plugins.conform')
require('plugins.lint')
require('plugins.treesitter')
require('plugins.spider')
require('plugins.toggleterm')
require('plugins.colorscheme')
-- TODO: blink.pairs, blink.indent, fff.nvim
-- TODO: edgy, trouble
-- TODO: neopyter, pyrepl.nvim
-- TODO: compile-mode.nvim

vim.pack.add({
   { src = 'https://github.com/tpope/vim-sleuth' },
   { src = 'https://github.com/rafamadriz/friendly-snippets' },
})
