return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = require("configs.testing").opts,
    configs = require("configs.testing").config,
    keys = require("configs.testing").keys,
  },
}
