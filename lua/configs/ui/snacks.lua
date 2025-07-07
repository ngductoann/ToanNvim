return {
  opts = {
    bigfile = { enabled = true },
    indent = {
      scope = {
        char = "╎",
      },
    },
    input = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    toggle = { map = utils.safe_keymap_set },
    words = { enabled = true },
    explorer = { enabled = false },
    quickfile = { enabled = true },
    -- dashboard = {
    --   preset = {
    --     pick = function(cmd, opts)
    --       return utils.pick(cmd, opts)()
    --     end,
    --     -- stylua: ignore
    --     ---@type snacks.dashboard.Item[]
    --     keys = {
    --       { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
    --       { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
    --       { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
    --       { icon = " ", key = "p", desc = "Projects", action = require("configs.editor.projects").pick },
    --       { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
    --       { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
    --       { icon = " ", key = "s", desc = "Restore Session", section = "session" },
    --       { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
    --       { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
    --       { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    --     },
    --   },
    -- },
  },
  config = function(_, opts)
    local notify = vim.notify
    require("snacks").setup(opts)
    -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
    -- this is needed to have early notifications show up in noice history
    if utils.has "noice.nvim" then
      vim.notify = notify
    end
  end,
  -- stylua: ignore
  keys = {
    {
      "<leader>n",
      function()
        if Snacks.config.picker and Snacks.config.picker.enabled then
          Snacks.picker.notifications()
        else
          Snacks.notifier.show_history()
        end
      end,
      desc = "Notification History",
    },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffers" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    -- git
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    -- { "<leader>gg", function() Snacks.lazygit({ cwd = utils.root.git() }) end, desc =  "Lazygit (Root Dir)" },
    -- { "<leader>gG", function() Snacks.lazygit() end, desc =  "Lazygit (cwd)" },
    { "<leader>gb", function() Snacks.picker.git_log_line() end, desc =  "Git Blame Line" },
    { "<leader>gf", function() Snacks.picker.git_log_line() end, desc =  "Git Current File History" },
    { "<leader>gL", function() Snacks.picker.git_log() end, desc =  "Git Log" },
    -- search
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
    { "<leader>fT", function() Snacks.terminal() end,  desc = "Terminal (cwd)" },
    { "<leader>ft", function() Snacks.terminal(nil, { cwd = utils.root() }) end, desc = "Terminal (Root Dir)"},
    { "<c-/>", function() Snacks.terminal(nil, { cwd = utils.root() }) end, desc = "Terminal (Root Dir)"},
    { "<c-_>", function() Snacks.terminal(nil, { cwd = utils.root() }) end, desc = "which_key_ignore" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
        Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
        Snacks.toggle.diagnostics():map "<leader>ud"
        Snacks.toggle.line_number():map "<leader>ul"
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
          :map "<leader>uc"
        Snacks.toggle
          .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
          :map "<leader>uA"
        Snacks.toggle.treesitter():map "<leader>uT"
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
        Snacks.toggle.dim():map "<leader>uD"
        Snacks.toggle.animate():map "<leader>ua"
        Snacks.toggle.indent():map "<leader>ug"
        Snacks.toggle.scroll():map "<leader>uS"
        Snacks.toggle.profiler():map "<leader>dpp"
        Snacks.toggle.profiler_highlights():map "<leader>dph"
        Snacks.toggle({
          name = "Mini Pairs",
          get = function()
            return not vim.g.minipairs_disable
          end,
          set = function(state)
            vim.g.minipairs_disable = not state
          end,
        }):map "<leader>up"

        Snacks.toggle({
          name = "Git Signs",
          get = function()
            return require("gitsigns.config").config.signcolumn
          end,
          set = function(state)
            require("gitsigns").toggle_signs(state)
          end,
        }):map "<leader>uG"

        if vim.lsp.inlay_hint then
          Snacks.toggle.inlay_hints():map "<leader>uh"
        end
      end,
    })
  end,
}
