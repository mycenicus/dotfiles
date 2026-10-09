vim.pack.add({
   'https://github.com/stevearc/oil.nvim',
})

require("oil").setup({
   default_file_explorer = false, -- Keep netrw
})

vim.keymap.set('n', '<leader>e', ':Oil<cr>',
   { silent = true, desc = "Open oil" })
