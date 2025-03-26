local supported = {
  "astro",
  "css",
  "graphql",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "markdown",
  "svelte",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

local formatters_by_ft = {
  lua = { "stylua" },
  java = { "google-java-format" },
}

for _, ft in ipairs(supported) do
  formatters_by_ft[ft] = formatters_by_ft[ft] or {}
  table.insert(formatters_by_ft[ft], "biome")
end

return {
  { "williamboman/mason.nvim", opts = { ensure_installed = { "biome" } } },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = formatters_by_ft,

      formatters = {
        ["google-java-format"] = {
          prepend_args = { "--aosp" }, -- Ensure 4-space indentation
        },
      },

      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
