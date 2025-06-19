return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    -- opts = {
    --   manual_mode = true,
    -- },
    config = require("configs.project_nvim").config,
  },
}
