vim.pack.add({
   { src = 'https://github.com/lewis6991/gitsigns.nvim' },
   { src = 'https://github.com/tpope/vim-fugitive' },
})

local myfugitive = vim.api.nvim_create_augroup('myfugitive', {})

vim.api.nvim_create_autocmd('BufWinEnter', {
   group = myfugitive,
   pattern = '*',
   callback = function()
      if vim.bo.ft ~= 'fugitive' then
         return
      end

      local bufnr = vim.api.nvim_get_current_buf()
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set('n', '<leader>P', function()
         vim.cmd.Git('push')
      end, opts)

      vim.keymap.set('n', '<leader>p', function()
         vim.cmd.Git({ 'pull', '--rebase' })
      end, opts)

      vim.keymap.set('n', '<leader>t', ':Git push -u origin', opts)
   end,
})

vim.keymap.set('n', '<leader>gg', vim.cmd.Git)

require('gitsigns').setup({
   on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
         opts = opts or {}
         opts.buffer = bufnr
         vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
         if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
         else
            gitsigns.nav_hunk('next')
         end
      end)

      map('n', '[c', function()
         if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
         else
            gitsigns.nav_hunk('prev')
         end
      end)

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk)
      map('n', '<leader>hr', gitsigns.reset_hunk)

      map('v', '<leader>hs', function()
         gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)

      map('v', '<leader>hr', function()
         gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)

      map('n', '<leader>hS', gitsigns.stage_buffer)
      map('n', '<leader>hR', gitsigns.reset_buffer)
      map('n', '<leader>hp', gitsigns.preview_hunk)
      map('n', '<leader>hi', gitsigns.preview_hunk_inline)

      map('n', '<leader>hb', function()
         gitsigns.blame_line({ full = true })
      end)

      map('n', '<leader>hd', gitsigns.diffthis)

      map('n', '<leader>hD', function()
         gitsigns.diffthis('~')
      end)

      map('n', '<leader>hQ', function()
         gitsigns.setqflist('all')
      end)
      map('n', '<leader>hq', gitsigns.setqflist)

      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      map('n', '<leader>tw', gitsigns.toggle_word_diff)

      -- Text object
      map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
   end,
})
