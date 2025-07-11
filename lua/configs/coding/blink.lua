-- local menu_cols = { { "kind_icon" }, { "label" }, { "kind" } }
--
-- local components = {
--   kind_icon = {
--     text = function(ctx)
--       local icons = require("icons").kinds
--       local icon = (icons[ctx.kind] or "󰈚")
--
--       return vim.trim(icon)
--     end,
--   },
--
--   kind = {
--     highlight = function(ctx)
--       return ctx.kind
--     end,
--   },
-- }
--
-- local menu = {
--   scrollbar = false,
--   border = "single", -- can be 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
--   draw = {
--     padding = { 1, 1 },
--     columns = menu_cols,
--     components = components,
--   },
-- }

-- Chỉ hiển thị text (label) và kind dưới dạng chữ
local menu_cols = {
  { "label" }, -- tên gợi ý (abbr)
  { "kind" }, -- loại: Function, Variable...
}

local components = {
  kind = {
    text = function(ctx)
      return ctx.kind or "" -- hiển thị text như "Function", "Variable"
    end,
    highlight = function(ctx)
      return ctx.kind
    end,
  },
}

local menu = {
  scrollbar = false,
  border = "single",
  draw = {
    padding = { 1, 1 },
    columns = menu_cols,
    components = components,
  },
}

return {
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = {
      expand = function(snippet, _)
        return utils.cmp.expand(snippet)
      end,
    },
    appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = true,
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "normal",
    },
    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      menu = menu,
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },

    -- experimental signature help support
    signature = { enabled = false },

    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {},
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
        },
      },
    },

    cmdline = {
      enabled = false,
    },

    keymap = {
      preset = "enter",
      ["<CR>"] = { "accept", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-y>"] = { "select_and_accept" },
    },
  },
  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    -- setup compat sources
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    -- add ai_accept to <Tab> key
    if not opts.keymap["<Tab>"] then
      if opts.keymap.preset == "super-tab" then -- super-tab
        opts.keymap["<Tab>"] = {
          require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
          utils.cmp.map { "snippet_forward", "ai_accept" },
          "fallback",
        }
      else -- other presets
        opts.keymap["<Tab>"] = {
          utils.cmp.map { "snippet_forward", "ai_accept" },
          "fallback",
        }
      end
    end

    -- Unset custom prop to pass blink.cmp validation
    opts.sources.compat = nil

    require("blink.cmp").setup(opts)
  end,
}
