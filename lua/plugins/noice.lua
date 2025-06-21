return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require "configs.noice",
    keys = require("configs.noice").keys,
    config = require("configs.noice").config,
  },
  { "MunifTanjim/nui.nvim", lazy = true },
}
