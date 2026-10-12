vim.pack.add({
   { src = 'https://github.com/bluz71/vim-moonfly-colors', name = 'moonfly' },
})

vim.api.nvim_create_autocmd('ColorScheme', {
   pattern = 'moonfly',
   group = vim.api.nvim_create_augroup('CustomHighlight', {}),
   callback = function()
      vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#696969' })
      vim.api.nvim_set_hl(0, 'Substitute', { bold = true, fg = '#c8d3f5', bg = '#ff007c' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'Yellow', bg = '#1c1c1c' })
      vim.api.nvim_set_hl(0, 'DimCursorLine', { bg = '#1c1c1c' })
      vim.api.nvim_set_hl(0, 'DimCursorLineNr', { fg = 'Yellow', bg = '#1c1c1c' })
      vim.api.nvim_set_hl(0, 'FoldLine', { fg = '#45475A' })
   end,
})

vim.g.moonflyVirtualTextColor = true

vim.cmd.colorscheme('moonfly')
