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
    "RRethy/base16-nvim",
    event = "VeryLazy",
    config = function()
      -- To disable highlights for supported plugin(s), call the `with_config` function **before** setting the colorscheme.
      -- These are the defaults.
      require("base16-colorscheme").with_config {
        -- telescope = true,
        indentblankline = true,
        notify = true,
        -- ts_rainbow = true,
        cmp = true,
        illuminate = true,
        dapui = true,
      }
    end,
  },
}
