return {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- Keep each Neovim instance's directory handoff separate.
        local dir_file = vim.fn.tempname()
        vim.env.LAZYGIT_NEW_DIR_FILE = dir_file

        vim.g.lazygit_on_exit_callback = function()
            if vim.fn.filereadable(dir_file) == 0 then
                return
            end

            local lines = vim.fn.readfile(dir_file)
            vim.fn.delete(dir_file)
            local directory = lines[1]
            if directory and vim.fn.isdirectory(directory) == 1 then
                vim.api.nvim_set_current_dir(directory)
            end
        end

        vim.api.nvim_create_autocmd("VimLeavePre", {
            once = true,
            callback = function()
                vim.fn.delete(dir_file)
            end,
        })
    end,
}
