vim.pack.add({
   { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
   disable_netrw = true,
   sync_root_with_cwd = true,
   view = {
      width = 35,
   },
})

vim.keymap.set('n', '<leader>tv', ':NvimTreeToggle<cr>', {
   silent = true,
   desc = 'Open tree view',
})
