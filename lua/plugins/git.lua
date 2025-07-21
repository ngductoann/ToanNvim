return {
  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = require("configs.git.gitsign").opts,
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gD", "<cmd>DiffviewFileHistory %<CR>", desc = "Diff File" },
      { "<leader>gv", "<cmd>DiffviewOpen<CR>", desc = "Diff View" },
    },
    opts = require("configs.git.diffview").opts,
  },
}
