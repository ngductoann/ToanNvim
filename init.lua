vim.g.mapleader = ","

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

_G.utils = require "utils"

-- load plugins
require("lazy").setup({
  { import = "plugins" },
  { import = "langs" },
}, lazy_config)


require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
  require("configs.winbar").setup()
  vim.cmd [[colorscheme base16-irblack]]
end)
