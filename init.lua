vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.ai_cmp = true -- enable AI completion by default

-- bootstrap plugins & lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- path where its going to be installed

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

_G.utils = require "utils"

require("lazy").setup({
  { import = "plugins" },
  { import = "langs" },
}, require "lazy_config")

require "options"
require "commands"

vim.schedule(function()
  require "mappings"
  require("configs.winbar").setup()
end)

vim.cmd [[colorscheme base16-brewer]]
