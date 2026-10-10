vim.pack.add({
   { src = 'https://github.com/christoomey/vim-tmux-navigator' },
})
-- Preserve default <C-l> for :noh and other stuff
vim.g.tmux_navigator_no_mappings = 1
local original_ctrl_l = vim.fn.maparg('<C-l>', 'n', false)
vim.keymap.set('n', '<C-l>', original_ctrl_l .. ':TmuxNavigateRight<cr>', {
   silent = true,
   desc = 'Execute original <C-l> and append TmuxNavigateRight',
})
vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<cr>', { silent = true })
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<cr>', { silent = true })
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<cr>', { silent = true })
