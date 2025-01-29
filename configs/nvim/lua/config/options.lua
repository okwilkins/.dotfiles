-- Lines
vim.opt.number = true -- Print the line number in front of each line
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.cursorlineopt = "number" -- Makes the number the thing that highlights the line

-- Tabs and indentation
vim.opt.tabstop = 4 -- A TAB character looks like 4 spaces
vim.opt.expandtab = true -- Expand TABs to spaces
vim.opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4 -- Number of spaces inserted when indenting

-- Scrolloff
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
-- Scrolloff at EOF
-- https://www.reddit.com/r/neovim/comments/17eomi1/comment/k6hm00m
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("ScrollOffEOF", {}),
    callback = function()
        local win_h = vim.api.nvim_win_get_height(0)
        local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
        local dist = vim.fn.line("$") - vim.fn.line(".")
        local rem = vim.fn.line("w$") - vim.fn.line("w0") + 1
        if dist < off and win_h - rem + dist < off then
            local view = vim.fn.winsaveview()
            view.topline = view.topline + off - (win_h - rem + dist)
            vim.fn.winrestview(view)
        end
    end,
})

-- Spelling
vim.opt.spell = true

-- Undo/Redo
-- Undo even when exited a file
local undo_dir = vim.fn.stdpath("cache") .. "/undo/"
vim.fn.mkdir(undo_dir, "p")
vim.opt.undodir = undo_dir
vim.opt.undofile = true
vim.opt.undolevels = 1000 -- Number of changes to keep track of

-- Yank/Paste
vim.opt.clipboard = "unnamedplus"
-- Allows WSL clipboards to function in nvim
local in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil
if in_wsl then
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
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
-- Paste without overwriting register
vim.keymap.set("x", "p", '"_dP', { noremap = true })
vim.keymap.set("x", "P", '"_dP', { noremap = true })

-- Open dashboard when no buffers
vim.api.nvim_create_autocmd("BufDelete", {
    desc = "Open dashboard when no meaningful buffers remain",
    group = vim.api.nvim_create_augroup("dashboard_when_no_buffer", { clear = true }),
    callback = function()
        local buffers = vim.api.nvim_list_bufs()
        local actual = {}

        -- Filter out nofile buffers created by plugins
        for _, buf in ipairs(buffers) do
            if vim.bo[buf].buftype == "" and vim.api.nvim_buf_is_loaded(buf) then
                table.insert(actual, buf)
            end
        end

        -- If there's exactly one actual buffer and it's empty, open the dashboard
        if #actual == 1 then
            local bufname = vim.api.nvim_buf_get_name(actual[1])
            if bufname == "" then
                vim.cmd("Dashboard")
            end
        end
    end,
})

-- LSP Diagnostics
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "󰌶" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = "" })
end

-- Reserve space for the LSP diagnostics so it stops the sidebar from suddenly jerking to the side
vim.opt.signcolumn = "yes"

-- Misc
vim.opt.termguicolors = true
