local M = {}

M.opts = {
  history = true,
  delete_check_events = "TextChanged",
  updateevents = "TextChanged,TextChangedI",
}

M.config = function(_, opts)
  -- vscode format
  require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

  -- snipmate format
  require("luasnip.loaders.from_snipmate").load()
  require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

  -- lua format
  require("luasnip.loaders.from_lua").load()
  require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

  utils.cmp.actions.snippet_forward = function()
    if require("luasnip").jumpable(1) then
      vim.schedule(function()
        require("luasnip").jump(1)
      end)
      return true
    end
  end
  utils.cmp.actions.snippet_stop = function()
    if require("luasnip").expand_or_jumpable() then -- or just jumpable(1) is fine?
      require("luasnip").unlink_current()
      return true
    end
  end

  require("luasnip").config.set_config(opts)
end

return M
