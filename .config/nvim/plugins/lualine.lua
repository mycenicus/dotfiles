vim.pack.add({
   { src = 'https://github.com/nvim-lualine/lualine.nvim' }
})

local branch = { 'branch', icon = { '', color = { fg = '#A6D4DE' } } }

require('lualine').setup {
   options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '|', right = '' },
      section_separators = { left = '', right = '' },
      refresh = {
         statusline = 1000,
         tabline = 1000,
         winbar = 1000,
         refresh_time = 16, -- ~60fps
         events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
         },
      }
   },
   sections = {
      lualine_a = { 'mode' },
      lualine_b = { branch },
      lualine_c = { 'filename', 'diff', 'diagnostics' },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
   },
   inactive_sections = {
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
   },
}
