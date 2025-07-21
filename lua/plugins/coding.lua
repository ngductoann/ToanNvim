return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "utils" } },
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (not utils.is_win())
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = require("configs.coding.luasnip").opts,
    config = require("configs.coding.luasnip").config,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    build = "cargo build --release",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    dependencies = {
      -- add blink.compat to dependencies
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = "*",
      },
    },
    event = "InsertEnter",
    opts = require("configs.coding.blink").opts,
    config = require("configs.coding.blink").config,
  },

  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = require("configs.coding.mini-pairs").opts,
    config = require("configs.coding.mini-pairs").config,
  },

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
