return {
  opts = function(_, opts)
    local nls = require "null-ls"
    opts.root_dir = opts.root_dir
      or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.fish_indent,
      nls.builtins.diagnostics.fish,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.shfmt,
      nls.builtins.code_actions.gitsigns,
      -- nls.builtins.completion.luasnip,
      nls.builtins.diagnostics.codespell
    })
  end,
}
