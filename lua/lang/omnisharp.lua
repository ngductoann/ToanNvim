if _G.lang.csharp == false then
  return {}
end

local utils = require "utils"
local servers = { "omnisharp" }

return {
  recommended = function()
    return utils.wants {
      ft = { "cs", "vb" },
      root = { "*.sln", "*.csproj", "omnisharp.json", "function.json" },
    }
  end,

  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "csharpier", "netcoredbg" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local configs = require "nvchad.configs.lspconfig"
      local lspconfig = require "lspconfig"

      local merge_tb = vim.tbl_deep_extend

      local on_init = configs.on_init
      local capabilities = configs.capabilities
      local on_attach = configs.on_attach

      for _, lsp in ipairs(servers) do
        local opts = {
          on_init = on_init,
          on_attach = on_attach,
          capabilities = capabilities,
        }

        local exists, settings = pcall(require, "lang.server-settings." .. lsp)
        if exists then
          opts = merge_tb("force", settings, opts)
        end

        lspconfig[lsp].setup(opts)
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require "dap"
      if not dap.adapters["netcoredbg"] then
        require("dap").adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath "netcoredbg",
          args = { "--interpreter=vscode" },
          options = {
            detached = false,
          },
        }
      end
      for _, lang in ipairs { "cs", "fsharp", "vb" } do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "Launch file",
              request = "launch",
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          -- Here we can set options for neotest-dotnet
        },
      },
    },
  },
}
