return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Edit the colours so that the top bar and bottom bar are a super dark colour
        local M = require("config.plugins.lualine")
        local O = require("catppuccin").options
        local C = require("catppuccin.palettes").get_palette("mocha")
        local custom_lualine = require("catppuccin.utils.lualine")("mocha")

        -- https://github.com/catppuccin/nvim/blob/faf15ab0201b564b6368ffa47b56feefc92ce3f4/lua/catppuccin/utils/lualine.lua
        local transparent_bg = O.transparent_background and "NONE" or C.base

        custom_lualine.normal.c.bg = transparent_bg
        custom_lualine.inactive.c.bg = transparent_bg
        custom_lualine.inactive.c.bg = transparent_bg
        custom_lualine.inactive.c.bg = transparent_bg

        M.options.theme = custom_lualine

        require("lualine").setup(M)
    end,
}
