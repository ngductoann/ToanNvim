return {
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/d/take-note/Obsidian/Personal/",
        overrides = {
          notes_subdir = "notes",
        },
      },
    },
    notes_subdir = "notes",
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "notes/dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
    ui = {
      enable = true, -- set to false to disable all additional syntax features
      update_debounce = 200, -- update delay after a text change (in milliseconds)
      max_file_length = 5000, -- disable UI features for files with more than this many lines
      -- Define how various check-boxes are displayed
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
        [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        ["x"] = { char = "✔", hl_group = "ObsidianDone" },

        -- You can also add more custom ones...
      },
      -- Use bullet marks for non-checkbox lists.
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      -- Replace the above with this if you don't have a patched font:
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
        ObsidianTilde = { bold = true, fg = "#ff5370" },
        ObsidianImportant = { bold = true, fg = "#d73128" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },
  },
  config = function(_, opts)
    local obsidian = require "obsidian"

    obsidian.setup(opts)

    vim.keymap.set("n", "<leader>Oc", obsidian.util.toggle_checkbox, { desc = "Obsidian Toggle Checkbox" })
    vim.keymap.set("n", "<leader>Oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
    vim.keymap.set("n", "<leader>Ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show Obsidian Backlinks" })
    vim.keymap.set("n", "<leader>Ol", "<cmd>ObsidianLinks<CR>", { desc = "Show Obsidian Links" })
    vim.keymap.set("n", "<leader>On", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
    vim.keymap.set("n", "<leader>Os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
    vim.keymap.set("n", "<leader>Oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })
    vim.keymap.set("n", "<leader>Op", "<cmd>ObsidianPasteImg<CR>", { desc = "Paste Image" })
    vim.keymap.set("n", "<leader>Odd", ":!rm '%:p'<CR>:bd<CR>", { desc = "Delete File", silent = true })

    -- Inserts template and formats first title by removing date and file name chars
    vim.keymap.set("n", "<leader>Ot", function()
      vim.cmd "ObsidianTemplate note"
      local LINE_NUM = 13
      local line = vim.fn.getline(LINE_NUM)
      local title = line:match "# (.*)"

      if title then
        title = title:gsub("_%d%d%d%d%-%d%d%-%d%d$", "")
        title = title:gsub("[_%-]", " ")
        title = title:gsub("%s+$", "")
        vim.fn.setline(LINE_NUM, "# " .. title)
      end

      vim.cmd "noh"
    end, { desc = "Insert Template" })
  end,
}
