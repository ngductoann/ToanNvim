local M = {}

local stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end

  local err = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.ERROR })
  local warn = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.INFO })

  err = (err and err > 0) and ("E" .. err .. " ") or ""
  warn = (warn and warn > 0) and ("W" .. warn .. " ") or ""
  hints = (hints and hints > 0) and ("H" .. hints .. " ") or ""
  info = (info and info > 0) and ("I" .. info .. " ") or ""

  return vim.trim(" " .. err .. warn .. hints .. info)
end

local git = function()
  if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
    return ""
  end

  local git_status = vim.b[stbufnr()].gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and (" +" .. git_status.added) or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and (" ~" .. git_status.changed) or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and (" -" .. git_status.removed) or ""
  local branch_name = " " .. git_status.head

  return vim.trim(" " .. branch_name .. added .. changed .. removed)
end

M.opts = {
  set_vim_settings = false,
  content = {
    active = function()
      local MiniStatusline = require "mini.statusline"
      local filename = vim.fn.expand "%:."
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }

      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode:upper() } },
        { hl = "MiniStatuslineDevinfo", strings = { git() } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        {
          hl = "MiniStatuslineDevinfo",
          strings = {
            diagnostics(),
          },
        },
        {
          hl = "MiniStatuslineFileinfo",
          strings = {
            vim.bo.filetype ~= "" and require("mini.icons").get("filetype", vim.bo.filetype) .. " " .. vim.bo.filetype,
          },
        },
        { hl = mode_hl, strings = { "%l:%v" } },
      }
    end,
  },
}

return M
