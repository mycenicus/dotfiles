vim.lsp.enable({
   "lua_ls",
})

local signs = {
   [vim.diagnostic.severity.ERROR] = "󰅚 ",
   [vim.diagnostic.severity.WARN] = "󰀪 ",
   [vim.diagnostic.severity.INFO] = "󰋽 ",
   [vim.diagnostic.severity.HINT] = "󰌶 ",
}
vim.diagnostic.config({ -- the text at the right, if something is wrong
   virtual_text = true,
   signs = { text = signs },
   float = {
      border = 'rounded',
   },
})

vim.api.nvim_create_autocmd("LspAttach", { -- Enable built-in Lsp autocompletion
   group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
   callback = function(ev)
      vim.keymap.set('n', '<leader>v', ':vsplit | lua vim.lsp.buf.definition()<cr>', {
         buffer = ev.buf,
         desc = "Goto definition in vertical split"
      })

      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client ~= nil and client:supports_method("textDocument/documentHighlight", ev.buf) then
         local hl_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

         -- When cursor stops moving: Higlights all instances of the symbol
         -- under the cursor
         -- When cursor moves: Clears the highlight
         vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = ev.buf,
            group = hl_augroup,
            callback = vim.lsp.buf.document_highlight
         })
         vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = ev.buf,
            group = hl_augroup,
            callback = vim.lsp.buf.clear_references
         })

         -- When LSP detaches: clear highlight
         vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
               vim.lsp.buf.clear_references()
               vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
            end
         })

         -- No need since we use blink.cmp
         -- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
   end,
})

-- HACK (IF WE USE :55)
-- Needed for autocomplete
-- vim.o.autocomplete = true
-- vim.o.complete = "o,.^4,w^4,b^4,u^4"
-- vim.cmd("set completeopt+=noselect") -- don't autocomplete
