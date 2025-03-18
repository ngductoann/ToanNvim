local lspconfig = require "lspconfig"
local utils = require "utils"

local merge_tb = vim.tbl_deep_extend

local servers = { "html", "cssls", "lua_ls" }

for _, lsp in ipairs(servers) do
  local opts = utils.lsp.otps

  local exists, settings = pcall(require, "configs.lsp.server-settings." .. lsp)
  if exists then
    opts = merge_tb("force", settings, opts)
  end

  lspconfig[lsp].setup(opts)
end
