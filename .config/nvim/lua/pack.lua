vim.api.nvim_create_user_command("PackAdd", function(opts)
   vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd builtin/repo)" })

vim.api.nvim_create_user_command("PackDelete", function(opts)
   vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackAdd builtin/repo)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
   if opts.args:match("%S") then
      local plugins = vim.split(opts.args, "%s+", { trimempty = true })
      vim.pack.update(plugins)
   else
      vim.pack.update()
   end
end, { nargs = "*", desc = "Update all plugins or specific ones" })

vim.api.nvim_create_user_command("PackCheck", function()
   local non_active = vim.iter(vim.pack.get())
       :filter(function(x) return not x.active end)
       :map(function(x) return x.spec.name end)
       :totable()

   if #non_active == 0 then
      vim.notify("🆗 No non-active plugins found!", vim.log.levels.INFO)
      return
   end

   vim.print("😴 Non-active plugins: ")
   print(" ")
   for _, name in ipairs(non_active) do
      print(name)
   end

   print(" ")

   local choice = vim.fn.confirm(
      "Delete ALL non-active plugins from disk?",
      "&Yes\n&No",
      2
   )

   if choice == 1 then
      vim.pack.del(non_active)
      vim.notify(" Deleted " .. #non_active .. " non-active plugin(s)", vim.log.levels.INFO)
      print("Non-active plugins deleted!")
      vim.api.nvim_exec_autocmds("User", { pattern = "PackChanged" })
   else
      vim.notify("Cancelled. No plugins were deleted!", vim.log.levels.INFO)
   end
end, { nargs = "*", desc = "Update all plugins or specific ones" })
