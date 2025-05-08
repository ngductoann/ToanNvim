if _G.langs.php ~= true then
  return {}
end

local lsp = "intelephense"

return {
  recommended = {
    ft = "php",
    root = { "composer.json", ".phpactor.json", ".phpactor.yml" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "php" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        phpactor = {
          enabled = lsp == "phpactor",
        },
        intelephense = {
          enabled = lsp == "intelephense",
        },
        [lsp] = {
          enabled = true,
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "phpcs",
        "php-cs-fixer",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require "dap"
      local path = vim.fn.expand "$MASON/packages/php-debug-adapter"
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { path .. "/extension/out/phpDebug.js" },
      }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        php = { "phpcs" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
      },
    },
  },
}
