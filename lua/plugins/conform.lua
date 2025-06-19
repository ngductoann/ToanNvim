return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require("configs.conform").opts,
  },

  {
    "stevearc/conform.nvim",
    opts = require("configs.conform").opts_prettier,
  },
}
