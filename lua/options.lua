require "nvchad.options"

-- add yours here!

local opt = vim.opt
-- o.cursorlineopt ='both' -- to enable cursorline!

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99

opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.smoothscroll = true
opt.foldexpr = "v:lua.require'util'.ui.foldexpr()"
opt.foldmethod = "expr"
opt.foldtext = ""
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.relativenumber = true -- Relative line numbers
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
