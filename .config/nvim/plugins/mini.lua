vim.pack.add({
   { src = "https://github.com/nvim-mini/mini.nvim" },
})

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('mini.snippets').setup()
-- require('mini.completion').setup()
-- vim.schedule(function()
--    vim.pack.add({
--       'https://github.com/nvim-mini/mini.completion',
--    })
--    MiniIcons.tweak_lsp_kind("prepend")
-- end)
-- vim.o.completeopt = "menuone,noselect,fuzzy,nosort" -- For proper function of mini.completion

require('mini.notify').setup({
   content = {
      format = function(notif)
         return notif.msg
      end,
   },
})

-- require('mini.cmdline').setup({
--    autocomplete = {
--       predicate = function()
--          return vim.fn.getcmdpos() > 3 -- pop wildmenu only after 3 characters
--       end,
--    },
--    autocorrect = { enable = false, func = nil },
-- })

-- saw(: add surround around word with ()
-- sdw(: delete surround () around word
-- srw(: replace surroundings of word with ()
-- sf: find surround
-- sh: highlight surround
require('mini.surround').setup()

require('mini.pairs').setup()

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
   highlighters = {
      fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
   },
})
