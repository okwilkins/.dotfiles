local map = vim.keymap.set

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope find in current buffer" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })
map(
    "n",
    "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "Telescope find all files" }
)
map("n", "<leader>fi", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

-- Lazygit
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Yazi
map("n", "<leader>fc", "<cmd>Yazi<cr>", { desc = "Yazi current file" })
map("n", "<leader>fe", "<cmd>Yazi cwd<cr>", { desc = "Yazi working directory" })
map("n", "<leader>ft", "<cmd>Yazi toggle<cr>", { desc = "Yazi resume session" })

-- Buffers
map("n", "<leader>x", ":bd<CR>", { noremap = true, silent = true, desc = "Close current buffer" })
map("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Switch to next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Switch to previous buffer" })

-- Vim Tmux navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<cmd> TmuxNavigateLeft<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-j>", "<cmd> TmuxNavigateDown<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd> TmuxNavigateUp<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<cmd> TmuxNavigateRight<cr>", { noremap = true, silent = true })

-- LSP
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>lf", "<cmd>Telescope lsp_references<CR>", { desc = "Telescope find references" })
map("n", "<leader>lh", vim.lsp.buf.signature_help, { desc = "LSP show signature help" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP rename object" })
map("n", "<leader>lx", ":LspRestart<CR>", { desc = "LSP restart server" })
map("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Telescope show buffer diagnostics" })

-- DAP
vim.keymap.set("n", "<Leader>bc", function()
    require("dap").continue()
end, { desc = "DAP continue" })
vim.keymap.set("n", "<Leader>bo", function()
    require("dap").step_over()
end, { desc = "DAP step over" })
vim.keymap.set("n", "<Leader>bs", function()
    require("dap").step_into()
end, { desc = "DAP step into" })
vim.keymap.set("n", "<Leader>bi", function()
    require("dap").step_out()
end, { desc = "DAP step out" })
vim.keymap.set("n", "<Leader>bt", function()
    require("dap").toggle_breakpoint()
end, { desc = "DAP toggle breakpoint" })
vim.keymap.set("n", "<Leader>bq", function()
    require("dap").terminate()
    require("dapui").close()
end, { desc = "DAP terminate and close UI" })
