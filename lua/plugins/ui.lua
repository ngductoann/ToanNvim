return {
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require("configs.ui.noice").opts,
    config = require("configs.ui.noice").config,
    keys = require("configs.ui.noice").keys,
  },

  -- icons
  {
    "echasnovski/mini.icons",
    -- lazy = true,
    event = "VeryLazy",
    init = require("configs.ui.mini_icons").init,
    opts = require("configs.ui.mini_icons").opts,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    opts = {
      scope = { enabled = false },
    },
  },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = utils.lazy_file_events,
    opts = {
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "Trouble",
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "mason",
          "neo-tree",
          "notify",
          "snacks_dashboard",
          "snacks_notif",
          "snacks_terminal",
          "snacks_win",
          "toggleterm",
          "trouble",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "SnacksDashboardOpened",
        callback = function(data)
          vim.b[data.buf].miniindentscope_disable = true
        end,
      })
    end,
  },

  -- {
  --   "echasnovski/mini.statusline",
  --   version = false,
  --   event = "VeryLazy",
  --   opts = require("configs.ui.mini_statusline").opts,
  -- },
  --
  -- {
  --   "echasnovski/mini.tabline",
  --   version = false,
  --   event = "VeryLazy",
  --   opts = require("configs.ui.mini_tabline").opts,
  -- },
  --
  -- -- snacks
  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   init = require("configs.ui.snacks").init,
  --   opts = require("configs.ui.snacks").opts,
  --   config = require("configs.ui.snacks").config,
  --   keys = require("configs.ui.snacks").keys,
  -- },
}
