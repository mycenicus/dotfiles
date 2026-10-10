-- Recreate hlyank package from vim
vim.api.nvim_create_autocmd('TextYankPost', {
   group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
   pattern = '*',
   desc = 'Highlight selection on yank',
   callback = function()
      vim.hl.on_yank({ timeout = 200, visual = true })
   end,
})

-- Restore cursor
vim.api.nvim_create_autocmd('BufReadPost', {
   desc = 'Restore last cursor position',
   callback = function(args)
      if vim.o.diff then -- Except in diff mode
         return
      end

      local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
      local line_count = vim.api.nvim_buf_line_count(args.buf)
      if mark[1] > 0 and mark[1] <= line_count then
         vim.api.nvim_win_set_cursor(0, mark)
         vim.schedule(function()
            vim.cmd('normal! zz')
         end)
      end
   end,
})

-- Wrap, linebreak and spellcheck for markdown and text files
vim.api.nvim_create_autocmd('FileType', {
   group = vim.api.nvim_create_augroup('text_edit', { clear = true }),
   pattern = { 'markdown', 'text', 'gitcommit' },
   callback = function()
      vim.o.linebreak = true
      vim.o.spell = true
   end,
})

-- Format on save. Used to be format on exit, but it's messy: clutters undotree
-- and can't quit nvim if formatting did happen.
vim.api.nvim_create_autocmd('BufWritePre', {
   group = vim.api.nvim_create_augroup('format_on_save', { clear = true }),
   callback = function(args)
      local bufnr = args.buf
      for _, cl in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
         if cl:supports_method('textDocument/formatting') then
            vim.lsp.buf.format({ bufnr = bufnr, async = false })
            break
         end
      end
   end,
})
