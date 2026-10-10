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
-- TODO: blink.pairs, blink.indent, fff.nvim
-- TODO: edgy, trouble
-- TODO: snippets

vim.pack.add({
   { src = 'https://github.com/tpope/vim-sleuth' },
})

vim.pack.add({
   { src = 'https://github.com/bluz71/vim-moonfly-colors', name = 'moonfly' },
})

local custom_highlight = vim.api.nvim_create_augroup('CustomHighlight', {})
vim.api.nvim_create_autocmd('ColorScheme', {
   pattern = 'moonfly',
   group = custom_highlight,
   callback = function()
      vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#696969' })
   end,
})

vim.cmd.colorscheme('moonfly')
