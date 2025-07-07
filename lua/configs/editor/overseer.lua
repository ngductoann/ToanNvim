return {
  opts = {
    dap = true,
    task_list = {
      bindings = {
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
      },
    },
    form = {
      win_opts = {
        winblend = 0,
      },
    },
    confirm = {
      win_opts = {
        winblend = 0,
      },
    },
    task_win = {
      win_opts = {
        winblend = 0,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>Ow", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
    { "<leader>Oo", "<cmd>OverseerRun<cr>",         desc = "Run task" },
    { "<leader>Oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
    { "<leader>Oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
    { "<leader>Ob", "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
    { "<leader>Ot", "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
    { "<leader>Oc", "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
  },
}
