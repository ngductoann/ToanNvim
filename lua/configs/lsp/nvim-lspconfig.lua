local M = {}
M.opts = function()
  ---@class PluginLspOpts
  local ret = {
    underline = true,
    diagnostics = {
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        -- prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        prefix = "icons",
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.HINT] = "H",
            [vim.diagnostic.severity.INFO] = "I",
          },
        },
      },
      severity_sort = true,
    },
    inlay_hints = {
      enabled = true,
      exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
    },
    codelens = {
      enabled = false,
    },
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
    servers = {
      lua_ls = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        -- Use this to add any additional keymaps
        -- for specific lsp servers
        -- ---@type LazyKeysSpec[]
        -- keys = {},
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
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
          },
        },
      },
      cssls = {},
      html = {},
      emmet_ls = {},
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
end

M.config = function(_, opts)
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

  local icon_diagnostics = {
    Error = "E ",
    Warn = "W ",
    Hint = "H ",
    Info = "I ",
  }

  if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
    opts.diagnostics.virtual_text.prefix = vim.fn.has "nvim-0.10.0" == 0 and "●"
      or function(diagnostic)
        local icons = icon_diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end
  end

  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

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
  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
      on_init = function(client, _)
        if client.supports_method "textDocument/semanticTokens" then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,
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
end

return M
