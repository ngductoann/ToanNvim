local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    java = { "google-java-format" },
    c_cpp = { "clang-format" }, -- Hack to force download.
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "goimports", "gofumpt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    ["google-java-format"] = {
      prepend_args = { "--aosp" },
    },
    ["clang-format"] = {
      prepend_args = {
        "-style={ \
                IndentWidth: 4, \
                TabWidth: 4, \
                UseTab: Never, \
                AccessModifierOffset: 0, \
                IndentAccessModifiers: true, \
                PackConstructorInitializers: Never}",
      },
    },
    black = {
      prepend_args = {
        "--fast",
        "--line-length",
        "80",
      },
    },
    isort = {
      prepend_args = {
        "--profile",
        "black",
      },
    },
  },
}

return options
