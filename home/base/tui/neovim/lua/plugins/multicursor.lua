return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    config = require("config.plugins.multicursor"),
}
