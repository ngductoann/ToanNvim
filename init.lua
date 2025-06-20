vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
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
_G.utils.lsp = require "utils.lsp"
_G.utils.root = require "utils.root"
_G.utils.cmp = require "utils.cmp"
_G.utils.pick = require "utils.pick"
_G.ai = true

_G.langs = {
  python = true,
  clang = true,
  cmake = true,
  javascript = true,
  java = true,
  go = true,
  csharp = false,
  rust = false,
  sql = false,
}

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
  { import = "langs" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
dofile(vim.g.base46_cache .. "blink")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
