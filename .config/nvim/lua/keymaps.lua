vim.keymap.set('n', '<leader>gf', ':e <cfile><cr>',
   { silent = true, desc = "If file under cursor doesn't exist, create it." })

vim.keymap.set('n', '<leader>u', function()
   vim.cmd.packadd("nvim.undotree")
   require("undotree").open()
end, { silent = true, desc = "Toggle Builtin Undotree", })

vim.keymap.set('n', '<C-Up>', ':resize +2<cr>',
   { silent = true, desc = "Increase window height", })
vim.keymap.set('n', '<C-Down>', ':resize -2<cr>',
   { silent = true, desc = "Decrease window height", })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<cr>',
   { silent = true, desc = "Decrease window width", })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<cr>',
   { silent = true, desc = "Increase window width", })

vim.keymap.set('n', '<A-k>', ':m .-2<cr>==',
   { silent = true, desc = "Move line up" })
vim.keymap.set('n', '<A-j>', ':m .+1<cr>==',
   { silent = true, desc = "Move line down" })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv",
   { silent = true, desc = "Move line up" })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv",
   { silent = true, desc = "Move line up" })

vim.keymap.set('v', '>', ">gv",
   { silent = true, desc = "Continuously indent" })
vim.keymap.set('v', '<', "<gv",
   { silent = true, desc = "Continuously remove indent" })

vim.keymap.set('n', 'J', "m`J``",
   { silent = true, desc = "Join, keep cursor" })
vim.keymap.set('n', 'gp', "m`p``j",
   { silent = true, desc = "Paste, keep cursor's column" })

-- Diagnostics
vim.keymap.set('n', '<leader>dt', function()
   vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, desc = "Toggle diagnostics" })

vim.keymap.set('n', '<leader>dq', function()
   vim.diagnostic.setqflist()
   vim.cmd("copen")
end, { silent = true, desc = "Open diagnostics in quickfix list." })

vim.keymap.set('n', 'gl', vim.diagnostic.open_float,
   { desc = "Open diagnostic under cursor in a floating window" })


-- <C-a> to increment, <C-x> to decrement number
