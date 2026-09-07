return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
        require("config.plugins.lspconfig")()
    end,
}
