return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        sections = {
            lualine_a = {'mode'},
            lualine_b = {
                { 'branch' },
                {
                    'diff',
                    symbols = {added = ' ', modified = ' ', removed = ' '},
                },
                { 'diagnostics' },
            },
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'},
        },
        always_show_tabline = true,
        tabline = {
            lualine_a = {
                {
                    'buffers',
                    symbols = {
                        modified = ' ',
                        alternate_file = '',
                        directory = ' ',
                    },
                },
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
    },
}
