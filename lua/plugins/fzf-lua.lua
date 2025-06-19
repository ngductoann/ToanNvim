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

return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    init = function()
      utils.on_very_lazy(function()
        vim.ui.select = function(...)
          require("lazy").load { plugins = { "fzf-lua" } }
          local opts = utils.opts "fzf-lua" or {}
          require("fzf-lua").register_ui_select(opts.ui_select or nil)
          return vim.ui.select(...)
        end
      end)
    end,
    opts = require("configs.fzf-lua").opts,
    config = require("configs.fzf-lua").config,
    keys = require("configs.fzf-lua").keys,
  },
}
