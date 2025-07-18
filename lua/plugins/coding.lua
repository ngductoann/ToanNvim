return {
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "utils" } },
      },
    },
  },

  -- auto pairs
  -- {
  --   "echasnovski/mini.pairs",
  --   event = "VeryLazy",
  --   opts = require("configs.coding.mini-pairs").opts,
  --   config = require("configs.coding.mini-pairs").config,
  -- },

  -- comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = require("configs.coding.mini-ai").opts,
    configs = require("configs.coding.mini-ai").config,
  },

  {
    "echasnovski/mini.surround",
    opts = require("configs.coding.mini-surround").opts,
    config = require("configs.coding.mini-surround").config,
  },

  {
    "danymat/neogen",
    dependencies = utils.has "mini.snippets" and { "mini.snippets" } or {},
    cmd = "Neogen",
    opts = require("configs.coding.neogen").opts,
    keys = require("configs.coding.neogen").keys,
  },
}
