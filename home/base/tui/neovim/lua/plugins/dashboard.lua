return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = require("config.plugins.dashboard"),
    config = function(_, opts)
        require("dashboard").setup(opts)
        vim.api.nvim_create_autocmd("User", {
            pattern = "DashboardLoaded",
            callback = function()
                local bufnr = vim.api.nvim_get_current_buf()
                for _, a in ipairs(vim.api.nvim_get_autocmds({ event = "VimResized", buffer = bufnr })) do
                    vim.api.nvim_del_autocmd(a.id)
                end
            end,
        })
    end,
}
