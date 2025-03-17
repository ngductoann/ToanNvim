return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath "config" .. "/snippets" } }
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "petertriho/cmp-git", opts = {} },
      { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
    },
    ---@module 'cmp'
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      table.insert(opts.sources, { name = "git" })

      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    event = "VeryLazy",
    keys = {
      {
        "<leader>cn",
        function()
          require("neogen").generate { snippet_engine = "luasnip" }
        end,
        desc = "Generate Annotations (Neogen)",
      },
    },
    opts = function(_, opts)
      if opts.snippet_engine ~= nil then
        return
      end

      local map = {
        ["LuaSnip"] = "luasnip",
        ["mini.snippets"] = "mini",
        ["nvim-snippy"] = "snippy",
        ["vim-vsnip"] = "vsnip",
      }

      for plugin, engine in pairs(map) do
        local status, _ = pcall(require, plugin)
        if status then
          opts.snippet_engine = engine
          return
        end
      end

      if vim.snippet then
        opts.snippet_engine = "nvim"
      end
    end,
  },
}
