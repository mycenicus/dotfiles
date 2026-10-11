vim.pack.add({
   { src = 'https://github.com/folke/flash.nvim' },
})

require('flash').setup({
   char = { jump_labels = true },
})

-- stylua: ignore start
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash jump' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash treesitter' })
vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'Remote flash' })
vim.keymap.set({ 'x', 'o' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Remote treesitter' })
vim.keymap.set('c', '<C-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })
-- stylua: ignore end
vim.keymap.set('n', '<leader>r', function()
   require('flash').jump({
      action = function(match, state)
         vim.api.nvim_win_call(match.win, function()
            vim.api.nvim_win_set_cursor(match.win, match.pos)
            vim.diagnostic.open_float()
         end)
         state:restore()
      end,
   })
end, { desc = 'Remote show diagnostics' })
