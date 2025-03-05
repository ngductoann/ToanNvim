local merge_tb = vim.tbl_deep_extend
local map = vim.keymap.set

local M = {}
local status_navic, navic = pcall(require, "nvim-navic")
local status_navbuddy, navbuddy = pcall(require, "nvim-navbuddy")

M.default_on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "gy", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>cgD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "<leader>cgd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "<leader>cgi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>cgy", vim.lsp.buf.type_definition, opts "Go to type definition")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
  map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, opts "Run Codelens")
  map({ "n", "v" }, "<leader>cC", vim.lsp.codelens.refresh, opts "Refresh Codelens")
  map({ "n", "v" }, "]]", function()
    Snacks.words.jump(vim.v.count1)
  end, opts "Next references")
  map({ "n", "v" }, "[[", function()
    Snacks.words.jump(-vim.v.count1)
  end, opts "Prev references")
  map("n", "<leader>cR", require "nvchad.lsp.renamer", opts "NvRenamer")

  if status_navic then
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end
end

local configs = require "nvchad.configs.lspconfig"
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = require("configs.overrides").mason.servers

local not_navbuddy = {
  "tailwindcss",
  "emmet_language_server",
  "ruff",
}

local function not_in_list(str, list)
  for _, value in ipairs(list) do
    if str == value then
      return false
    end
  end
  return true
end

for _, lsp in ipairs(servers) do
  local on_attach

  if not_in_list(lsp, not_navbuddy) and status_navbuddy then
    on_attach = function(client, bufnr)
      M.default_on_attach(client, bufnr)
      navbuddy.attach(client, bufnr)
    end
  else
    on_attach = M.default_on_attach
  end

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

return M
