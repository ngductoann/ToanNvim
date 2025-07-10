return {
  -- {
  --   "Mofiqul/vscode.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   config = function()
  --     require("configs.colorscheme").vscode.config()
  --     -- vim.cmd.colorscheme "vscode"
  --   end,
  -- },
  --
  -- {
  --   "RRethy/base16-nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("configs.colorscheme").base16.config()
  --     vim.cmd.colorscheme "base16-onedark-dark"
  --   end,
  -- },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require("configs.ui.noice").opts,
    config = require("configs.ui.noice").config,
    keys = require("configs.ui.noice").keys,
  },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = require("configs.ui.indent-blankline").opts,
    config = require("configs.ui.indent-blankline").config,
  },
}
