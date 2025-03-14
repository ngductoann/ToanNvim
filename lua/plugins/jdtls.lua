local status_mason, _ = pcall(require, "mason")
local status_dap, _ = pcall(require, "nvim-dap")

local java_filetypes = { "java" }

-- Utility function to extend or override a config table, similar to the way
-- that Plugin.opts works.
---@param config table
---@param custom function | table | nil
local function extend_or_override(config, custom, ...)
  if type(custom) == "function" then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
  end
  return config
end

local function get_raw_config(server)
  local ok, ret = pcall(require, "lspconfig.configs." .. server)
  if ok then
    return ret
  end
  return require("lspconfig.server_configurations." .. server)
end

return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    ft = java_filetypes,
    opts = function()
      local cmd = { vim.fn.exepath "jdtls" }
      local mason_registry = require "mason-registry"
      local lombok_jar = mason_registry.get_package("jdtls"):get_install_path() .. "/lombok.jar"
      table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))

      return {
        root_dir = get_raw_config("jdtls").default_config.root_dir,

        -- How to find the project name for a given root dir.
        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,

        -- Where are the config and workspace dirs for a project?
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath "cache" .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath "cache" .. "/jdtls/" .. project_name .. "/workspace"
        end,

        cmd = cmd,
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local cmd = vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(cmd, {
              "-configuration",
              opts.jdtls_config_dir(project_name),
              "-data",
              opts.jdtls_workspace_dir(project_name),
            })
          end
          return cmd
        end,

        dap = { hotcodereplace = "auto", config_overrides = {} },
        -- Can set this to false to disable main class scan, which is a performance killer for large project
        dap_main = {},
        test = true,
        settings = {
          java = {
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
          },
        },
      }
    end,

    config = function(_, opts)
      local bundles = {} ---@type string[]

      if status_mason then
        local mason_registry = require "mason-registry"
        if opts.dap and status_dap and mason_registry.is_installed "java-debug-adapter" then
          local java_dbg_pkg = mason_registry.get_package "java-debug-adapter"
          local java_dbg_path = java_dbg_pkg:get_install_path()
          local jar_patterns = {
            java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
          }
          -- java-test also depends on java-debug-adapter.
          if opts.test and mason_registry.is_installed "java-test" then
            local java_test_pkg = mason_registry.get_package "java-test"
            local java_test_path = java_test_pkg:get_install_path()
            vim.list_extend(jar_patterns, {
              java_test_path .. "/extension/server/*.jar",
            })
          end
          for _, jar_pattern in ipairs(jar_patterns) do
            for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
              table.insert(bundles, bundle)
            end
          end
        end

        local function attach_jdtls()
          local fname = vim.api.nvim_buf_get_name(0)

          local configs = require "nvchad.configs.lspconfig"
          local capabilities = configs.capabilities

          -- Configuration can be augmented and overridden by opts.jdtls
          local config = extend_or_override({

            cmd = opts.full_cmd(opts),
            root_dir = opts.root_dir(fname),
            init_options = {
              bundles = bundles,
            },
            settings = opts.settings,
            -- enable CMP capabilities
            capabilities = capabilities,
          }, opts.jdtls)

          -- Existing server will be reused if the root_dir matches.
          require("jdtls").start_or_attach(config)
          -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
        end

        vim.api.nvim_create_autocmd("FileType", {
          pattern = java_filetypes,
          callback = attach_jdtls,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "jdtls" then
              local wk = require "which-key"
              wk.add {
                {
                  mode = "n",
                  buffer = args.buf,
                  { "<leader>cx", group = "extract" },
                  { "<leader>cxv", require("jdtls").extract_variable_all, desc = "Extract Variable" },
                  { "<leader>cxc", require("jdtls").extract_constant, desc = "Extract Constant" },
                  { "<leader>cgs", require("jdtls").super_implementation, desc = "Goto Super" },
                  { "<leader>cgS", require("jdtls.tests").goto_subjects, desc = "Goto Subjects" },
                  { "<leader>co", require("jdtls").organize_imports, desc = "Organize Imports" },
                },
              }
              wk.add {
                {
                  mode = "v",
                  buffer = args.buf,
                  { "<leader>cx", group = "extract" },
                  {
                    "<leader>cxm",
                    [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
                    desc = "Extract Method",
                  },
                  {
                    "<leader>cxv",
                    [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
                    desc = "Extract Variable",
                  },
                  {
                    "<leader>cxc",
                    [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
                    desc = "Extract Constant",
                  },
                },
              }

              if status_mason then
                if opts.dap and status_dap and mason_registry.is_installed "java-debug-adapter" then
                  -- custom init for Java debugger
                  require("jdtls").setup_dap(opts.dap)
                  if opts.dap_main then
                    require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)
                  end

                  -- Java Test require Java debugger to work
                  if opts.test and mason_registry.is_installed "java-test" then
                    -- custom keymaps for Java test runner (not yet compatible with neotest)
                    wk.add {
                      {
                        mode = "n",
                        buffer = args.buf,
                        { "<leader>t", group = "test" },
                        {
                          "<leader>tt",
                          function()
                            require("jdtls.dap").test_class {
                              config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides or nil,
                            }
                          end,
                          desc = "Run All Test",
                        },
                        {
                          "<leader>tr",
                          function()
                            require("jdtls.dap").test_nearest_method {
                              config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides or nil,
                            }
                          end,
                          desc = "Run Nearest Test",
                        },
                        { "<leader>tT", require("jdtls.dap").pick_test, desc = "Run Test" },
                      },
                    }
                  end
                end
              end

              -- User can set additional keymaps in opts.on_attach
              if opts.on_attach then
                opts.on_attach(args)
              end
            end
          end,
        })

        attach_jdtls()
      end
    end,
  },
}
