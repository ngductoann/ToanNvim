local M = {}

--- Default configuration options
local DEFAULT_OPTS = {
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
  debounce_delay = 50, -- Add debounce delay in milliseconds
}

--- Check if winbar should be displayed for current buffer
---@param opts table Module options
---@return boolean
local function should_display(opts)
  return vim.bo.buftype == "" and vim.opt.modifiable:get() and not vim.tbl_contains(opts.excluded_ft, vim.bo.filetype)
end

--- Shorten path based on depth and length constraints
---@param path string Original path
---@param max_depth number Maximum directory depth to show
---@param max_length number Maximum total length
---@return string Shortened path
local function shorten_path(path, max_depth, max_length)
  local parts = vim.split(path, "/", { plain = true })
  local full_path = table.concat(parts, "/")

  if #parts <= max_depth and #full_path <= max_length then
    return full_path
  end

  if #parts > 1 then
    local filename = table.remove(parts) -- Remove last part (filename)
    local short_parts = vim.tbl_map(function(part)
      return part:sub(1, 1) -- Shorten each directory to first letter
    end, parts)
    table.insert(short_parts, filename)
    return "…" .. table.concat(short_parts, "/")
  end

  return "…" .. path
end

--- Get appropriate icon for current file
---@param opts table Module options
---@return string
local function get_icon(opts)
  if not opts.show_icons then
    return ""
  end
  if vim.fn.exists "*WebDevIconsGetFileTypeSymbol" == 1 then
    return vim.fn.WebDevIconsGetFileTypeSymbol() .. " "
  end
  return opts.icon .. " "
end

--- Get navic location if available
---@param opts table Module options
---@return string location, string separator
local function get_navic_location(opts)
  local ok, navic = pcall(require, "nvim-navic")
  if not ok or not navic.is_available() then
    return "", ""
  end

  local location = navic.get_location() or ""
  if location == "" then
    return "", ""
  end

  return location, opts.navic_separator
end

--- Update the winbar content
---@param opts table Module options
local function update_winbar(opts)
  if not should_display(opts) then
    vim.opt_local.winbar = nil
    return
  end

  local path = vim.fn.expand "%:~:." or "[No Name]"
  path = shorten_path(path, opts.max_depth, opts.max_length)

  local navic_location, navic_sep = get_navic_location(opts)
  local icon = get_icon(opts)

  vim.opt_local.winbar = table.concat({
    icon .. path,
    navic_location,
  }, navic_sep)
end

--- Setup the winbar module
---@param user_opts? table User configuration options
function M.setup(user_opts)
  local opts = vim.tbl_deep_extend("force", DEFAULT_OPTS, user_opts or {})

  -- Create a debounce timer
  local debounce_timer = nil

  local function debounced_update()
    if debounce_timer then
      debounce_timer:close()
    end
    debounce_timer = vim.defer_fn(function()
      update_winbar(opts)
      debounce_timer = nil
    end, opts.debounce_delay)
  end

  -- Set up autocmds with appropriate groups
  local group = vim.api.nvim_create_augroup("WinbarUpdater", { clear = true })

  -- Events that need debounced updates (cursor movement)
  vim.api.nvim_create_autocmd({
    "CursorMoved",
    "CursorMovedI",
  }, {
    group = group,
    callback = debounced_update,
  })

  -- Events that can be updated immediately
  vim.api.nvim_create_autocmd({
    "BufEnter",
    "BufWinEnter",
    "FileType",
    "LspAttach",
    "LspDetach",
  }, {
    group = group,
    callback = function()
      update_winbar(opts)
    end,
  })

  -- Initial update
  vim.schedule(function()
    update_winbar(opts)
  end)
end

return M
