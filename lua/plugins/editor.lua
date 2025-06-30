return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    init = require("configs.editor.fzf-lua").init,
    opts = require("configs.editor.fzf-lua").opts,
    config = require("configs.editor.fzf-lua").config,
    keys = require("configs.editor.fzf-lua").keys,
  },

  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = require("configs.editor.grug-far").keys,
  },

  -- Flash enhances the built-in search functionality by showing labels
  -- at the end of each match, letting you quickly jump to a specific
  -- location.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = require("configs.editor.flash").opts,
    keys = require("configs.editor.flash").keys,
  },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = require("configs.editor.which-key").opts,
    config = require("configs.editor.which-key").config,
    keys = require("configs.editor.which-key").keys,
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = require("configs.editor.trouble").opts,
    keys = require("configs.editor.trouble").keys,
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = utils.lazy_file_events,
    opts = require("configs.editor.todo-comments").opts,
    keys = require("configs.editor.todo-comments").keys,
  },

  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },

  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = require("configs.editor.projects").opts,
    config = require("configs.editor.projects").config,
  },

  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    opts = require("configs.editor.kulala").opts,
    keys = require("configs.editor.kulala").keys,
  },

  {
    "stevearc/aerial.nvim",
    event = utils.lazy_file_events,
    opts = require("configs.editor.aerial").opts,
    keys = require("configs.editor.aerial").keys,
  },

  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    opts = require("configs.editor.nvim-window-picker").opts,
    keys = require("configs.editor.nvim-window-picker").keys,
  },

  {
    "smoka7/hop.nvim",
    cmd = { "HopWord", "HopLine", "HopChar1", "HopChar2", "HopCamelCase" },
    version = "*",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },

  {
    "stevearc/oil.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "SirZenith/oil-vcs-status" },
      {
        "JezerM/oil-lsp-diagnostics.nvim",
        dependencies = { "stevearc/oil.nvim" },
        opts = {},
      },
    },
    opts = require("configs.editor.oil").opts,
    config = require("configs.editor.oil").config,
    keys = require("configs.editor.oil").keys,
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = require("configs.editor.navic").init,
    opts = require("configs.editor.navic").opts,
  },

  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require("configs.editor.nvim-tree").opts,
    keys = require("configs.editor.nvim-tree").keys,
  },

  {
    "hasansujon786/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = require("configs.editor.nav-buddy").opts,
    config = require("configs.editor.nav-buddy").config,
    keys = require("configs.editor.nav-buddy").keys,
  },

  {
    "echasnovski/mini.hipatterns",
    event = utils.lazy_file_events,
    opts = require("configs.editor.mini-hipatterns").opts,
    config = require("configs.editor.mini-hipatterns").config,
  },

  {
    "nvim-focus/focus.nvim",
    version = false,
    cmd = "FocusToggle",
    keys = {
      {
        "<leader>uf",
        "<cmd>FocusToggle<cr>",
        desc = "Focus Toggle",
      },
    },
    opts = {
      enable = true, -- Enable module
      commands = true, -- Create Focus commands
      autoresize = {
        enable = true, -- Enable or disable auto-resizing of splits
        width = 0, -- Force width for the focused window
        height = 0, -- Force height for the focused window
        minwidth = 0, -- Force minimum width for the unfocused window
        minheight = 0, -- Force minimum height for the unfocused window
        focusedwindow_minwidth = 0, --Force minimum width for the focused window
        focusedwindow_minheight = 0, --Force minimum height for the focused window
        height_quickfix = 10, -- Set the height of quickfix panel
      },
      split = {
        bufnew = false, -- Create blank buffer for new split windows
        tmux = false, -- Create tmux splits instead of neovim splits
      },
      ui = {
        number = false, -- Display line numbers in the focussed window only
        relativenumber = false, -- Display relative line numbers in the focussed window only
        hybridnumber = false, -- Display hybrid line numbers in the focussed window only
        absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

        cursorline = true, -- Display a cursorline in the focussed window only
        cursorcolumn = false, -- Display cursorcolumn in the focussed window only
        colorcolumn = {
          enable = false, -- Display colorcolumn in the foccused window only
          list = "+1", -- Set the comma-saperated list for the colorcolumn
        },
        signcolumn = true, -- Display signcolumn in the focussed window only
        winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
      },
    },
  },
}
