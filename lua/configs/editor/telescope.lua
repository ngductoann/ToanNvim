local build_cmd ---@type string?
for _, cmd in ipairs { "make", "cmake", "gmake" } do
  if vim.fn.executable(cmd) == 1 then
    build_cmd = cmd
    break
  end
end

return {
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = (build_cmd ~= "cmake") and "make"
        or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      enabled = build_cmd ~= nil,
      config = function(plugin)
        utils.on_load("telescope.nvim", function()
          local ok, err = pcall(require("telescope").load_extension, "fzf")
          if not ok then
            local lib = plugin.dir .. "/build/libfzf." .. (utils.is_win() and "dll" or "so")
            if not vim.uv.fs_stat(lib) then
              utils.warn "`telescope-fzf-native.nvim` not built. Rebuilding..."
              require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
                utils.info "Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim."
              end)
            else
              utils.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
            end
          end
        end)
      end,
    },
  },
  keys = {
    {
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>/", utils.pick "live_grep", desc = "Grep (Root Dir)" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader><space>", utils.pick "files", desc = "Find Files (Root Dir)" },
    -- find
    {
      "<leader>fb",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
      desc = "Buffers",
    },
    { "<leader>fc", utils.pick.config_files(), desc = "Find Config File" },
    { "<leader>ff", utils.pick "files", desc = "Find Files (Root Dir)" },
    { "<leader>fF", utils.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>fR", utils.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>sg", utils.pick "live_grep", desc = "Grep (Root Dir)" },
    { "<leader>sG", utils.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
    { "<leader>sw", utils.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
    { "<leader>sW", utils.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
    { "<leader>sw", utils.pick "grep_string", mode = "v", desc = "Selection (Root Dir)" },
    { "<leader>sW", utils.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
    { "<leader>uC", utils.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
  },
  opts = function()
    local actions = require "telescope.actions"

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end
    local find_files_no_ignore = function()
      local action_state = require "telescope.actions.state"
      local line = action_state.get_current_line()
      utils.pick("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require "telescope.actions.state"
      local line = action_state.get_current_line()
      utils.pick("find_files", { hidden = true, default_text = line })()
    end

    local function find_command()
      if 1 == vim.fn.executable "rg" then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable "fd" then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable "fdfind" then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable "find" and vim.fn.has "win32" == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable "where" then
        return { "where", "/r", ".", "*" }
      end
    end

    dofile(vim.g.base46_cache .. "telescope")

    if not utils.has "flash.nvim" then
      return
    end
    local function flash(prompt_bufnr)
      require("flash").jump {
        pattern = "^",
        label = { after = { 0, 0 } },
        search = {
          mode = "search",
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
            end,
          },
        },
        action = function(match)
          local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          picker:set_selection(match.pos[1] - 1)
        end,
      }
    end

    local opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
    }

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
    })

    return opts
  end,
}
