local utils = require "utils"
local servers = { "jsonls", "taplo" }

return {
  recommended = function()
    return utils.wants {
      ft = { "json", "jsonc", "json5" },
      root = { "*.json" },
    }
  end,
  -- add json to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json5" } },
  },

  -- yaml schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  -- correctly setup lspconfig
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
}
