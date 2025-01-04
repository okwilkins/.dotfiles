return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        animate = {
            fps = 120,
        },
        quickfile = { enabled = true },
        indent = {
            enabled = true,
            -- filter for buffers to enable indent guides
            filter = function(buf)
                return (
                    vim.g.snacks_indent ~= false
                    and vim.b[buf].snacks_indent ~= false
                    and vim.bo[buf].buftype == ""
                    -- Turn this off for the dashboard
                    and vim.bo[buf].filetype ~= "dashboard"
                )
            end,
        },
        notifier = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
    },
}
