vim.pack.add({
   { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
   { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
})

local languages = {
   'bash',
   'cpp',
   'css',
   'diff',
   'go',
   'html',
   'javascript',
   'jsdoc',
   'json',
   'json5',
   'lua',
   'luadoc',
   'markdown',
   'markdown_inline',
   'query',
   'rust',
   'tsx',
   'typescript',
   'vim',
   'vimdoc',
   'yaml',
   'zig',
}

local installed = require('nvim-treesitter.config').get_installed()
local treesitter = require('nvim-treesitter')

treesitter.setup()

treesitter
   .install(vim.iter(languages)
      :filter(function(language)
         return not vim.tbl_contains(installed, language)
      end)
      :totable())
   :wait(300000)

vim.api.nvim_create_autocmd('FileType', {
   pattern = { '<filetype>' },
   callback = function(args)
      local buf = args.buf
      local ft = vim.bo[buf].filetype

      local lang = vim.treesitter.language.get_lang(ft)
      if not lang then
         return
      end

      pcall(vim.treesitter.start, buf, lang)

      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.bo[buf].smartindent = false
      vim.bo[buf].cindent = false
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
   end,
})

require('nvim-treesitter-textobjects').setup({
   move = {
      set_jumps = true,
   },
})

local ts_to_move = require('nvim-treesitter-textobjects.move')
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
   ts_to_move.goto_next_start('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
   ts_to_move.goto_next_start('@class.outer', 'textobjects')
end)
-- You can also pass a list to group multiple queries.
vim.keymap.set({ 'n', 'x', 'o' }, ']o', function()
   ts_to_move.goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
   ts_to_move.goto_next_end('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
   ts_to_move.goto_next_end('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
   ts_to_move.goto_previous_start('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
   ts_to_move.goto_previous_start('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
   ts_to_move.goto_previous_end('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
   ts_to_move.goto_previous_end('@class.outer', 'textobjects')
end)

local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
-- REPEAT MOVEMENT WITH ; AND ,
-- ENSURE ; GOES FORWARD AND , GOES BACKWARD REGARDLESS OF THE LAST DIRECTION
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

-- SWAP FUNCION PARAMETERS
vim.keymap.set('n', '<leader>a', function()
   require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
end)
vim.keymap.set('n', '<leader>A', function()
   require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.outer')
end)
