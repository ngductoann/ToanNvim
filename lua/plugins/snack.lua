return {
  {
    "snacks.nvim",
    init = require("configs.snacks").init,
    opts = require("configs.snacks").opts,
    -- stylua: ignore
    keys = require("configs.snacks").keys,
  },
}
