local icons = require "icons"

local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local function get_lsp_info()
  local lsp = vim.lsp
  if not lsp then
    return ""
  end

  local bufnr = stbufnr()
  local columns = vim.o.columns

  for _, client in ipairs(lsp.get_clients()) do
    if client.attached_buffers[bufnr] then
      return columns > 100
        and ("  LSP ~ " .. client.name .. " ")
        or "  LSP "
    end
  end

  return ""
end

local function get_diagnostics_info()
  local lsp = vim.lsp
  local diagnostic = vim.diagnostic
  if not lsp or not diagnostic then
    return ""
  end

  local bufnr = stbufnr()
  local icons_diag = icons.minimal.diagnostics
  local severities = {
    { key = "Error", severity = diagnostic.severity.ERROR },
    { key = "Warn",  severity = diagnostic.severity.WARN },
    { key = "Hint",  severity = diagnostic.severity.HINT },
    { key = "Info",  severity = diagnostic.severity.INFO },
  }

  local result = {}
  for _, s in ipairs(severities) do
    local count = #diagnostic.get(bufnr, { severity = s.severity })
    if count > 0 then
      table.insert(result, icons_diag[s.key] .. tostring(count))
    end
  end

  return vim.trim(table.concat(result, " "))
end

local function git()
  local bufnr = stbufnr()
  local git_status = vim.b[bufnr].gitsigns_status_dict
  if not git_status then
    return ""
  end

  local parts = { " " .. (git_status.head or "") }
  if git_status.added and git_status.added ~= 0 then
    table.insert(parts, " " .. icons.minimal.git.added .. git_status.added)
  end
  if git_status.changed and git_status.changed ~= 0 then
    table.insert(parts, " " .. icons.minimal.git.modified .. git_status.changed)
  end
  if git_status.removed and git_status.removed ~= 0 then
    table.insert(parts, " " .. icons.minimal.git.removed .. git_status.removed)
  end

  return vim.trim(table.concat(parts))
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

        local lsp = vim.trim(get_lsp_info())
        local diagnostics = get_diagnostics_info()

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
