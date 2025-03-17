local utils = require "utils"
local servers = { "neocmake" }

return {
  recommended = function()
    return utils.wants {
      ft = "cmake",
      root = { "CMakePresets.json", "CTestConfig.cmake", "cmake" },
    }
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cmake" } },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.cmake_lint,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        cmake = { "cmakelint" },
      },
    },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "cmakelang", "cmakelint" } },
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
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    init = function()
      local loaded = false
      local function check()
        local cwd = vim.uv.cwd()
        if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
          require("lazy").load { plugins = { "cmake-tools.nvim" } }
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          if not loaded then
            check()
          end
        end,
      })
    end,
    opts = {},
  },
}
