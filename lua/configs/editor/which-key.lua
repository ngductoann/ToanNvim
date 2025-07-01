return {
  opts = {
    preset = "helix",
    defaults = {},
    spec = {
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>o", group = "overseer" },
        { "<leader>c", group = "code" },
        { "<leader>d", group = "debug" },
        { "<leader>dp", group = "profiler" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        { "<leader>bw", "<cmd>HopWord<cr>", desc = "Hop to Word" },
        { "<leader>bL", "<cmd>HopLine<cr>", desc = "Hop to Line" },
        { "<leader>bc", "<cmd>HopChar1<cr>", desc = "Hop to Char 1" },
        { "<leader>bC", "<cmd>HopChar2<cr>", desc = "Hop to Char 2" },
        { "<leader>bm", "<cmd>HopCamelCase<cr>", desc = "Hop Camel Case" },
        {
          "<leader>w",
          group = "windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "Buffer Keymaps (which-key)",
    },
    {
      "<c-w><space>",
      function()
        require("which-key").show { keys = "<c-w>", loop = true }
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)
    if not vim.tbl_isempty(opts.defaults) then
      utils.warn "which-key: opts.defaults is deprecated. Please use opts.spec instead."
      wk.register(opts.defaults)
    end
  end,
}
