require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local opt = vim.opt

opt.autowrite = true -- Enable auto write
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = "-",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.smoothscroll = true
opt.foldtext = ""
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.o.splitbelow = true
vim.o.splitright = true

local augroup = vim.api.nvim_create_augroup("utils.fold", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method "textDocument/foldingRange" then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
      vim.w.lsp_folding_enabled = true
    end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "bigfile" and not vim.w.lsp_folding_enabled then
      local has_parser, _ = pcall(vim.treesitter.get_parser, args.buf)
      if has_parser then
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
    end
  end,
})
