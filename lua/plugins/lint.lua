return {
  {
    "mfussenegger/nvim-lint",
    event = utils.lazy_file_events,
    opts = require("configs.nvim-lint").opts,
    config = require("configs.nvim-lint").config,
  },
}
