vim.pack.add({
   { src = 'https://github.com/mfussenegger/nvim-lint' },
})

local lint = require('lint')
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

lint.linters_by_ft = {
   -- javascript,typescript,react,svelte = {'biomejs'}
   python = { 'ruff' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
   group = lint_augroup,
   callback = function()
      lint.try_lint()
   end,
})
