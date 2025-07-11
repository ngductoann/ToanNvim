local mini_config = require "configs.mini"

return {
  {
    "echasnovski/mini.basics",
    lazy = false,
    version = false,
    opts = mini_config.mini_basics.opts,
  },

  {
    "echasnovski/mini.notify",
    version = false,
    config = function()
      require("mini.notify").setup {
        lsp_progress = {
          enable = false,
        },
        content = {
          -- Use notification message as is
          format = function(notif)
            return notif.msg
          end,
        },
        window = {
          config = {
            border = "rounded",
          },
        },
      }
      -- Use mini.notify for general notification
      vim.notify = MiniNotify.make_notify()
    end,
  },

  {
    "echasnovski/mini.move",
    lazy = false,
    version = false,
  },

  {
    "echasnovski/mini.comment",
    lazy = false,
    version = false,
    opts = mini_config.mini_comment.opts,
  },

  {
    "echasnovski/mini.icons",
    event = "VeryLazy",
    version = false,
    init = mini_config.mini_icons.init,
    opts = mini_config.mini_icons.opts,
  },

  {
    "echasnovski/mini.tabline",
    event = "VeryLazy",
    version = false,
    opts = mini_config.mini_tabline.opts,
  },

  {
    "echasnovski/mini.statusline",
    version = false,
    dependencies = {
      {
        "echasnovski/mini.diff",
        -- cond = utils.has_git,
        version = false,
        opts = mini_config.mini_diff.opts,
      },

      {
        "echasnovski/mini-git",
        -- cond = utils.has_git,
        version = false,
      },
    },
    event = "VeryLazy",
    opts = mini_config.mini_statusline.opts,
  },

  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    version = false,
    opts = mini_config.mini_animate.opts,
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    version = false,
    opts = mini_config.mini_pairs.opts,
    config = mini_config.mini_pairs.config,
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    version = false,
    opts = mini_config.mini_ai.opts,
    config = mini_config.mini_ai.config,
  },

  {
    "echasnovski/mini.hipatterns",
    version = false,
    event = utils.lazy_file_events,
    opts = mini_config.mini_hipatterns.opts,
    config = mini_config.mini_hipatterns.config,
  },

  {
    "echasnovski/mini.starter",
    version = false,
    event = "VimEnter",
    opts = mini_config.mini_starter.opts,
    config = mini_config.mini_starter.config,
  },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = utils.lazy_file_events,
    init = mini_config.mini_indentscope.init,
    opts = mini_config.mini_indentscope.opts,
  },

  {
    "echasnovski/mini.surround",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    opts = mini_config.mini_surround.opts,
    keys = mini_config.mini_surround.keys,
  },
}
