require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove { "r", "o" }
  end,
})
