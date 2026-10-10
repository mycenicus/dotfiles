vim.pack.add({
   { src = 'https://github.com/stevearc/oil.nvim' },
   { src = 'https://github.com/refractalize/oil-git-status.nvim' },
})

-- g? Show help
-- <C-s> Open in vertical split
-- <C-h> Open in horizontal split
-- <C-t> Open in new tab
-- <C-p> Preview
-- <C-c> Close oil
-- <C-l> Refresh
-- - Go to previous dir
-- _ Open cwd
-- ` Set cwd
-- g~ Set cwd?
-- gs Change sorting
-- gx Open in external program
-- g. Toggle hidden
-- g\ Toggle trash
require('oil').setup({
   default_file_explorer = false, -- Keep netrw
   win_options = {
      signcolumn = 'yes:2',
   },
   skip_confirm_for_simple_edits = true,
   watch_for_changes = true,
})

require('oil-git-status').setup()

vim.keymap.set('n', '<leader>e', ':Oil<cr>', { silent = true, desc = 'Open oil' })
