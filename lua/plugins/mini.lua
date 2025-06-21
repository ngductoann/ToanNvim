return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = require("configs.mini").mini_pairs.opts,
    config = function(_, opts)
      utils.mini.pairs(opts)
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = require("configs.mini").mini_icons.opts,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  { "nvim-tree/nvim-tree.lua", enabled = false },
  {
    "echasnovski/mini.files",
    opts = require("configs.mini").mini_files.opts,
    keys = require("configs.mini").mini_files.keys,
    config = require("configs.mini").mini_files.config,
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = require("configs.mini").mini_ai.opts,
    config = require("configs.mini").mini_ai.config,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = utils.lazy_file_events,
    opts = require("configs.mini").mini_indentscope.opts,
    init = require("configs.mini").mini_indentscope.init,
  },

  {
    "echasnovski/mini.surround",
    keys = require("configs.mini").mini_surround.keys,
    opts = require("configs.mini").mini_surround.opts,
  },
}
