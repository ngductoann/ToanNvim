local M = {}
M.opts = {
  indent = { scope = { char = "╎" } },
  input = { enabled = true },
  image = { enabled = false },
  notifier = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = false }, -- we set this in options.lua
  toggle = { map = utils.safe_keymap_set },
  words = { enabled = true },
  dashboard = { enabled = false },
  picker = {
    win = {
      input = {
        keys = {
          ["<a-c>"] = {
            "toggle_cwd",
            mode = { "n", "i" },
          },
        },
      },
    },
    actions = {
      ---@param p snacks.Picker
      toggle_cwd = function(p)
        local root = utils.root { buf = p.input.filter.current_buf, normalize = true }
        local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
        local current = p:cwd()
        p:set_cwd(current == root and cwd or root)
        p:find()
      end,
    },
  },
}

    -- stylua: ignore
M.keys = {
  { "<leader>n", function()
    if Snacks.config.picker and Snacks.config.picker.enabled then
      Snacks.picker.notifications()
    else
      Snacks.notifier.show_history()
    end
  end, desc = "Notification History" },
  { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
  { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
  { "<leader>/", utils.pick("grep"), desc = "Grep (Root Dir)" },
  { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
  { "<leader><space>", utils.pick("files"), desc = "Find Files (Root Dir)" },
  { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
  -- -- find
  -- { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
  -- { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
  -- { "<leader>fc", utils.pick.config_files(), desc = "Find Config File" },
  -- { "<leader>ff", utils.pick("files"), desc = "Find Files (Root Dir)" },
  -- { "<leader>fF", utils.pick("files", { root = false }), desc = "Find Files (cwd)" },
  -- { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
  -- { "<leader>fr", utils.pick("oldfiles"), desc = "Recent" },
  -- { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)" },
  -- { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
  -- git
  { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
  { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
  { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
  { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
  { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
  { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
  { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
  { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
  { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
  -- -- Grep
  -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
  -- { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
  -- { "<leader>sg", utils.pick("live_grep"), desc = "Grep (Root Dir)" },
  -- { "<leader>sG", utils.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
  -- { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
  -- { "<leader>sw", utils.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
  -- { "<leader>sW", utils.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
  -- search
  { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
  { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
  { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
  { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
  { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
  { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
  { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
  { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
  { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
  { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
  { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
  { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
  { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
  { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
  { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
  { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
  { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
  { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
  -- ui
  { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
}

return M
