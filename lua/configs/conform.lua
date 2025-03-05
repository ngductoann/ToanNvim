local supported_prettier = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

--- Checks if a Prettier config file exists for the given context
---@param ctx ConformCtx
function has_config(ctx)
  vim.fn.system { "prettier", "--find-config-path", ctx.filename }
  return vim.v.shell_error == 0
end

--- Checks if a parser can be inferred for the given context:
--- * If the filetype is in the supported list, return true
--- * Otherwise, check if a parser can be inferred
---@param ctx ConformCtx
function has_parser(ctx)
  local ft = vim.bo[ctx.buf].filetype --[[@as string]]
  -- default filetypes are always supported
  if vim.tbl_contains(supported_prettier, ft) then
    return true
  end
  -- otherwise, check if a parser can be inferred
  local ret = vim.fn.system { "prettier", "--file-info", ctx.filename }
  ---@type boolean, string?
  local ok, parser = pcall(function()
    return vim.fn.json_decode(ret).inferredParser
  end)
  return ok and parser and parser ~= vim.NIL
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    c_cpp = { "clang-format" }, -- Hack to force download.
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "goimports", "gofumpt" },
    ["markdown-toc"] = {
      condition = function(_, ctx)
        for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
          if line:find "<!%-%- toc %-%->" then
            return true
          end
        end
      end,
    },
    ["markdownlint-cli2"] = {
      condition = function(_, ctx)
        local diag = vim.tbl_filter(function(d)
          return d.source == "markdownlint"
        end, vim.diagnostic.get(ctx.buf))
        return #diag > 0
      end,
    },
    python = { "isort", "black" },
    java = { "google-java-format" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    ["clang-format"] = {
      prepend_args = {
        "-style={ \
                IndentWidth: 4, \
                TabWidth: 4, \
                UseTab: Never, \
                AccessModifierOffset: 0, \
                IndentAccessModifiers: true, \
                PackConstructorInitializers: Never}",
      },
    },
    ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
    ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
    ["google-java-format"] = {
      prepend_args = { "--aosp" },
    },
  },
  black = {
    prepend_args = {
      "--fast",
      "--line-length",
      "80",
    },
  },
  isort = {
    prepend_args = {
      "--profile",
      "black",
    },
  },
}

for _, ft in ipairs(supported_prettier) do
  options.formatters_by_ft[ft] = options.formatters_by_ft[ft] or {}
  table.insert(options.formatters_by_ft[ft], "prettier")
end

options.formatters.prettier = {
  condition = function(_, ctx)
    return has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or has_config(ctx))
  end,
}

return options
