require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- Disable comment on new line
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = vim.api.nvim_create_augroup("General", { clear = true }),
  desc = "Disable New Line Comment",
})
