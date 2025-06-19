return {
  "nvim-neotest/neotest",
  dependencies = { "nvim-neotest/nvim-nio" },
  opts = require("configs.neotest").opts,
  config = require("configs.neotest").config,
  keymaps = require("configs.neotest").keys,
}
