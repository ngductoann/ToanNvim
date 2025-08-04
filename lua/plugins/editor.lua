------@type LazyPicker
---local picker = {
---  name = "telescope",
---  commands = {
---    files = "find_files",
---  },
---  -- this will return a function that calls telescope.
---  -- cwd will default to lazyvim.util.get_root
---  -- for `files`, git_files or find_files will be chosen depending on .git
---  ---@param builtin string
---  ---@param opts? lazyvim.util.pick.Opts
---  open = function(builtin, opts)
---    opts = opts or {}
---    opts.follow = opts.follow ~= false
---    if opts.cwd and opts.cwd ~= vim.uv.cwd() then
---      local function open_cwd_dir()
---        local action_state = require "telescope.actions.state"
---        local line = action_state.get_current_line()
---        utils.pick.open(
---          builtin,
---          vim.tbl_deep_extend("force", {}, opts or {}, {
---            root = false,
---            default_text = line,
---          })
---        )
---      end
---      ---@diagnostic disable-next-line: inject-field
---      opts.attach_mappings = function(_, map)
---        -- opts.desc is overridden by telescope, until it's changed there is this fix
---        map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd Directory" })
---        return true
---      end
---    end
---
---    require("telescope.builtin")[builtin](opts)
---  end,
---}
---if not utils.pick.register(picker) then
---  return {}
---end

if lazyvim_docs then
  -- In case you don't want to use `:LazyExtras`,
  -- then you need to set the option below.
  vim.g.lazyvim_picker = "fzf"
end

---@class FzfLuaOpts: lazyvim.util.pick.Opts
---@field cmd string?

---@type LazyPicker
local picker = {
  name = "fzf",
  commands = {
    files = "files",
  },

  ---@param command string
  ---@param opts? FzfLuaOpts
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

local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = utils.config.get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = require("configs.editor.fzflua").opts,
    config = require("configs.editor.fzflua").config,
    keys = require("configs.editor.fzflua").keys,
  },

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   cmd = "Telescope",
  --   version = false, -- telescope did only one release, so use HEAD for now
  --   dependencies = require("configs.editor.telescope").dependencies,
  --   opts = require("configs.editor.telescope").opts,
  --   keys = require("configs.editor.telescope").keys,
  -- },
  --
  -- {
  --   "stevearc/dressing.nvim",
  --   lazy = true,
  --   init = function()
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.ui.select = function(...)
  --       require("lazy").load { plugins = { "dressing.nvim" } }
  --       return vim.ui.select(...)
  --     end
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.ui.input = function(...)
  --       require("lazy").load { plugins = { "dressing.nvim" } }
  --       return vim.ui.input(...)
  --     end
  --   end,
  -- },

  -- {
  --   "RRethy/vim-illuminate",
  --   event = utils.lazy_file_events,
  --   opts = require("configs.editor.vim-illuminate").opts,
  --   config = require("configs.editor.vim-illuminate").config,
  --   keys = require("configs.editor.vim-illuminate").keys,
  -- },

  -- Flash enhances the built-in search functionality by showing labels
  -- at the end of each match, letting you quickly jump to a specific
  -- location.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
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
}
