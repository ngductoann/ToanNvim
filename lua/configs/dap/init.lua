local dap = require "dap"

-- ui
require "configs.dap.ui"

-- debuggers
local gdb = require "configs.dap.adapters.gdb"
local nlua = require "configs.dap.adapters.nlua"
local codelldb = require "configs.dap.adapters.codelldb"
local node = require "configs.dap.adapters.node"
local java = require "configs.dap.adapters.java"

dap.adapters.gdb = gdb.adapter

dap.configurations.c = gdb.config
dap.configurations.cpp = gdb.config
dap.configurations.rust = gdb.config

dap.adapters.nlua = nlua.nlua
dap.configurations.lua = nlua.config

dap.adapters.codelldb = codelldb.adapters
dap.configurations.c = codelldb.configurations
dap.configurations.cpp = codelldb.configurations
dap.configurations.java = java.configurations

if not dap.adapters["pwa-node"] then
  require("dap").adapters["pwa-node"] = node["pwa-node"]
end
if not dap.adapters["node"] then
  dap.adapters["node"] = node["node"]
end

local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

local vscode = require "dap.ext.vscode"
vscode.type_to_filetypes["node"] = js_filetypes
vscode.type_to_filetypes["pwa-node"] = js_filetypes

for _, language in ipairs(js_filetypes) do
  if not dap.configurations[language] then
    dap.configurations[language] = node.configurations
  end
end
