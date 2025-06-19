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
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          },
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" }, -- function
          c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" }, -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = utils.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call { name_pattern = "[%w_]" }, -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      utils.on_load("which-key.nvim", function()
        vim.schedule(function()
          utils.mini.ai_whichkey(opts)
        end)
      end)
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
}
