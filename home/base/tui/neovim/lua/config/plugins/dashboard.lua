local logo_dir = vim.fn.stdpath("config") .. "/lua/config/plugins/dashboard-logos"
local fallback_logo = [[
▀███▄   ▀███▀                             ██                   
  ███▄    █                                                    
  █ ███   █   ▄▄█▀██  ▄██▀██▄▀██▀   ▀██▀▀███ ▀████████▄█████▄  
  █  ▀██▄ █  ▄█▀   ████▀   ▀██ ██   ▄█    ██   ██    ██    ██  
  █   ▀██▄▓  ▓█▀▀▀▀▀▀██     ██  ██ ▄█     ▓█   ▓█    ██    ██  
  ▓     ▓█▓  ▓█▄    ▄██     ▓█   ▓██      ▓█   ▓█    ▓█    ██  
  ▓   ▀▓▓▓▓  ▓▓▀▀▀▀▀▀▓█     ▓▓   ▓█▓      ▓▓   ▓▓    ▓▓    ▓▓  
  ▓     ▓▓▓  ▒▓▓     ▓▓▓   ▓▓▓   ▓▓▓      ▓▓   ▒▓    ▒▓    ▓▓  
▒ ▒ ▒    ▒▓▓  ▒ ▒ ▒▒  ▒ ▒ ▒ ▒     ▒     ▒ ▒ ▒▒ ▒▓▒  ▒▒▒   ▒▒▓▒
]]

local function read_random_logo_lines(dir, fallback)
    local list_str = vim.fn.glob(dir .. "/*")
    local files = vim.split(list_str, "\n", { trimempty = true })

    math.randomseed(os.time())
    local lines
    if #files > 0 then
        local pick = files[math.random(#files)]
        lines = vim.fn.readfile(pick)
    else
        lines = vim.split(fallback, "\n", { trimempty = false })
    end

    for _ = 1, 8 do
        table.insert(lines, 1, "")
    end
    table.insert(lines, "") -- trailing blank line

    return lines
end

local opts = {
    theme = "doom",
    config = {
        header = read_random_logo_lines(logo_dir, fallback_logo),
        center = {},
        footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
    },
}

return opts
