local mini_config = require "configs.mini"

return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = { "VeryLazy", "VimEnter", "BufReadPost", "BufNewFile", "BufWritePre" },
    init = function()
      require("configs.mini").mini_icons.init()
      require("configs.mini").mini_indentscope.init()
    end,
    config = function()
      require("mini.basics").setup(mini_config.mini_basics.opts)
      require("mini.icons").setup(mini_config.mini_icons.opts)

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

      require("mini.git").setup()
      require("mini.move").setup()
      require("mini.diff").setup(mini_config.mini_diff.opts)
      require("mini.statusline").setup(mini_config.mini_statusline.opts)
      require("mini.starter").setup(mini_config.mini_starter.opts())
      require("mini.comment").setup(mini_config.mini_comment.opts)
      require("mini.tabline").setup(mini_config.mini_tabline.opts)
      require("mini.indentscope").setup(mini_config.mini_indentscope.opts)
      require("mini.surround").setup(mini_config.mini_surround.opts)
      mini_config.mini_hipatterns.config(mini_config.mini_hipatterns.opts())
      mini_config.mini_pairs.config(mini_config.mini_pairs.opts)
      mini_config.mini_ai.config(mini_config.mini_ai.opts())

      vim.cmd.colorscheme "minicyan"
    end,
    keys = function()
      local closeOtherBuffers = function()
        local current = vim.api.nvim_get_current_buf()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and buf ~= current then
            vim.schedule(function()
              if pcall(require, "mini.bufremove") then
                require("mini.bufremove").delete(buf, false)
              else
                vim.cmd("bd " .. buf)
              end
            end)
          end
        end
      end

      -- stylua: ignore
      local keys = {
        { "<leader>bo", function () closeOtherBuffers() end, desc = "Delete Orther Buffer" },
        { "<leader>bd", function () require("mini.bufremove").delete() end, desc = "Delete Buffer" },
        {
          "<leader>go",
          function()
            require("mini.diff").toggle_overlay(0)
          end,
          desc = "Toggle mini.diff overlay",
        },

      }
      local opts = mini_config.mini_surround.opts
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
  },
}
