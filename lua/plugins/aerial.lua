return {
  "stevearc/aerial.nvim",
  event = utils.lazy_file_events,
  opts = require("configs.aerial").config,
  keys = {
    { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
  },
}
