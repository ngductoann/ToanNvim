local M = {}

M.opts = {
  format = function(buf_id, label)
    local suffix = vim.bo[buf_id].modified and "[+] " or ""
    local diagnostics = vim.diagnostic.get(buf_id)
    local errors = 0
    local warnings = 0

    for _, d in ipairs(diagnostics) do
      if d.severity == vim.diagnostic.severity.ERROR then
        errors = errors + 1
      elseif d.severity == vim.diagnostic.severity.WARN then
        warnings = warnings + 1
      end
    end

    local diag_str = ""
    if errors > 0 then
      diag_str = diag_str .. "E" .. errors .. " "
    end
    if warnings > 0 then
      diag_str = diag_str .. "W" .. warnings .. " "
    end

    local result = "|" .. require("mini.tabline").default_format(buf_id, label)

    return result .. diag_str .. suffix
  end,
}

return M
