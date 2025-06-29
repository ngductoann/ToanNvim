local M = {}

function M.setup(opts)
  opts = vim.tbl_extend("force", {
    max_depth = 3,
    max_length = 40,
    separator = "  ",
    show_icons = true,
    icon = vim.trim(require("icons").kinds.Folder),
    ellipsis = "…",
    navic_separator = "  ",
    excluded_ft = {
      "NvimTree",
      "Trouble",
      "alpha",
      "lazy",
      "neo-tree",
      "toggleterm",
    },
  }, opts or {})

  local function should_display()
    return vim.bo.buftype == "" and vim.opt.modifiable:get() and not vim.tbl_contains(opts.excluded_ft, vim.bo.filetype)
  end

  local function shorten_path(path, max_depth, max_length)
    local parts = {}
    for part in path:gmatch "[^/]+" do
      table.insert(parts, part)
    end

    local full_path = table.concat(parts, "/")

    if #parts <= max_depth and #full_path <= max_length then
      return full_path
    end

    if #parts > 1 then
      local filename = table.remove(parts) -- tách file cuối
      local short_parts = {}
      for _, part in ipairs(parts) do
        table.insert(short_parts, part:sub(1, 1))
      end
      table.insert(short_parts, filename)
      return opts.ellipsis .. table.concat(short_parts, "/")
    end

    return opts.ellipsis .. path
  end

  local function get_icon()
    if not opts.show_icons then
      return ""
    end
    return (vim.fn.exists "*WebDevIconsGetFileTypeSymbol" == 1 and vim.fn.WebDevIconsGetFileTypeSymbol() or opts.icon)
      .. " "
  end

  local function update_winbar()
    if not should_display() then
      vim.opt_local.winbar = nil
      return
    end

    local path = vim.fn.expand "%:~:."
    if path == "" then
      path = "[No Name]"
    end
    path = shorten_path(path, opts.max_depth, opts.max_length)

    local navic_location = ""
    local navic_sep = ""

    local navic_status_ok, navic_module = pcall(require, "nvim-navic")
    if navic_status_ok and navic_module.is_available() then
      local location = navic_module.get_location()
      if location and location ~= "" then
        navic_location = location
        navic_sep = opts.navic_separator
      end
    end

    local icon = get_icon()

    vim.schedule(function()
      vim.opt_local.winbar = table.concat({
        icon .. path,
        navic_location,
      }, navic_sep)
    end)
  end

  vim.api.nvim_create_autocmd({
    "BufEnter",
    "DirChanged",
    "CursorMoved",
    "LspAttach",
    "LspDetach",
    "User",
  }, {
    callback = update_winbar,
  })

  update_winbar()
end

return M
