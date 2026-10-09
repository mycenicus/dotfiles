-- Mason is used for installing LSP at ease, and for capabilites (what is it?)
vim.pack.add({
   { src = "https://github.com/mason-org/mason.nvim" }
})

require("mason").setup()

vim.keymap.set('n', 'grd', vim.lsp.buf.definition,
   { desc = "Go to definition" })
-- vim.keymap.set('n', '<leader>fb', vim.lsp.buf.format(),
--    { desc = "Format local buffer" })
--
-- local capabilites = vim.lsp.protocol.make_client_capabilities()
-- capabilites = vim.tbl_deep_extend("force", capabilites, require('mini.completion').get_lsp_capabilities())
--
-- -- mini.completion has extended capabilites for lsp
-- vim.lsp.config("*", { capabilites = capabilites })
