local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    ["python"] = { "black" },
    java = { "google-java-format" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    injected = { options = { ignore_errors = true } },
    ["google-java-format"] = {
      prepend_args = { "--aosp" }, -- Ensure 4-space indentation
    },
  },
}

return options
