vim.pack.add({
   { src = 'https://github.com/nvim-mini/mini.nvim' },
})

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('mini.snippets').setup()

require('mini.notify').setup({
   content = {
      format = function(notif)
         return notif.msg
      end,
   },
})

-- saw(: add surround around word with ()
-- sdw(: delete surround () around word
-- srw(: replace surroundings of word with ()
-- sf: find surround
-- sh: highlight surround
require('mini.surround').setup()

require('mini.pairs').setup()

-- Adds different motions with a,i prefixes:
-- q - quote (iq, aq)
-- b - bracket (ib, ab)
-- f - function (if, af)
-- a - argument (ia, aa)
local spec_treesitter = require('mini.ai').gen_spec.treesitter
require('mini.ai').setup({
   mappings = { -- preserve nvim builtin an in
      around_next = 'aN',
      inside_next = 'iN',
      around_last = 'aL',
      inside_last = 'iL',
   },
   custom_textobjects = {
      F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
      o = spec_treesitter({
         a = { '@conditional.outer', '@loop.outer' },
         i = { '@conditional.inner', '@loop.inner' },
      }),
      c = spec_treesitter({ a = '@call.outer', i = '@call.inner' }),
      a = spec_treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
   },
})

require('mini.comment').setup()

-- Apart from scope, adds a few text objects and motions
-- Text objects:
-- ii - inside indent scope
-- ai - around indent scope (i.e with border)
-- Motions:
-- goto top: [i
-- goto bottom: ]i
require('mini.indentscope').setup({
   -- symbol = '┃'
})

-- unrolls tables
-- local tbl = { a, f(1,2), {b,c}, d}
-- gS
-- local tbl = {
--    a,
--    f(1,2),
--    {b,c},
--    d
-- }
require('mini.splitjoin').setup()
