return {
  recommended = function()
    return utils.extras.wants {
      ft = "toml",
      root = "*.toml",
    }
  end,
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      taplo = {},
    },
  },
}
