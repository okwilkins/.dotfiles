return function()
    local lspconfig = require("lspconfig")

    -- Lua
    lspconfig.lua_ls.setup({})

    -- Markdown
    lspconfig.marksman.setup({})
end
