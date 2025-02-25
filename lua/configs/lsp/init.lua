local merge_tb = vim.tbl_deep_extend

local configs = require "nvchad.configs.lspconfig"
local on_init = configs.on_init
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers_mason = require("configs.overrides").mason.servers

local values = {
  ["html-lsp"] = "html",
  ["css-lsp"] = "cssls",
  ["lua-language-server"] = "lua_ls",
  ["bash-language-server"] = "bashls",
}

local servers = {}

-- Hàm đẩy dữ liệu vào bảng servers
local function populate_servers()
  for _, server in ipairs(servers_mason) do
    -- Nếu server có trong values thì lấy giá trị tương ứng, ngược lại giữ nguyên tên server
    servers[#servers + 1] = values[server] or server
  end
end

-- Gọi hàm để đẩy dữ liệu vào servers
populate_servers()

for _, lsp in ipairs(servers) do
  local opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
  }

  local exists, settings = pcall(require, "configs.lsp.server-settings." .. lsp)
  if exists then
    opts = merge_tb("force", settings, opts)
  end

  lspconfig[lsp].setup(opts)
end

local config = {
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    source = "always",
  },
}

vim.diagnostic.config(config)
