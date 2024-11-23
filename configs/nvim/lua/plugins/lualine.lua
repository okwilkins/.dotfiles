return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        tabline = {
            lualine_a = {'buffers'}, -- Display buffers in the tabline
        },
    },
}
