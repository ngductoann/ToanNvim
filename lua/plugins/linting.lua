return {
  {
    "mfussenegger/nvim-lint",
    event = "User FilePost",
    opts = require("configs.linting").opts,
    config = require("configs.linting").config,
  },
}
