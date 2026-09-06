require("config.keymaps")
require("config.options")
require("config.jupynvim")
require("config.lazy")
-- lazy's vim.loader.enable() removes nvim's pack-aware lua loader and resets
-- packpath; restore both so home-manager pack plugins (jupynvim) stay requireable.
table.insert(package.loaders, 2, vim._load_package)
vim.opt.packpath:prepend(vim.fn.stdpath("data") .. "/site")
