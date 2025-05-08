if _G.langs.javascript ~= true then
  return {}
end
local utils = require "utils"

return {
  recommended = function()
    return utils.extras.wants {
      ft = "prisma",
    }
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "prisma" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        prismals = {},
      },
    },
  },
}
