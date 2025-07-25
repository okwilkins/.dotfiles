return function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set
    -- Add or skip cursor above/below the main cursor.
    set({ "n", "v" }, "<leader><down>", function()
        mc.lineAddCursor(1)
    end)
    set({ "n", "v" }, "<leader><up>", function()
        mc.lineAddCursor(-1)
    end)
    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "v" }, "<leader>d", function()
        mc.matchAddCursor(1)
    end)

    set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        elseif mc.hasCursors() then
            mc.clearCursors()
        else
            -- Default <esc> handler.
        end
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
end
