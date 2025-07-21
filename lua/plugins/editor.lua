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
  { "echasnovski/mini.bufremove", version = false },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
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
    cmd = require("configs.editor.overseer").cmd,
    opts = require("configs.editor.overseer").opts,
    keys = require("configs.editor.overseer").keys,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = require("configs.editor.nvim-tree").opts,
  },

  {
    "RRethy/vim-illuminate",
    event = "User FilePost",
    opts = require("configs.editor.vim-illuminate").opts,
    config = require("configs.editor.vim-illuminate").config,
    keys = require("configs.editor.vim-illuminate").keys,
  },
}
