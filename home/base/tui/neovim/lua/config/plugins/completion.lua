local cmp_success, cmp = pcall(require, "cmp")
local lspkind_success, lspkind = pcall(require, "lspkind")
local autopairs_success, autopairs = pcall(require, "nvim-autopairs.completion.cmp")

if not cmp_success then
    vim.notify("nvim-cmp failed to load", vim.log.levels.ERROR)
    return {}
end

local format = {}

if lspkind_success then
    format = lspkind.cmp_format()
else
    vim.notify("lspkind failed to load with nvim-cmp", vim.log.levels.ERROR)
end

if autopairs_success then
    cmp.event:on("confirm_done", autopairs.on_confirm_done())
else
    vim.notify("nvim-autopairs failed to load with nvim-cmp", vim.log.levels.ERROR)
end

return {
    mapping = {
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        -- If only one entry, auto select that
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if #cmp.get_entries() == 1 then
                    cmp.confirm({ select = true })
                else
                    cmp.select_next_item()
                end
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- If nothing is selected (including preselections) add a newline as usual on return key
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    }),
    formatting = {
        format = format,
    },
}
