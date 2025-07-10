return {
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = "User FilePost",
  --   opts = require("configs.git.gitsign").opts,
  -- },
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

  -- {
  --   "f-person/git-blame.nvim",
  --   cond = utils.has_git,
  --   -- load the plugin at startup
  --   event = "VeryLazy",
  --   -- Because of the keys part, you will be lazy loading this plugin.
  --   -- The plugin will only load once one of the keys is used.
  --   -- If you want to load the plugin at startup, add something like event = "VeryLazy",
  --   -- or lazy = false. One of both options will work.
  --   opts = {
  --     -- your configuration comes here
  --     -- for example
  --     enabled = true, -- if you want to enable the plugin
  --     message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
  --     date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
  --     virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
  --   },
  -- },
}
