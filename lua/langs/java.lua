return {
  {
    "nvim-java/nvim-java",
    config = false,
    ft = { "java" },
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            jdtls = {
              -- Your custom jdtls settings goes here
              handlers = {
                -- By assigning an empty function, you can remove the notifications
                -- printed to the cmd
                ["$/progress"] = function(_, result, ctx) end,
              },
            },
          },
          setup = {
            jdtls = function()
              require("java").setup {
                root_markers = {
                  "settings.gradle",
                  "settings.gradle.kts",
                  "pom.xml",
                  "build.gradle",
                  "mvnw",
                  "gradlew",
                  "build.gradle",
                  "build.gradle.kts",
                },
              }
            end,
          },
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "google-java-format" } },
  },
  -- Add java to treesitter.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "java" } },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
      },
      formatters = {
        ["google-java-format"] = {
          prepend_args = { "--aosp" }, -- Ensure 4-space indentation
        },
      },
    },
  },
}
