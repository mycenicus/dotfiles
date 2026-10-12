vim.pack.add({
   { src = 'https://github.com/folke/flash.nvim' },
})

require('flash').setup({
   modes = { search = { enabled = true } },
   char = { jump_labels = true },
   label = { after = { 0, 2 } },
   style = 'overlay',
   rainbow = { enabled = true, shade = 6 },
})

-- stylua: ignore start
vim.keymap.set({ 'n', 'x', 'o' }, 'f', function() require('flash').jump() end, { desc = 'Flash jump' })
vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'Remote flash' })
vim.keymap.set({ 'x', 'o' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Far-away treesitter' })
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
