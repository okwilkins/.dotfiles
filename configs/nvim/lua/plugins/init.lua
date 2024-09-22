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
      {
        "kevinhwang91/nvim-ufo",
        dependencies = {
          "kevinhwang91/promise-async",
          {
            "luukvbaal/statuscol.nvim",
            config = function()
              local builtin = require("statuscol.builtin")
              require("statuscol").setup({
                relculright = true,
                segments = {
                  { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                  { text = { "%s" }, click = "v:lua.ScSa" },
                  { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                },
              })
            end,
          },
        },
        event = "BufReadPost",
        opts = {
          -- provider_selector = function()
          --   return { "treesitter", "indent" }
          -- end,
          open_fold_hl_timeout = 150,
          close_fold_kinds_for_ft = {
              default = {'imports', 'comment'},
              json = {'array'},
              c = {'comment', 'region'}
          },
          preview = {
              win_config = {
                  border = {'', '─', '', '', '', '─', '', ''},
                  winhighlight = 'Normal:Folded',
                  winblend = 0
              },
              mappings = {
                  scrollU = '<C-u>',
                  scrollD = '<C-d>',
                  jumpTop = '[',
                  jumpBot = ']'
              }
          },
          fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, {chunkText, hlGroup})
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, {suffix, 'MoreMsg'})
            return newVirtText
          end,
        },
      },
    },
}

