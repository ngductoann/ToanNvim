local dap = require "dap"

-- ui
require "configs.dap.ui"

-- debuggers
local gdb = require "configs.dap.adapters.gdb"
local nlua = require "configs.dap.adapters.nlua"
local codelldb = require "configs.dap.adapters.codelldb"

dap.adapters.gdb = gdb.adapter

dap.configurations.c = gdb.config
dap.configurations.cpp = gdb.config
dap.configurations.rust = gdb.config

dap.adapters.nlua = nlua.nlua
dap.configurations.lua = nlua.config

dap.adapters.codelldb = codelldb.adapters
dap.configurations.c = codelldb.configurations
dap.configurations.cpp = codelldb.configurations
