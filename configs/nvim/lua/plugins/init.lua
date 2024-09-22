return {
  -- Formatter pluging
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  -- Git interface
  {
    "NeogitOrg/neogit",
    event = 'VimEnter',
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",           -- optional
    },
    config = true
  },

  -- Nice notifcation popups + search/command box is easier to see
  {
    'folke/noice.nvim',
    event = 'VimEnter',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module='...'` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = false,      -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end
  },

  -- Markdown previewer
    {
        "OXY2DEV/markview.nvim",
        lazy = false,      -- Recommended
        -- ft = "markdown" -- If you decide to lazy-load anyway
        dependencies = {
            -- You will not need this if you installed the
            -- parsers manually
            -- Or if the parsers are in your $RUNTIMEPATH
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    },

    -- Nvim Tmux navigator for "shared" window navigation between the two    
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },

    -- Multi cursor support
    {
        "mg979/vim-visual-multi",
        lazy = false,
    },

    -- Shows marks in the gutter
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },

    {
        'rmagatti/auto-session',
        lazy = false,

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
            -- log_level = 'debug',
        }
    },

    -- Adds more objects
    {
        "chrisgrieser/nvim-various-textobjs",
        event = "UIEnter",
        opts = { useDefaultKeymaps = true },
    },

    -- Makes folds nicer
    {
        "kevinhwang91/nvim-ufo",
        event = "UIEnter",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        keys = {
            { "zM", function() require("ufo").closeAllFolds() end, desc = "󱃄 Close All Folds" },
            { "zR", function() require("ufo").openFoldsExceptKinds {} end, desc = "󱃄 Open All Folds" },
        },
        init = function()
            -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
            -- auto-closing them after leaving insert mode, however ufo does not seem to
            -- have equivalents for zr and zm because there is no saved fold level.
            -- Consequently, the vim-internal fold levels need to be disabled by setting
            -- them to 99.
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = '1'
        end,
        opts = {
            provider_selector = function(_, ft, _)
                -- INFO some filetypes only allow indent, some only LSP, some only
                -- treesitter. However, ufo only accepts two kinds as priority,
                -- therefore making this function necessary :/
                local lspWithOutFolding = { 'markdown', 'sh', 'css', 'html', 'python' }
                if vim.tbl_contains(lspWithOutFolding, ft) then
                    return { 'treesitter', 'indent' }
                end
                return { 'lsp', 'indent' }
            end,
            -- open opening the buffer, close these fold kinds
            -- use `:UfoInspect` to get available fold kinds from the LSP
            close_fold_kinds_for_ft = { lsp = { 'imports', 'comment' } },
            open_fold_hl_timeout = 800,
            fold_virt_text_handler = foldTextFormatter,
        },
    },
}

