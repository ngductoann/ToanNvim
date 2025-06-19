vim.filetype.add {
  extension = {
    ["http"] = "http",
  },
}
return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = require("configs.kulala").keys,
    opts = {},
  },
}
