return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false }, -- Disabled because it conflicts with the new UI
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require("configs.ui.noice").opts,
    config = require("configs.ui.noice").config,
    keys = require("configs.ui.noice").keys,
  },

  -- icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    init = require("configs.ui.mini-icons").init,
    opts = require("configs.ui.mini-icons").opts,
  },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "snacks.nvim",
    opts = require("configs.ui.snacks").opts,
    keys = require("configs.ui.snacks").keys,
  },
}
