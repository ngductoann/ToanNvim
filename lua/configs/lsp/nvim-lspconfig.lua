return {
  opts = function()
    ---@class PluginLspOpts
    local ret = {
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },

      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      servers = {
        lua_ls = {
          settings = {
            Lua = {
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.fn.expand "$VIMRUNTIME/lua",
                  vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                  vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                  "${3rd}/luv/library",
                },
              },
            },
          },
        },
      },

      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    }
    return ret
  end,
  ---@param opts PluginLspOpts
  config = function(_, opts)
    -- setup keymaps
    utils.lsp.on_attach(function(client, buffer)
      require("plugins.lsp.keymaps").on_attach(client, buffer)
    end)

    utils.lsp.setup()
    utils.lsp.on_dynamic_capability(require("plugins.lsp.keymaps").on_attach)

    -- inlay hints
    if opts.inlay_hints.enabled then
      utils.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
        if
          vim.api.nvim_buf_is_valid(buffer)
          and vim.bo[buffer].buftype == ""
          and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end
      end)
    end

    -- code lens
    if opts.codelens.enabled and vim.lsp.codelens then
      utils.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end)
    end

    dofile(vim.g.base46_cache .. "lsp")
    require("nvchad.lsp").diagnostic_config()

    local servers = opts.servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    local on_init = function(client, _)
      if client.supports_method "textDocument/semanticTokens" then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end

    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
        on_init = on_init,
      }, servers[server] or {})
      if server_opts.enabled == false then
        return
      end

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end

    -- get all the servers that are available through mason-lspconfig
    local have_mason, mlsp = pcall(require, "mason-lspconfig")
    local all_mslp_servers = {}
    if have_mason then
      all_mslp_servers = vim.tbl_keys(require("mason-lspconfig").get_mappings().lspconfig_to_package)
    end

    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.enabled ~= false then
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end
    end

    if have_mason then
      mlsp.setup {
        ensure_installed = vim.tbl_deep_extend(
          "force",
          ensure_installed,
          utils.opts("mason-lspconfig.nvim").ensure_installed or {}
        ),
        handlers = { setup },
      }
    end

    if utils.lsp.is_enabled "denols" and utils.lsp.is_enabled "vtsls" then
      local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
      utils.lsp.disable("vtsls", is_deno)
      utils.lsp.disable("denols", function(root_dir, config)
        if not is_deno(root_dir) then
          config.settings.deno.enable = false
        end
        return false
      end)
    end
  end,
}
