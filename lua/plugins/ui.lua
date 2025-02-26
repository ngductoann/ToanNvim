return {
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = require "configs.gitsigns",
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>xw", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>xW", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    lazy = false,
    config = function()
      require("ufo").setup {
        fold_virt_text_handler = require("configs.nvim-ufo").handler,
      }
    end,
    otps = require("configs.nvim-ufo").opts,
    keys = require("configs.nvim-ufo").keys,
  },

  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = require("configs.snacks").opts,
    keys = require("configs.snacks").keys,
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      {
        "<leader>ss",
        "<cmd>Telescope aerial<cr>",
        desc = "Goto Symbol (Aerial)",
      },
    },
  },
}
