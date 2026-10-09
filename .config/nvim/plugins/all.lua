require('plugins.mini')
require('plugins.oil')
require('plugins.mason')
require('plugins.blink')
require('plugins.lualine')
require('plugins.git')
require('plugins.smartcolumn')

vim.pack.add({
   { src = 'https://github.com/neovim/nvim-lspconfig' },
   { src = 'https://github.com/christoomey/vim-tmux-navigator' },
   { src = 'https://github.com/tpope/vim-sleuth' },
})

vim.pack.add({
   { src = 'https://github.com/bluz71/vim-moonfly-colors', name = 'moonfly' },
})
vim.cmd.colorscheme('moonfly')
