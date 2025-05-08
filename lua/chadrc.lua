---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "solarized_dark",

  integrations = {},
  changed_themes = {},
  transparency = false,
  theme_toggle = { "solarized_dark", "one_light" },

  hl_override = {
    -- Comment = { italic = true },
    -- ["@comment"] = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  cmp = {
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      lsp = true,
    },
  },

  telescope = { style = "borderless" }, -- borderless / bordered
  tabufline = {
    lazyload = false,
  },
  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },
}

return M
