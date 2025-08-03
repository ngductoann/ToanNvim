return {
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

  -- {
  --   "echasnovski/mini.indentscope",
  --   version = false, -- wait till new 0.7.0 release to put it back on semver
  --   event = "User FilePost",
  --   init = require("configs.ui.mini-indentscope").init,
  --   opts = require("configs.ui.mini-indentscope").opts,
  -- },

  -- disable inent-blankline scope when mini-indentscope is enabled
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    opts = {
      scope = { enabled = false },
    },
  },

  -- {
  --   "echasnovski/mini.animate",
  --   event = "VeryLazy",
  --   cond = vim.g.neovide == nil,
  --   opts = require("configs.ui.mini-animate").opts,
  -- },

  {
    "snacks.nvim",
    init = require("configs.ui.snacks").init,
    opts = require("configs.ui.snacks").opts,
    keys = require("configs.ui.snacks").keys,
  },
}
