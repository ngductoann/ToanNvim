local leet_arg = "leetcode.nvim"

return {
  "nvim-lua/plenary.nvim",

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "editorconfig/editorconfig-vim",
    event = "VeryLazy",
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    lazy = leet_arg ~= vim.fn.argv(0, -1),
    dependencies = {
      -- include a picker of your choice, see picker section for more details
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      arg = leet_arg,
      lang = "java",
      storage = {
        home = "/home/toan/d/workspaces/leetcode",
        cache = "/home/toan/d/workspaces/leetcode",
      },
    },
    config = function(_, opts)
      require("leetcode").setup(opts)
      vim.cmd [[silent! Copilot disable]]
      vim.g.leetcode = true
    end,
    keys = {
      { "<leader>lc", "<cmd>Leet console<cr>", "Letcode Console" },
      { "<leader>lr", "<cmd>Leet run<cr>", "Letcode Run" },
      { "<leader>lC", "<cmd>Leet compile<cr>", "Letcode Compile" },
      { "<leader>ls", "<cmd>Leet submit<cr>", "Letcode Submit" },
      { "<leader>lt", "<cmd>Leet test<cr>", "Letcode Test" },
      { "<leader>lh", "<cmd>Leet hint<cr>", "Letcode Help" },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)
      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      vim.notify = notify
    end,
  },
}
