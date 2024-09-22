vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
        config = function()
            require("options")
        end,
    },

    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("nvchad.autocmds")

vim.schedule(function()
    require("mappings")
end)

-- Options
vim.opt.relativenumber = true

-- This makes yanking and pasting easier on WSL
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.opt.tabstop = 4 -- A TAB character looks like 4 spaces
vim.opt.expandtab = true -- Expand TABs to spaces
vim.opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4 -- Number of spaces inserted when indenting

-- Treesitter configs
require("nvim-treesitter.configs").setup({
    ensure_installed = { "html" }, -- Add other languages if needed
    highlight = { enable = true },
    indent = { enable = true },
})

-- LSPs not from Mason
local lspconfig = require("lspconfig")
local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
    },
    format_on_save = true,
})

-- Lua
lspconfig.lua_ls.setup({})

-- Gleam
lspconfig.gleam.setup({})

-- Python
lspconfig.pyright.setup({})
lspconfig.ruff_lsp.setup({
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        },
    },
})

-- Go
lspconfig.gopls.setup({})
lspconfig.golangci_lint_ls.setup({})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.format()
    end,
})

-- YAML
lspconfig.yamlls.setup({
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            completion = true,
            hover = true,
            validate = true,
            format = {
                enable = true,
            },
            schemas = {
                ["kubernetes"] = "*.{yaml,yml}",
                ["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = "cloudformation.{yml,yaml}",
            },
        },
    },
})
