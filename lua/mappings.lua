-- require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Themes switch
map("n", "<C-t>", function()
  require("nvchad.themes").open()
end)

map("n", "<leader>e", function()
  Snacks.explorer.open()
end, { desc = "nvimtree focus window" })

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- Move
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- fotmat
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- tabufline
map("n", "<Leader>bc", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Close buffer" })

map("n", "<Leader>bD", function()
  require("nvchad.tabufline").closeAllBufs(true)
end, { desc = "closes all buffers ignore current" })

map("n", "<Leader>bd", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "closes all buffers" })

map("n", "<leader>bn", function()
  require("nvchad.tabufline").move_buf(1)
end, { desc = "move next" })

map("n", "<leader>bp", function()
  require("nvchad.tabufline").move_buf(-1)
end, { desc = "move previous" })

map("n", "<leader>bb", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- toggle options
Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
Snacks.toggle.diagnostics():map "<leader>ud"
Snacks.toggle.line_number():map "<leader>ul"
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
  :map "<leader>uc"
Snacks.toggle
  .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
  :map "<leader>uA"
Snacks.toggle.treesitter():map "<leader>uT"
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
Snacks.toggle.dim():map "<leader>uD"
Snacks.toggle.animate():map "<leader>ua"
Snacks.toggle.indent():map "<leader>ug"
Snacks.toggle.scroll():map "<leader>uS"
Snacks.toggle.profiler():map "<leader>dpp"
Snacks.toggle.profiler_highlights():map "<leader>dph"

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map "<leader>uh"
end

local function opts(desc)
  return { buffer = bufnr, desc = "LSP " .. desc }
end

map("n", "gi", function()
  Snacks.picker.lsp_implementations()
end, opts "Go to implementation")

map("n", "<leader>ch", vim.lsp.buf.signature_help, opts "Show signature help")
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts "List workspace folders")

map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
map("n", "<leader>cr", require "nvchad.lsp.renamer", opts "NvRenamer")
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")

map("n", "gr", function()
  Snacks.picker.lsp_references()
end, opts "Show references")

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })
