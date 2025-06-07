local utils = require "utils"

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    cond = vim.g.neovide == nil,
    opts = {
      hide_target_hack = true,
      cursor_color = "none",
    },
    specs = {
      -- disable mini.animate cursor
      {
        "echasnovski/mini.animate",
        optional = true,
        opts = {
          cursor = { enable = false },
        },
      },
    },
  },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = false,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>sn", "", desc = "+noice"},
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd [[messages clear]]
      end
      require("noice").setup(opts)
    end,
  },

  -- ui components
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { map = utils.safe_keymap_set },
      words = { enabled = true },
      explorer = { enabled = false },
      picker = { enabled = true },
      dashboard = {
        preset = {
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
    -- stylua: ignore
     keys = {
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files", },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers", },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History", },
      { "<leader>n", function()
          if Snacks.config.picker and Snacks.config.picker.enabled then
            Snacks.picker.notifications()
          else
            Snacks.notifier.show_history()
          end
        end,
        desc = "Notification History",
      },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers", },
      { "<leader>fB", function()
          Snacks.picker.buffers { hidden = true, nofile = true }
        end,
        desc = "Buffers (all)",
      },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)", },
      { "<leader>fR", function() Snacks.picker.recent { filter = { cwd = true } } end, desc = "Recent (cwd)", },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects", },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches", },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log", },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line", },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status", },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash", },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)", },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File", },
      -- Grep
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec", },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines", },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers", },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep", },
      { "<leader>sw", function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers", },
      { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History", },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds", },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines", },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History", },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands", },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics", },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics", },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages", },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights", },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons", },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps", },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps", },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List", },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks", },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages", },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec", },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List", },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume", },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History", },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes", },
      -- Other
      { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode", },
      { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom", },
      { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer", },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer", },
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History", },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Buffer", },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" }, },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit", },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
      { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal", },
      { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore", },
      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" }, },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" }, },
      { "<leader>N", desc = "Neovim News",
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          }
        end,
      },
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
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map "<leader>uc"
          Snacks.toggle.treesitter():map "<leader>uT"
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
          Snacks.toggle.inlay_hints():map "<leader>uh"
          Snacks.toggle.indent():map "<leader>ug"
          Snacks.toggle.dim():map "<leader>uD"
        end,
      })
    end,
  },

  -- icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- Show context of the current function
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = utils.lazy_file_events,
    opts = function()
      local tsc = require "treesitter-context"
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map "<leader>ut"
      return { mode = "cursor", max_lines = 3 }
    end,
  },
}
