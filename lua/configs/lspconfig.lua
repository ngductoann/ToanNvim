-- require("nvchad.configs.lspconfig").defaults()

local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
-- stylua: ignore
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gd",  function() Snacks.picker.lsp_definitions() end, opts "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gr", function() Snacks.picker.lsp_references() end, opts "References")
  map("n", "gI", function() Snacks.picker.lsp_implementations() end, opts "Goto Implementation")
  map("n", "gy",  function() Snacks.picker.lsp_type_definitions() end, opts "Goto T[y]pe Definition")

  map("n","K", function() return vim.lsp.buf.hover() end, opts "Hover")
  map("n","gK", function() return vim.lsp.buf.signature_help() end, opts "Signature Help")
  map("i", "<c-k>", function() return vim.lsp.buf.signature_help() end, opts "Signature Help")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Goto type definition")
  map("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>cwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts "List workspace folders")
  map("n", "<leader>cr", require "nvchad.lsp.renamer", opts "NvRenamer")
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code Action")
  map("n", "<leader>cc", vim.lsp.codelens.run, opts "Run Codelens")
  map("n", "<leader>cC", vim.lsp.codelens.refresh, opts "Refesh & Display Codelens")
  map("n", "<leader>cR", function() Snacks.rename.rename_file() end, opts "Rename file")

  map("n", "]]", function() Snacks.words.jump(vim.v.count1) end, opts "Next Reference")
  map("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, opts "Prev Reference")

  map("n", "<a-n>", function() Snacks.words.jump(vim.v.count1) end, opts "Next Reference")
  map("n", "<a-p>", function() Snacks.words.jump(-vim.v.count1) end, opts "Prev Reference")
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
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

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      M.on_attach(_, args.buf)
    end,
  })

  local lua_lsp_settings = {
    Lua = {
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  }

  -- Support 0.10 temporarily

  if vim.lsp.config then
    vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init })
    vim.lsp.config("lua_ls", { settings = lua_lsp_settings })
    vim.lsp.enable "lua_ls"
  else
    require("lspconfig").lua_ls.setup {
      capabilities = M.capabilities,
      on_init = M.on_init,
      settings = lua_lsp_settings,
    }
  end
end

M.defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
