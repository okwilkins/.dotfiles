return {
    formatters_by_ft = {
        lua = { "stylua" },
        yaml = { "yq" },
        terraform = {
            command = "terraform",
            args = { "fmt", "." },
            stdin = false,
        },
        go = { "gofmt" },
        python = { "ruff" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
}
