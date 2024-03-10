-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
vim.opt.relativenumber = true

-- lazy.nvim
-- 💤 A modern plugin manager for Neovim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
      })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Detect tabstop and shiftwidth automatically
    {'tpope/vim-sleuth'},

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Adds git related signs to the gutter, as well as utilities for managing changes
    { 'lewis6991/gitsigns.nvim' },
})
