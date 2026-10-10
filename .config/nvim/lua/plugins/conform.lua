vim.pack.add({
   { src = 'https://github.com/stevearc/conform.nvim' },
})

vim.api.nvim_del_augroup_by_name('format_on_save')

require('conform').setup({
   formatters_by_ft = {
      python = { 'ruff' },
      lua = { 'stylua' },
      -- -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      -- -- You can customize some of the format options for the filetype (:help conform.format)
      -- rust = { "rustfmt", lsp_format = "fallback" },
      -- -- Conform will run the first available formatter
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
   },
   format_on_save = {
      timeout_ms = 1000,
      lsp_format = 'fallback',
   },

   formatters = {
      stylua = {
         prepend_args = {
            '--quote-style',
            'AutoPreferSingle',
            '--indent-type',
            'Spaces',
            '--indent-width',
            '3',
         },
      },
   },
})
