return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup(require("config.plugins.catppuccin"))
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}
