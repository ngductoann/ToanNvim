return {
  {
    "lewis6991/gitsigns.nvim",
    event = utils.lazy_file_events,
    opts = require("configs.git.gitsign").opts,
  },
  {
    "isakbm/gitgraph.nvim",
    opts = require("configs.git.gitgraph").opts,
    keys = require("configs.git.gitgraph").keys,
  },
  {
    "sindrets/diffview.nvim",
    cond = utils.has_git,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = require("configs.git.diffview").opts,
    keys = require("configs.git.diffview").keys,
  },

  {
    "NeogitOrg/neogit",
    cond = utils.has_git,
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
    -- See: https://github.com/TimUntersberger/neogit#configuration
    opts = {
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      signs = {
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
      },
      integrations = {
        diffview = true,
        fzf_lua = true,
      },
    },
  },
}
