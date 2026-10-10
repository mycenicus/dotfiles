vim.pack.add({
   { src = 'https://github.com/neovim/nvim-lspconfig' },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
vim.lsp.config('*', { capabilities = capabilities })

vim.lsp.enable({
   'lua_ls',
   'pyrefly',
})
