return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      "mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    opts = require("configs.lsp.nvim-lspconfig").opts,
    config = require("configs.lsp.nvim-lspconfig").config,
  },

  -- cmdline tools and lsp servers
  {

    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts_extend = { "ensure_installed" },
    opts = require("configs.lsp.mason").opts,
    config = require("configs.lsp.mason").config,
  },
}
