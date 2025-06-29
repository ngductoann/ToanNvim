local icons = require "icons"

return {
  opts = function()
    local icons_kind = icons.kinds

    -- HACK: fix lua's weird choice for `Package` for control
    -- structures like if/else/for/etc.
    icons_kind.lua = { Package = icons_kind.Control }

    ---@type table<string, string[]>|false
    local filter_kind = false
    if icons.kind_filter then
      filter_kind = assert(vim.deepcopy(icons.kind_filter))
      filter_kind._ = filter_kind.default
      filter_kind.default = nil
    end

    local opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      show_guides = true,
      layout = {
        resize_to_content = false,
        win_opts = {
          winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
          signcolumn = "yes",
          statuscolumn = " ",
        },
      },
      icons = icons_kind,
      filter_kind = filter_kind,
        -- stylua: ignore
        guides = {
          mid_item   = "├╴",
          last_item  = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        },
    }

    utils.on_load("telescope.nvim", function()
      require("telescope").load_extension "aerial"
    end)

    return opts
  end,
  keys = {
    { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
  },
}
