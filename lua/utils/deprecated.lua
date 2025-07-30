local M = {}

M.moved = {
  lsp = {
    rename_file = {},
    on_rename = {},
    words = {},
  },
  terminal = {
    open = {},
    __call = {},
  },
  ui = {
    statuscolumn = {},
    bufremove = {},
    fg = {},
  },
}

---@param name string
---@param mod table
function M.decorate(name, mod)
  if not M.moved[name] then
    return mod
  end
  setmetatable(mod, {
    __call = function(_, ...)
      local to = M.moved[name].__call[1]
      utils.deprecate("utils." .. name, to)
      local ret = vim.tbl_get(_G, unpack(vim.split(to, ".", { plain = true })))
      return ret(...)
    end,
    __index = function(_, k)
      if M.moved[name][k] then
        local to = M.moved[name][k][1]
        utils.deprecate("utils." .. name .. "." .. k, to)
        if M.moved[name][k].fn then
          return M.moved[name][k].fn
        end
        local ret = vim.tbl_get(_G, unpack(vim.split(to, ".", { plain = true })))
        return ret
      end
      return nil
    end,
  })
end

function M.toggle()
  utils.deprecate("utils.toggle", "Snacks.toggle")
  return {
    map = function() end,
    wrap = function()
      return {}
    end,
  }
end

return M
