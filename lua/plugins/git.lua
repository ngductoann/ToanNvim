return {
  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
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
}
