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

    local ls = require "luasnip"
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    ls.add_snippets("lua", {
      s("fn", {
        t "function ",
        i(1, "name"),
        t "()",
        t { "", "  " },
        i(0),
        t { "", "end" },
      }),
    })

    return {
      history = false,
      delete_check_events = "TextChanged",
    }
  end,
}
