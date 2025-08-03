return {
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- add snippet_forward action
  {
    "L3MON4D3/LuaSnip",
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

  -- nvim-cmp integration
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      table.insert(opts.sources, { name = "luasnip" })
    end,
    -- stylua: ignore
    keys = {
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

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
    config = require("configs.coding.mini-ai").config,
  },
  {

    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "utils" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
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
    opts = require("configs.coding.mini-surround").opts,
    keys = require("configs.coding.mini-surround").keys,
  },
}
