local function lsp_client_names()
    local clients = vim.lsp.get_active_clients()
    local buffer_clients = {}

    -- Filter clients attached to the current buffer
    for _, client in pairs(clients) do
        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
            table.insert(buffer_clients, client.name)
        end
    end

    -- Return a comma-separated list of client names or a default value
    if next(buffer_clients) == nil then
        return "󰣖 LSP: Inactive"
    end

    local language_servers = table.concat(buffer_clients, ", ")
    return string.format("󰣖 LSP: [%s]", language_servers)
end

return {
    options = {
        theme = "auto",
        component_separators = "",
        section_separators = "",
    },
    sections = {
        lualine_a = {
            "mode",
            -- color = { fg = "#ffffff", bg = "#0077cc", gui = "bold" },
        },
        lualine_b = {
            {
                "filetype",
                icon_only = true,
                padding = { left = 1, right = 0 },
            },
            {
                "filename",
                padding = { left = 0, right = 1 },
                symbols = {
                    modified = "",
                    readonly = "",
                    unnamed = " 󱙄",
                    newfile = " ",
                },
            },
        },
        lualine_c = {
            { "branch" },
            {
                "diff",
                symbols = { added = " ", modified = " ", removed = " " },
            },
        },
        lualine_x = {
            {
                "diagnostics",
            },
            {
                lsp_client_names,
            },
        },
        lualine_y = { { "filename" }, "progress" },
        lualine_z = { "location" },
    },
    always_show_tabline = true,
    tabline = {
        lualine_a = {
            {
                "buffers",
                buffers_color = {
                    -- https://github.com/catppuccin/catppuccin?tab=readme-ov-file#-palette
                    active = { bg = "#1e1e2e", fg = "#89b4fa" },
                    inactive = { bg = "#1e1e2e", fg = "#6c7086" },
                },
                section_separators = { left = "", right = "" },
                symbols = {
                    modified = " ●",
                    alternate_file = "",
                    directory = " ",
                },
                filetype_names = {
                    TelescopePrompt = " ",
                    lazygit = "  ",
                    yazi = "  ",
                    checkhealth = " 󰓙 ",
                },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}
