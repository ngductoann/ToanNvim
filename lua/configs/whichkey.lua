return {
  preset = "helix",
  defaults = {},
  spec = {
    mode = { "n", "v" },
    {
      { "<BS>", desc = "Decrement Selection", mode = "x" },
      { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
      {
        "<leader>b",
        group = "buffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      { "<leader>c", group = "code" },
      { "<leader>cg", group = "defination" },
      { "<leader>ct", group = "test" },
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>t", group = "terminal" },
      { "<leader>u", group = "utils" },
      { "<leader>w", group = "workspaces+windows" },
      {
        "<leader>wp",
        function()
          require("window-picker").pick_window()
        end,
        desc = "Window picker",
      },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gs", group = "surround" },
      { "z", group = "fold" },
      { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
      { "<leader>j", group = "jump" },
      { "<leader>jj", "<cmd>HopWord<cr>", desc = "Jump Word" },
      { "<leader>jw", "<cmd>HopWordCurrentLine<cr>", desc = "Jump Word" },
      { "<leader>jl", "<cmd>HopLine<cr>", desc = "Jump Line" },
      { "<leader>jc", "<cmd>HopCamelCase<cr>", desc = "Camel Case" },
    },
  },
}
