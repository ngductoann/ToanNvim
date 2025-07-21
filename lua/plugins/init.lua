return {
  {
    "RRethy/base16-nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("base16-colorscheme").with_config {
        telescope = false,
        indentblankline = true,
        notify = true,
        ts_rainbow = false,
        cmp = false,
        illuminate = true,
        dapui = true,
      }

      vim.cmd.colorscheme "base16-onedark-dark"
    end,
  },

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
}
