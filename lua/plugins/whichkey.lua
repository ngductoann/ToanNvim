return {
  "folke/which-key.nvim",
  opts_extend = { "spec" },
  opts = require("configs.whichkey").opts,
  keys = require("configs.whichkey").keys,
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)
    if not vim.tbl_isempty(opts.defaults) then
      utils.warn "which-key: opts.defaults is deprecated. Please use opts.spec instead."
    end
  end,
}
