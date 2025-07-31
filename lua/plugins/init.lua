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
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 3000,
      top_down = true,
    },
    config = function(_, opts)
      local base46 = require("nvconfig").base46

      if base46.transparency then
        opts.background_colour = "#000000"
      end

      require("notify").setup(opts)

      vim.notify = require "notify"
    end,
  },
}
