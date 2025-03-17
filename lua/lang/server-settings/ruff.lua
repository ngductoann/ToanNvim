local utils = require "utils"

return {
  cmd_env = { RUFF_TRACE = "messages" },
  init_options = {
    settings = {
      logLevel = "error",
    },
  },
  keys = {
    {
      "<leader>co",
      utils.action["source.organizeImports"],
      desc = "Organize Imports",
    },
  },
}
