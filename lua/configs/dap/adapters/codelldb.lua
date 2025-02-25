local M = {}

M.adapter = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = {
      "--port",
      "${port}",
    },
  },
}

M.configurations = {
  {
    type = "codelldb",
    request = "launch",
    name = "Launch file",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
  },
  {
    type = "codelldb",
    request = "attach",
    name = "Attach to process",
    pid = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}

return M
