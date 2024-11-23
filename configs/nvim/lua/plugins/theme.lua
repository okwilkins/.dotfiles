return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            styles = {
                comments = { "italic" },
                conditionals = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
                -- miscs = {},  -- Uncomment to turn off hard-coded styles
            },
            default_integrations = true,
            -- https://github.com/catppuccin/nvim?tab=readme-ov-file#integrations
            integrations = {
                cmp = true,
                gitsigns = true,
                indent_blankline = {
                    enabled = true,
                    -- In order of how subtle they are: overlay0, surface1, surface2, subtext0, lavender
                    scope_color = "surface1",
                    colored_indent_levels = false,
                },
                -- lualine → see their corresponding lua files
                mason = true,
                noice = true,
                notify = true,
                telescope = { enabled = true },
                treesitter = true,
                treesitter_context = true,
                lsp_trouble = true,
                which_key = true,
            },
        })
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}
