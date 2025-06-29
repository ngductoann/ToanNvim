local M = {}

M.misc = {
  dots = "󰇘",
}
M.ft = {
  octo = "",
}
M.dap = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}
M.diagnostics = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

M.git = {
  added = " ",
  modified = " ",
  removed = " ",
}

M.minimal = {}

M.minimal.diagnostics = {
  Error = "E",
  Warn = "W",
  Hint = "H",
  Info = "I",
}

M.minimal.git = {
  added = "+",
  modified = "~",
  removed = "-",
}

M.kinds = {
  Control = " ",
  Collapsed = " ",
  Key = " ",
  Namespace = "󰌗 ",
  Text = "󰉿 ",
  Method = "󰆧 ",
  Function = "󰆧 ",
  Constructor = " ",
  Field = "󰜢 ",
  Variable = "󰀫 ",
  Class = "󰠱 ",
  Interface = " ",
  Module = " ",
  Property = "󰜢 ",
  Unit = "󰑭 ",
  Value = "󰎠 ",
  Enum = " ",
  Keyword = "󰌋 ",
  Snippet = " ",
  Color = "󱓻 ",
  File = "󰈚 ",
  Reference = "󰈇 ",
  Folder = "󰉋 ",
  EnumMember = " ",
  Constant = "󰏿 ",
  Struct = "󰙅 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰊄 ",
  Table = " ",
  Object = "󰅩 ",
  Tag = " ",
  Array = "[] ",
  Boolean = " ",
  Number = " ",
  Null = "󰟢 ",
  Supermaven = " ",
  String = "󰉿 ",
  Calendar = " ",
  Watch = "󰥔 ",
  Package = " ",
  Copilot = " ",
  Codeium = " ",
  TabNine = " ",
  BladeNav = " ",
}

M.kind_filter = {
  default = {
    "Class",
    "Constructor",
    "Enum",
    "Field",
    "Function",
    "Interface",
    "Method",
    "Module",
    "Namespace",
    "Package",
    "Property",
    "Struct",
    "Trait",
  },
  markdown = false,
  help = false,
  -- you can specify a different filter for each filetype
  lua = {
    "Class",
    "Constructor",
    "Enum",
    "Field",
    "Function",
    "Interface",
    "Method",
    "Module",
    "Namespace",
    -- "Package", -- remove package since luals uses it for control flow structures
    "Property",
    "Struct",
    "Trait",
  },
}

function M.get_kind_filter(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local ft = vim.bo[buf].filetype
  if M.kind_filter == false then
    return
  end
  if M.kind_filter[ft] == false then
    return
  end
  if type(M.kind_filter[ft]) == "table" then
    return M.kind_filter[ft]
  end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(M.kind_filter) == "table" and type(M.kind_filter.default) == "table" and M.kind_filter.default or nil
end

return M
