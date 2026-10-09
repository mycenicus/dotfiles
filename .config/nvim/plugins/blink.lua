vim.pack.add({
   { src = 'https://github.com/saghen/blink.lib' },
   { src = 'https://github.com/saghen/blink.cmp',         branch = "main" },
   { src = 'https://github.com/xzbdmw/colorful-menu.nvim' },
})

require('colorful-menu').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
vim.lsp.config("*", { capabilities = capabilities })

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
   -- All presets have the following mappings:
   -- C-space: Open menu or open docs if already open
   -- C-n/C-p or Up/Down: Select next/previous item
   -- C-e: Hide menu
   -- C-k: Toggle signature help (if signature.enabled = true)
   keymap = {
      preset = 'default',
      ['<C-n>'] = {
         function(blkcmp)
            if blkcmp.is_menu_visible() then
               return blkcmp.select_next()
            elseif blkcmp.is_ghost_text_visible() then
               return blkcmp.accept()
            end
         end,
         'fallback',
      },
   },

   completion = {
      menu = {
         auto_show = false,
         draw = {
            columns = { { "label" }, { "kind_icon", "kind", gap = 1 } },
            components = {
               kind_icon = {
                  text = function(ctx)
                     local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                     return kind_icon
                  end,
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                     local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                     return hl
                  end,
               },
               kind = {
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                     local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                     return hl
                  end,
               },
               label = {
                  text = function(ctx)
                     return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                     return require("colorful-menu").blink_components_highlight(ctx)
                  end,
               }
            }
         },
      },
      documentation = { auto_show = false },
      ghost_text = { enabled = true, show_with_menu = true },
      accept = { auto_brackets = { enabled = true }, },
   },
   cmdline = {
      enabled = true,
      keymap = {
         preset = "cmdline",
         ['<Tab>'] = { 'accept_and_enter' },
      },
      completion = {
         menu = {
            -- show menu only if 3 characters were typed. Removes annoying menu
            -- popup when writing :w :b etc.
            auto_show = function(_, _)
               return vim.fn.getcmdpos() > 3
            end
         }
      },
   },
   signature = {
      enabled = true,
   },

   sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
   appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = "mono" },

   fuzzy = { implementation = "rust" } -- Requires last toolchain, i.e. rustup
})
