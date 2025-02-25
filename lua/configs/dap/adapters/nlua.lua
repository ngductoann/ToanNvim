local dap = require "dap"

local M = {}

M.nlua = function(callback, conf)
  local adapter = {
    type = "server",
    host = conf.host or "127.0.0.1",
    port = conf.port or 8086,
  }
  if conf.start_neovim then
    local dap_run = dap.run
    dap.run = function(c)
      adapter.port = c.port
      adapter.host = c.host
    end
    require("osv").run_this()
    dap.run = dap_run
  end
  callback(adapter)
end

M.config = {
  {
    type = "nlua",
    request = "attach",
    name = "Run this file",
    start_neovim = {},
  },
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance (port = 8086)",
    port = 8086,
  },
}

return M
