local icons = require "icons"

return {
  opts = {
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
        diag_str = diag_str .. icons.minimal.diagnostics.Error .. errors .. " "
      end
      if warnings > 0 then
        diag_str = diag_str .. icons.minimal.diagnostics.Warn .. warnings .. " "
      end

      local result = "|" .. require("mini.tabline").default_format(buf_id, label)

      -- Truncate to 31 characters
      if #result > 31 then
        result = result:sub(1, 28) .. "…" .. "." .. vim.bo.filetype .. " " -- add ellipsis if too long
      end

      return result .. diag_str .. suffix
    end,
  },
}
