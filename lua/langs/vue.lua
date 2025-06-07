if not _G.langs.javascript then
  return {}
end

local utils = require "utils"

return {
  recommended = function()
    return utils.extras.wants {
      ft = "vue",
      root = { "vue.config.js" },
    }
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vue", "css" } },
  },

  -- Add LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },
        vtsls = {},
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      table.insert(opts.servers.vtsls.filetypes, "vue")

      -- Use your own utility to get the vue-language-server plugin path
      local vue_plugin_path = require("utils").get_pkg_path("vue-language-server", "/node_modules/@vue/language-server")

      -- Add the vue plugin to the globalPlugins
      opts.servers.vtsls.settings = opts.servers.vtsls.settings or {}
      opts.servers.vtsls.settings.tsserver = opts.servers.vtsls.settings.tsserver or {}
      opts.servers.vtsls.settings.tsserver.globalPlugins = opts.servers.vtsls.settings.tsserver.globalPlugins or {}

      table.insert(opts.servers.vtsls.settings.tsserver.globalPlugins, {
        name = "@vue/typescript-plugin",
        location = vue_plugin_path,
        languages = { "vue" },
        configNamespace = "typescript",
        enableForWorkspaceTypeScriptVersions = true,
      })
    end,
  },
}
