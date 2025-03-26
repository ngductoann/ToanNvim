local utils = require "utils"

vim.g.ai_cmp = true

-- Return a table containing plugin configurations
return {
  -- CopilotChat plugin configuration
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main", -- Use the main branch
    cmd = "CopilotChat", -- Command to trigger the plugin
    opts = function()
      local user = vim.env.USER or "User" -- Get the current user
      user = user:sub(1, 1):upper() .. user:sub(2) -- Capitalize the first letter
      return {
        auto_insert_mode = true, -- Automatically enter insert mode
        question_header = "  " .. user .. " ", -- Header for user questions
        answer_header = "  Copilot ", -- Header for Copilot answers
        window = {
          width = 0.4, -- Set window width
        },
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle() -- Toggle CopilotChat
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset() -- Reset CopilotChat
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ", -- Prompt for quick chat
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input) -- Ask CopilotChat with input
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt() -- Select a prompt
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ar",
        function()
          require("CopilotChat").reset() -- Reset the chat
        end,
        desc = "Reset Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ad",
        "<cmd>CopilotChatDocs<cr>", -- generated documentation
        desc = "Generated Documentation",
        mode = { "n", "v" },
      },
      {
        "<leader>ae",
        "<cmd>CopilotChatExplain<cr>",
        desc = "Generated Explanation",
        mode = { "n", "v" },
      },
      {
        "<leader>af",
        "<cmd>CopilotChatFix<cr>",
        desc = "Generated Fix code",
        mode = { "n", "v" },
      },
      {
        "<leader>at",
        "<cmd>CopilotChatTests<cr>",
        desc = "Generated Tests",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        "<cmd>CopilotChatOptimize<cr>",
        desc = "Generated Optimize code",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        "<cmd>CopilotChatCommit<cr>",
        desc = "Generated Commit message",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require "CopilotChat"

      -- Disable line numbers in CopilotChat buffer
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts) -- Setup CopilotChat with options
    end,
  },
  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  vim.g.ai_cmp
      and {
        -- copilot cmp source
        {
          "hrsh7th/nvim-cmp",
          dependencies = { -- this will only be evaluated if nvim-cmp is enabled
            {
              "zbirenbaum/copilot-cmp",
              opts = {},
              config = function(_, opts)
                local copilot_cmp = require "copilot_cmp"
                copilot_cmp.setup(opts)
                -- attach cmp source whenever copilot attaches
                -- fixes lazy-loading issues with the copilot cmp source
                utils.on_attach(function()
                  copilot_cmp._on_insert_enter {}
                end, "copilot")
              end,
              specs = {
                {
                  "hrsh7th/nvim-cmp",
                  ---@param opts cmp.ConfigSchema
                  opts = function(_, opts)
                    table.insert(opts.sources, 1, {
                      name = "copilot",
                      group_index = 1,
                      priority = 100,
                    })
                    local cmp = require "cmp"

                    local has_words_before = function()
                      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
                        return false
                      end
                      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                      return col ~= 0
                        and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
                    end

                    cmp.setup {
                      mapping = {
                        ["<Tab>"] = vim.schedule_wrap(function(fallback)
                          if cmp.visible() and has_words_before() then
                            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                          else
                            fallback()
                          end
                        end),
                      },
                    }
                  end,
                },
              },
            },
          },
        },
      }
    or nil,
}
