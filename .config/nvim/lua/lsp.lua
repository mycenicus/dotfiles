local signs = {
   [vim.diagnostic.severity.ERROR] = '󰅚 ',
   [vim.diagnostic.severity.WARN] = '󰀪 ',
   [vim.diagnostic.severity.INFO] = '󰋽 ',
   [vim.diagnostic.severity.HINT] = '󰌶 ',
}
vim.diagnostic.config({ -- the text at the right, if something is wrong
   virtual_text = true,
   signs = { text = signs },
   float = {
      border = 'rounded',
   },
})

vim.api.nvim_create_autocmd('LspAttach', {
   group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
   callback = function(ev)
      vim.keymap.set('n', '<leader>v', ':vsplit | lua vim.lsp.buf.definition()<cr>', {
         buffer = ev.buf,
         desc = 'Goto definition in vertical split',
      })

      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client ~= nil and client:supports_method('textDocument/documentHighlight', ev.buf) then
         local hl_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

         -- When cursor stops moving: Higlights all instances of the symbol
         -- under the cursor
         -- When cursor moves: Clears the highlight
         vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = ev.buf,
            group = hl_augroup,
            callback = vim.lsp.buf.document_highlight,
         })
         vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = ev.buf,
            group = hl_augroup,
            callback = vim.lsp.buf.clear_references,
         })

         -- When LSP detaches: clear highlight
         vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
               vim.lsp.buf.clear_references()
               vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
            end,
         })
      end
   end,
})

vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- Diagnostics
vim.keymap.set('n', '<leader>dt', function()
   vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, desc = 'Toggle diagnostics' })

vim.keymap.set('n', '<leader>dh', function()
   local current = vim.diagnostic.config().virtual_text
   vim.diagnostic.config({ virtual_text = not current })
end, { desc = 'Toggle diagnostics virtual text' })

vim.keymap.set('n', '<leader>dq', function()
   vim.diagnostic.setqflist()
   vim.cmd('copen')
end, { silent = true, desc = 'Open diagnostics in quickfix list.' })

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open diagnostic under cursor in a floating window' })
vim.keymap.set('n', 'gh', function()
   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hint' })
