return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = require("configs.snacks").init,
  opts = require("configs.snacks").opts,
  config = require("configs.snacks").config,
  keys = require("configs.snacks").keys,
}
