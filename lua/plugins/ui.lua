return {
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require("configs.ui.noice").opts,
    config = require("configs.ui.noice").config,
  },

  -- icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    init = require("configs.ui.mini_icons").init,
    opts = require("configs.ui.mini_icons").opts,
  },

  {
    "echasnovski/mini.statusline",
    version = false,
    event = "VeryLazy",
    opts = require("configs.ui.mini_statusline").opts,
  },
  {
    "echasnovski/mini.tabline",
    version = false,
    event = "VeryLazy",
    opts = require("configs.ui.mini_tabline").opts,
  },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
}
