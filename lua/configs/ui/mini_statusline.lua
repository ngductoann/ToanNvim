local icons = require "icons"

local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local function lsp()
  if rawget(vim, "lsp") then
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[stbufnr()] then
        return (vim.o.columns > 100 and "  LSP ~ " .. client.name .. " ") or "  LSP "
      end
    end
  end

  return ""
end

local function diagnostics()
  if not rawget(vim, "lsp") then
    return ""
  end

  local err = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.ERROR })
  local warn = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.INFO })

  err = (err and err > 0) and (icons.minimal.diagnostics.Error .. err .. " ") or ""
  warn = (warn and warn > 0) and (icons.minimal.diagnostics.Warn .. warn .. " ") or ""
  hints = (hints and hints > 0) and (icons.minimal.diagnostics.Hint .. hints .. " ") or ""
  info = (info and info > 0) and (icons.minimal.diagnostics.Info .. info .. " ") or ""
  return vim.trim(err .. warn .. hints .. info)
end

local function git()
  if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
    return ""
  end

  local git_status = vim.b[stbufnr()].gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and (" " .. icons.minimal.git.added .. git_status.added)
    or ""
  local changed = (git_status.changed and git_status.changed ~= 0)
      and (" " .. icons.minimal.git.modified .. git_status.changed)
    or ""
  local removed = (git_status.removed and git_status.removed ~= 0)
      and (" " .. icons.minimal.git.removed .. git_status.removed)
    or ""
  local branch_name = " " .. git_status.head

  return vim.trim(branch_name .. added .. changed .. removed)
end

return {
  opts = {
    set_vim_settings = false,
    content = {
      active = function()
        local MiniStatusline = require "mini.statusline"
        local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
        local filename = icons.kinds.File .. vim.fn.expand "%:t"
        local lsp_and_diagnostics = {}

        local lsp = vim.trim(lsp())
        local diagnostics = diagnostics()

        if lsp ~= "" then
          table.insert(lsp_and_diagnostics, lsp)
        end

        if diagnostics ~= "" then
          table.insert(lsp_and_diagnostics, diagnostics)
        end

        local lsp_and_diagnostics_str = table.concat(lsp_and_diagnostics, " | ")

        return MiniStatusline.combine_groups {
          { hl = mode_hl, strings = { mode:upper() } },
          { hl = "MiniStatuslineFilename", strings = { git() } },
          "%<", -- Mark general truncate point
          { hl = "MiniStatuslineNavic", strings = { filename } },
          "%=", -- End left alignment
          {
            hl = "MiniStatuslineFileinfo",
            strings = { lsp_and_diagnostics_str },
          },
          {
            hl = mode_hl,
            strings = {
              vim.bo.filetype ~= ""
                and require("mini.icons").get("filetype", vim.bo.filetype) .. " " .. vim.bo.filetype,
              "|",
              "%l:%v",
            },
          },
        }
      end,
    },
  },
}
