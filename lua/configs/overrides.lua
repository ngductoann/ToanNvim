local M = {}

M.treesitter = {
  ensure_installed = {
    "lua",
    "css",
    "bash",
    "c",
    "cpp",
    "diff",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "printf",
    "python",
    "query",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    "ninja",
    "rst",
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
    },
  },
}

M.mason = {
  servers = {
    -- lua stuff
    "lua-language-server",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "vtsls",

    -- C / C++
    "clangd",

    -- shell
    "bash-language-server",

    -- python
    "pyright",

    --go
    "gopls",
  },
  others = {
    -- Lua
    "stylua",
    "luacheck",

    -- go
    "delve",
    "go-debug-adapter",
    "gofumpt",
    "goimports",
    "goimports-reviser",
    "golangci-lint",
    "golangci-lint-langserver",
    "golines",
    "gomodifytags",

    -- python
    "ruff",
    "black",

    -- shell
    "shellcheck",
    "bash-debug-adapter",
    "awk-language-server",

    -- C/C++
    "clang-format",
    "cmake-language-server",
    "cpplint",
    "codelldb",
    "cpptools",

    -- Web
    "deno",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.ui = {
  tabufline = {
    lazyload = false,
    overriden_modules = nil,
  },
}

return M
