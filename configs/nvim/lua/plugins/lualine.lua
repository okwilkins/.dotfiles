return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = "auto",
            component_separators = '',
            section_separators = '', 
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {
                { 'branch' },
                {
                    'diff',
                    symbols = {added = ' ', modified = ' ', removed = ' '},
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
                      buffers_color = {
                        -- https://github.com/catppuccin/catppuccin?tab=readme-ov-file#-palette
                        active = { bg = '#1e1e2e', fg = '#89b4fa' },
                        inactive = { bg = '#313244', fg = '#6c7086' },
                      },
                    section_separators = { left = '', right = '' },
                    symbols = {
                        modified = ' ●',
                        alternate_file = '',
                        directory = ' ',
                    },
                    filetype_names = {
                        TelescopePrompt = ' ',
                        lazygit = '  ',
                        yazi = '  ',
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
