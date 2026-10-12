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

-- Move selected text with <A-j> <A-k> etc.
require('mini.move').setup()

require('mini.tabline').setup()
vim.o.showtabline = 1

local statuscolumn = require('mini.statuscolumn')

-- HACK: https://www.reddit.com/r/neovim/comments/1djjc6q/statuscolumn_a_beginers_guide/
statuscolumn.folds = function()
   local foldlevel = vim.fn.foldlevel(vim.v.lnum)
   local foldlevel_before = vim.fn.foldlevel((vim.v.lnum - 1) >= 1 and vim.v.lnum - 1 or 1)
   local foldlevel_after =
      vim.fn.foldlevel((vim.v.lnum + 1) <= vim.fn.line('$') and (vim.v.lnum + 1) or vim.fn.line('$'))

   local foldclosed = vim.fn.foldclosed(vim.v.lnum)

   -- Line has nothing to do with folds so we will skip it
   if foldlevel == 0 then
      return ' '
   end

   -- Line is a closed fold(I know second condition feels unnecessary but I will still add it)
   if foldclosed ~= -1 and foldclosed == vim.v.lnum then
      return '%#FoldColumn#>'
   end

   -- I didn't use ~= because it couldn't make a nested fold have a lower level than it's parent fold and it's not something I would use
   if foldlevel > foldlevel_before then
      return '%#FoldColumn#∨'
   end

   -- The line is the last line in the fold
   if foldlevel > foldlevel_after then
      return '%#FoldLine#╰'
   end

   -- Line is in the middle of an open fold
   return '%#FoldLine#│'
end
-- stylua: ignore end

local spec = {
   { ltype = 'virt', lnum = '•' },
   { ltype = 'wrap', lnum = '↳' },
   {
      win = 'active',
      fold = '%{%v:lua.require("mini.statuscolumn").folds()%}',
      sign = '%s',
      sep = ' ',
      lnum = '%l',
      format = 'fs=l',
   },
   -- Dim every section, except for CursorLineNr
   {
      win = 'inactive',
      pos = 'cursor',
      sign = '%#DimCursorLine# ',
      sep = '%#DimCursorLine# ',
      lnum = '%#DimCursorLineNr#%l',
   },
}
statuscolumn.setup({ content = statuscolumn.gen_content.main(spec), dim_inactive = true })

require('mini.operators').setup({
   exchange = {
      -- NOTE: Default `gx` is remapped to `gX`
      prefix = 'gx',
   },
   sort = {
      prefix = 'gs',
   },
   multiply = { prefix = '' },
   replace = { prefix = '' },
   evaluate = { prefix = '' },
})
