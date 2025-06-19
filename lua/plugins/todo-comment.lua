return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = utils.lazy_file_events,
  opts = {},
  keys = require("configs.todo-comments").keys,
}
