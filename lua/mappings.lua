-- require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })
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

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- telescope
map("n", "<leader>:", "<cmd>Telescope command_history<CR>", { desc = "command_history" })
map("n", "<leader>,", "<cmd>Telescope buffers<CR>", { desc = "buffers" })
map("n", "<leader>ct", "<cmd>Telescope terms<CR>", { desc = "pick hidden term" })

-- find
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "find files" })
map("n", "<leader>fb", "<cmd>Telescope buffer<cr>", { desc = "find buffer" })
map("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "find git files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- search
map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "live grep" })
map("n", "<leader>sm", "<cmd>Telescope marks<CR>", { desc = "find marks" })
map("n", '<leader>s"', "<cmd>Telescope registers<CR>", { desc = "registers" })
map("n", "<leader>s/", "<cmd>Telescope search_history<CR>", { desc = "search history" })
map("n", "<leader>sa", "<cmd>Telescope autocommands<CR>", { desc = "autocmds" })
map("n", "<leader>sc", "<cmd>Telescope command_history<CR>", { desc = "command_history" })
map("n", "<leader>sC", "<cmd>Telescope commands<CR>", { desc = "commands" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "help page" })
map("n", "<leader>sH", "<cmd>Telescope highlights<CR>", { desc = "highlights" })
map("n", "<leader>sj", "<cmd>Telescope jumplist<CR>", { desc = "jumplist" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "keymaps" })
map("n", "<leader>sl", "<cmd>Telescope loclist<CR>", { desc = "location list" })
map("n", "<leader>sM", "<cmd>Telescope man_pages<CR>", { desc = "man pages" })
map("n", "<leader>sq", "<cmd>Telescope quickfix<CR>", { desc = "quickfix" })
map("n", "<leader>sR", "<cmd>Telescope resume<CR>", { desc = "resume" })
map("n", "<leader>sB", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "find in current buffer" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "find oldfiles" })

-- git
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "git commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "git status" })
map("n", "<leader>gS", "<cmd>Telescope git_stash<CR>", { desc = "git status" })

-- lsp
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Goto Definition" })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
map("n", "gI", "<cmd>Telescope lsp_implementations<CR>", { desc = "Goto Implementations" })
map("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Goto Type Definition" })

map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

map("n", "uk", "<cmd>Screenkey<CR>", { desc = "Screenkey toggle" })

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

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- Themes switch
map("n", "<C-t>", function()
  require("nvchad.themes").open()
end)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local function opts(desc)
  return { buffer = bufnr, desc = "LSP " .. desc }
end

map("n", "K", function()
  return vim.lsp.buf.hover()
end, opts "Hover")

map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, opts "Run Codelens")
map({ "n" }, "<leader>cC", vim.lsp.codelens.refresh, opts "Refresh & Display Codelens")
map({ "n" }, "<leader>cR", function()
  Snacks.rename.rename_file()
end, opts "Rename File")

map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts "List workspace folders")

map("n", "<leader>cr", require "nvchad.lsp.renamer", opts "NvRenamer")

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")

map({ "n", "v" }, "<leader>cl", function()
  Snacks.picker.lsp_config()
end, opts "Lsp Info")
