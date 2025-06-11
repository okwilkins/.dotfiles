return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    opts = require("config.plugins.treesitter-context"),
}
