-- Mason is used for installing LSP at ease
vim.pack.add({
   { src = 'https://github.com/mason-org/mason.nvim' },
   { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
   { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
})

require('mason').setup()

require('mason-lspconfig').setup({
   ensure_installed = {
      'lua_ls',
      'pyrefly',
   },
})

require('mason-tool-installer').setup({
   ensure_installed = {
      'ruff',
   },
})
