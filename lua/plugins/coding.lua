return {
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

  -- add luasnip
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (not utils.is_win())
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath "config" .. "/snippets" } }
        end,
      },
    },
    opts = require("configs.coding.luasnip").opts,
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
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies
      {
        "saghen/blink.compat",
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
    opts = require("configs.coding.mini_pairs").opts,
    config = require("configs.coding.mini_pairs").config,
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
    opts = require("configs.coding.mini_ai").opts,
    config = require("configs.coding.mini_ai").config,
  },

  {
    "danymat/neogen",
    dependencies = utils.has "mini.snippets" and { "mini.snippets" } or {},
    cmd = "Neogen",
    opts = require("configs.coding.neogen").opts,
    keys = require("configs.coding.neogen").keys,
  },

  {
    "echasnovski/mini.surround",
    opts = require("configs.coding.mini_surround").opts,
    keys = require("configs.coding.mini_surround").keys,
  },
}
