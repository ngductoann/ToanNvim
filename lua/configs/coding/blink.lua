local M = {}

local menu_cols = { { "label" }, { "kind_icon" }, { "kind" } }

local components = {
  kind_icon = {
    text = function(ctx)
      local icons = {
        Namespace = "󰌗",
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰆧",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󱓻",
        File = "󰈚",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
        Table = "",
        Object = "󰅩",
        Tag = "",
        Array = "[]",
        Boolean = "",
        Number = "",
        Null = "󰟢",
        Supermaven = "",
        String = "󰉿",
        Calendar = "",
        Watch = "󰥔",
        Package = "",
        Copilot = "",
        Codeium = "",
        TabNine = "",
        BladeNav = "",
      }
      local icon = (icons[ctx.kind] or "󰈚")

      return icon
    end,
  },

  kind = {
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

M.opts = {
  snippets = {
    preset = "luasnip",
    expand = function(snippet, _)
      return utils.cmp.expand(snippet)
    end,
  },

  appearance = {
    -- sets the fallback highlight groups to nvim-cmp's highlight groups
    -- useful for when your theme doesn't support blink.cmp
    -- will be removed in a future release, assuming themes add support
    use_nvim_cmp_as_default = false,
    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = "normal",
  },

  fuzzy = { implementation = "prefer_rust" },

  completion = {
    accept = {
      -- experimental auto-brackets support
      auto_brackets = {
        enabled = true,
      },
    },
    -- menu = require("nvchad.blink").menu,
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = vim.g.ai_cmp,
    },
    menu = menu,
  },

  -- experimental signature help support
  -- signature = { enabled = true },

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
    ["<C-y>"] = { "select_and_accept" },
  },
}
M.config = function(_, opts)
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
end

return M
