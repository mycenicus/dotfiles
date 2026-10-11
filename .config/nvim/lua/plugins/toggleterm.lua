vim.pack.add({
   { src = 'https://github.com/akinsho/toggleterm.nvim' },
})

require('toggleterm').setup({
   size = function(term)
      if term.direction == 'horizontal' then
         return 13
      elseif term.direction == 'vertical' then
         return 45
      end
   end,
   open_mapping = [[<C-\>]],
   winbar = { enabled = true },
   shell = 'zsh',
   on_open = function(term)
      vim.cmd('startinsert!')
      vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', {
         noremap = true,
         silent = true,
         desc = 'Close terminal',
      })
   end,
})

local esc_timer = (vim.uv or vim.loop).new_timer()
function _G.set_terminal_keymaps()
   -- From snacks.terminal
   vim.keymap.set('t', '<Esc>', function()
      if esc_timer ~= nil then
         if esc_timer:is_active() then
            esc_timer:stop()
            return '<C-\\><C-n>'
         end

         esc_timer:start(200, 0, function() end)
         return '<Esc>'
      end
   end, {
      noremap = true,
      expr = true,
      desc = 'Double escape to normal mode',
   })
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

local Terminal = require('toggleterm.terminal').Terminal

vim.keymap.set('n', '<leader>tt', function()
   Terminal:new():toggle()
end, { desc = 'Create new terminal' })

vim.keymap.set('n', '<leader>tf', function()
   Terminal:new({ direction = 'float' }):toggle()
end, { desc = 'Create new terminal' })

vim.api.nvim_create_user_command('Python', function(opts)
   local term_opts = { cmd = 'python3' }

   -- Allows to write :vert Python
   if opts.smods.vertical then
      term_opts.direction = 'vertical'
   end

   Terminal:new(term_opts):toggle()
end, {})

vim.api.nvim_create_user_command('GHCi', function(opts)
   local term_opts = { cmd = 'ghci' }

   -- Allows to write :vert GHCi
   if opts.smods.vertical then
      term_opts.direction = 'vertical'
   end

   Terminal:new(term_opts):toggle()
end, {})
