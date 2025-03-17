local utils = require "utils"

return {
  handlers = {
    ["textDocument/definition"] = function(...)
      return require("omnisharp_extended").handler(...)
    end,
  },
  keys = {
    {
      "gd",
      utils.has "telescope.nvim" and function()
        require("omnisharp_extended").telescope_lsp_definitions()
      end or function()
        require("omnisharp_extended").lsp_definitions()
      end,
      desc = "Goto Definition",
    },
  },
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
}
