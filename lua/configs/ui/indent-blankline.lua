local M = {}

M.opts = function()
  return {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "Trouble",
        "alpha",
        "dashboard",
        "help",
        "lazy",
        "mason",
        "neo-tree",
        "notify",
        "toggleterm",
        "trouble",
      },
    },
  }
end

return M
