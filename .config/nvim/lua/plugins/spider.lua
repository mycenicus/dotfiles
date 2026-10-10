vim.pack.add({
   { src = 'https://github.com/chrisgrieser/nvim-spider' },
})

-- word is camelCase separated
-- word secondWord etc.if a-very-long-word
require('spider').setup()

vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")
vim.keymap.set({ 'n', 'o', 'x' }, 'ge', "<cmd>lua require('spider').motion('ge')<CR>")
