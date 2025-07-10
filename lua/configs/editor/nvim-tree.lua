local icons = require "icons"
return {
  opts = function()
    return {
      filters = { dotfiles = false },
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        side = "right",
        width = 30,
        preserve_window_proportions = true,
        adaptive_size = true,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            default = "󰈚",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
            },
            git = { unmerged = "" },
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 500,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = icons.diagnostics.hint,
          info = icons.diagnostics.info,
          warning = icons.diagnostics.warn,
          error = icons.diagnostics.error,
        },
      },
      actions = {
        open_file = {
          resize_window = false,
        },
      },
    }
  end,
  keys = {
    {
      "<C-n>",
      function()
        require("nvim-tree.api").tree.toggle { focus = true }
      end,
      desc = "Nvimtree Toggle Window",
    },
    {
      "<leader>e",
      function()
        require("nvim-tree.api").tree.focus()
      end,
      desc = "Nvimtree Focus Toggle",
    },
  },
}
