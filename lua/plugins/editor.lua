local picker = {
  name = "fzf",
  commands = {
    files = "files",
  },

  open = function(command, opts)
    opts = opts or {}
    if opts.cmd == nil and command == "git_files" and opts.show_untracked then
      opts.cmd = "git ls-files --exclude-standard --cached --others"
    end
    return require("fzf-lua")[command](opts)
  end,
}
if not utils.pick.register(picker) then
  return {}
end

return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },

  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    init = require("configs.editor.fzf-lua").init,
    opts = require("configs.editor.fzf-lua").opts,
    config = require("configs.editor.fzf-lua").config,
    keys = require("configs.editor.fzf-lua").keys,
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

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    "lewis6991/gitsigns.nvim",
    opts = require("configs.editor.gitsign").opts,
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
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gD", "<cmd>DiffviewFileHistory %<CR>", desc = "Diff File" },
      { "<leader>gv", "<cmd>DiffviewOpen<CR>", desc = "Diff View" },
    },
    opts = function()
      local actions = require "diffview.actions"
      vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
        group = vim.api.nvim_create_augroup("rafi.diffview", {}),
        pattern = "diffview:///panels/*",
        callback = function()
          vim.opt_local.cursorline = true
          vim.opt_local.winhighlight = "CursorLine:WildMenu"
        end,
      })

      return {
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        keymaps = {
          view = {
            { "n", "q", actions.close },
            { "n", "<Tab>", actions.select_next_entry },
            { "n", "<S-Tab>", actions.select_prev_entry },
            { "n", "<localleader>a", actions.focus_files },
            { "n", "<localleader>e", actions.toggle_files },
          },
          file_panel = {
            { "n", "q", actions.close },
            { "n", "h", actions.prev_entry },
            { "n", "o", actions.focus_entry },
            { "n", "gf", actions.goto_file },
            { "n", "sg", actions.goto_file_split },
            { "n", "st", actions.goto_file_tab },
            { "n", "<C-r>", actions.refresh_files },
            { "n", "<localleader>e", actions.toggle_files },
          },
          file_history_panel = {
            { "n", "q", "<cmd>DiffviewClose<CR>" },
            { "n", "o", actions.focus_entry },
            { "n", "O", actions.options },
          },
        },
      }
    end,
  },
}
