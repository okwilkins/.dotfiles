return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
        opts = require("config.plugins.treesitter-textobjects"),
    },
}
