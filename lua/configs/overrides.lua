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
    "go",
    "gomod",
    "gowork",
    "gosum",
    "json5",
    "java",
    "git_config",
    "gitcommit",
    "git_rebase",
    "gitignore",
    "gitattributes",
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
    "lua_ls",

    -- web dev stuff
    "cssls",
    "html",
    "vtsls",

    -- C / C++
    "clangd",
    "cmake",

    -- java
    "jdtls",

    -- shell
    "bashls",

    -- python
    "pyright",

    --go
    "gopls",

    -- markdown
    "marksman",

    -- other
    "jsonls",
    "yamlls",
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
    "debugpy",
    "isort",

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
    "cmakelint",

    -- java
    "java-debug-adapter",
    "java-test",
    "google-java-format",

    -- Web
    "deno",
    "js-debug-adapter",

    -- markdown
    "markdownlint-cli2",
    "markdown-toc",
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

M.cmp = {
  formatting = {
    format = function(entry, vim_item)
      local icons = require "nvchad.icons.lspkind"
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        luasnip = "[Luasnip]",
        nvim_lsp = "[Nvim LSP]",
        buffer = "[Buffer]",
        nvim_lua = "[Nvim Lua]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = require("cmp").mapping.preset.insert {
    ["<Tab>"] = require("cmp").mapping.select_next_item(),
    ["<S-Tab>"] = require("cmp").mapping.select_prev_item(),
    ["<C-Space>"] = require("cmp").mapping.complete(),
  },
}

return M
