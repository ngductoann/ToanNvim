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

  {
    "echasnovski/mini.statusline",
    version = false,
    event = "User FilePost",
    opts = require("configs.ui.mini-statusline").opts,
  },

  {
    "echasnovski/mini.tabline",
    version = false,
    event = "User FilePost",
    opts = require("configs.ui.mini-tabline").opts,
  },

  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "User FilePost",
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    main = "ibl",
    opts = require("configs.ui.indent-blankline").opts,
  },

  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    cond = vim.g.neovide == nil,
    opts = require("configs.ui.mini-animate").opts,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    opts = require("configs.ui.nvim-colorizer").opts,
  },
}
