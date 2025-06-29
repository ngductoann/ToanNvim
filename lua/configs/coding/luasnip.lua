return {
  opts = function()
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

    return {
      history = true,
      delete_check_events = "TextChanged",
    }
  end,
}
