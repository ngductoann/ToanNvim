local servers = { "nil_ls" }

return {
  recommended = {
    ft = "nix",
    root = "flake.nix",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "nix" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local lspconfig = require "lspconfig"
      local merge_tb = vim.tbl_deep_extend

      for _, lsp in ipairs(servers) do
        local opts = {}

        local exists, settings = pcall(require, "lang.server-settings." .. lsp)
        if exists then
          opts = merge_tb("force", settings, opts)
        end

        lspconfig[lsp].setup(opts)
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
    },
  },
}
