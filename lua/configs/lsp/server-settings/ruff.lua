return {
  init_options = {
    settings = {
      logLevel = "error",
    },
  },
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  settings = {},
  single_file_support = true,
}
