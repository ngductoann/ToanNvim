return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
    dependencies = {
      {
        "folke/which-key.nvim",
        keys = {
          { "<leader>bj", "<cmd>HopWord<cr>", desc = "Jump Word" },
          { "<leader>bw", "<cmd>HopWordCurrentLine<cr>", desc = "Jump Word" },
          { "<leader>bL", "<cmd>HopLine<cr>", desc = "Jump Line" },
          { "<leader>bC", "<cmd>HopCamelCase<cr>", desc = "Camel Case" },
        },
      },
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = { lsp = { auto_attach = true } },
    -- stylua: ignore
    keys = {
      { "<leader>cb", function() require("nvim-navbuddy").open() end, desc = "NavBuddy" },
    },
  },
}
