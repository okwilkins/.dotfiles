require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })


-- Define custom keybindings for vim-visual-multi

-- Override previous definitions
vim.api.nvim_del_keymap("n", '<C-n>')
-- Define custom keybindings for vim-visual-multi
vim.g.VM_maps = {
    ["Select Cursor Down"] = "<C-j>",
    ["Select Cursor Up"] = "<C-k>"
}


-- Vim Tmux navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<cmd> TmuxNavigateLeft<cr>", { noremap = true, silent = true })  
vim.api.nvim_set_keymap("n", "<c-j>", "<cmd> TmuxNavigateDown<cr>", { noremap = true, silent = true })  
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd> TmuxNavigateUp<cr>", { noremap = true, silent = true })  
vim.api.nvim_set_keymap("n", "<C-l>", "<cmd> TmuxNavigateRight<cr>", { noremap = true, silent = true })  
