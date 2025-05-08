local utils = require "utils"

return {
  recommended = function()
    return utils.extras.wants {
      ft = "dockerfile",
      root = { "Dockerfile", "docker-compose.yml", "compose.yml", "docker-compose.yaml", "compose.yaml" },
    }
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "dockerfile" } },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "hadolint" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {},
      },
    },
  },
}
