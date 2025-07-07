return {
  { "nvim-telescope/telescope.nvim", enabled = false, optional = true },

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
    "s1n7ax/nvim-window-picker",
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
    "SmiteshP/nvim-navic",
    lazy = true,
    init = require("configs.editor.navic").init,
    opts = require("configs.editor.navic").opts,
  },

  {
    "nvim-tree/nvim-tree.lua",
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
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    opts = require("configs.editor.overseer").opts,
    keys = require("configs.editor.overseer").keys,
  },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "RRethy/vim-illuminate",
    event = utils.lazy_file_events,
    opts = require("configs.editor.vim-illuminate").opts,
    config = require("configs.editor.vim-illuminate").config,
    keys = require("configs.editor.vim-illuminate").keys,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    cond = function()
      local buf_path = vim.api.nvim_buf_get_name(0)
      local home = "/home/toan"
      local vault_path = home .. "/d/take-note/Obsidian/Personal/"
      return buf_path:find(vault_path, 1, true)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = require("configs.editor.obsidian-nvim").opts,
    config = require("configs.editor.obsidian-nvim").config,
  },
}
