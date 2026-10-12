vim.pack.add({
   { src = 'https://github.com/folke/snacks.nvim' },
   { src = 'https://github.com/nvim-lua/plenary.nvim' },
   { src = 'https://github.com/folke/todo-comments.nvim' },
})

local snacks = require('snacks')

snacks.setup({
   picker = { enabled = true },
   lazygit = { enabled = true },
   bigfile = { enabled = true },
   rename = { enabled = true },
   scratch = { enabled = true },
   -- TODO check out these plugins
   -- explorer = { enabled = true },
   -- scope = { enabled = true },
   -- indent = { enabled = true },
})
vim.keymap.set('n', '<leader>pf', function()
   snacks.picker.files()
end, { desc = 'Picker: files' })

vim.keymap.set('n', '<leader>pc', function()
   snacks.picker.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Picker: config files' })

vim.keymap.set('n', '<leader>ps', function()
   snacks.picker.grep()
end, { desc = 'Picker: grep word' })

vim.keymap.set({ 'n', 'x' }, '<leader>pw', function()
   snacks.picker.grep_word()
end, { desc = 'Picker: grep word under the cursor' })

vim.keymap.set({ 'n', 'x' }, '<leader>pW', function()
   snacks.picker.grep_buffers()
end, { desc = 'Picker: grep word under the cursor in buffers' })

vim.keymap.set('n', '<leader>ph', function()
   snacks.picker.help()
end, { desc = 'Picker: help' })

vim.keymap.set('n', '<leader>pk', function()
   snacks.picker.keymaps({ layout = 'ivy' })
end, { desc = 'Picker: keymaps' })

vim.keymap.set('n', '<leader>pg', function()
   snacks.picker.git_branches({ layout = 'select' })
end, { desc = 'Picker: git branch' })

vim.keymap.set('n', '<leader>pb', function()
   snacks.picker.buffers()
end, { desc = 'Picker: buffers' })

vim.keymap.set('n', '<leader>lg', function()
   snacks.lazygit()
end, { desc = 'Lazygit' })

vim.api.nvim_create_autocmd('User', {
   pattern = 'OilActionsPost',
   callback = function(event)
      if event.data.actions[1].type == 'move' then
         snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
      end
   end,
})

vim.keymap.set('n', '<leader>.', function()
   snacks.scratch()
end, { desc = 'New scratch buffer' })

vim.keymap.set('n', '<leader>s', function()
   snacks.scratch.select()
end, { desc = 'Picker: scratch' })

require('todo-comments').setup()

vim.keymap.set('n', '<leader>pt', function()
   snacks.picker.todo_comments()
end, { desc = 'Picker: todo comments' })

vim.keymap.set('n', '<leader>fr', function()
   snacks.picker.recent()
end, { desc = 'Picker: recent files' })

vim.keymap.set('n', '<leader>gd', function()
   snacks.picker.lsp_definitions()
end, { desc = 'Picker: definitions' })

vim.keymap.set('n', '<leader>gD', function()
   snacks.picker.lsp_declarations()
end, { desc = 'Picker: declarations' })

vim.keymap.set('n', '<leader>gr', function()
   snacks.picker.lsp_references()
end, { desc = 'Picker: references' })

vim.keymap.set('n', '<leader>gs', function()
   snacks.picker.lsp_symbols()
end, { desc = 'Picker: symbols' })

vim.keymap.set('n', '<leader>gS', function()
   snacks.picker.lsp_workspace_symbols()
end, { desc = 'Picker: workspace symbols' })
