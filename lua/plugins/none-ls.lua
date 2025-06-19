return {
  "nvimtools/none-ls.nvim",
  event = utils.lazy_file_events,
  dependencies = { "mason.nvim" },
  opts = require("configs.none-ls").opts,
}
