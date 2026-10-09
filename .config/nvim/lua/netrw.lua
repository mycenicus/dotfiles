-- Options to make netrw popup as a tree on the left
vim.g.netrw_liststyle = 3    -- tree view
vim.g.netrw_banner = 0       -- hide the top banner
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 0 -- open files in the same window
vim.g.netrw_altfile = 1      -- makes CTRL-^ return to the last edited file

vim.keymap.set("n", "<leader>tv", ":Lexplore<cr>", {
   silent = true,
   desc = "Open tree view"
})
vim.keymap.set("n", "<leader>e", ":Explore<cr>", {
   silent = true,
   desc = "Open netrw"
})

-- remove diagnostics column for netrw, add numbers to it (I find it useful)
vim.api.nvim_create_autocmd("FileType", {
   pattern = "netrw",
   callback = function()
      vim.diagnostic.enable(false, { bufnr = 0 })
      vim.opt_local.signcolumn = "no"
      vim.opt_local.number = true
      vim.opt_local.rnu = true
      vim.opt_local.numberwidth = 3
   end,
})
