if _G.lang.prisma ~= true then
  return {}
end
local utils_extras = require "utils.extras"

return {
  recommended = function()
    return utils_extras.wants {
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
