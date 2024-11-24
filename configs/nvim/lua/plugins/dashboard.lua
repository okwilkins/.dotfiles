return {
    "nvimdev/dashboard-nvim",
    event = 'VimEnter',
    opts = {
        theme = 'hyper',
        config = {
          week_header = {
           enable = true,
          },
          shortcut = {
            { desc = '󰚰 Lazy Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Yazi cwd',
              key = 'f',
            },
            {
              desc = ' Apps',
              group = 'DiagnosticHint',
              action = 'Telescope app',
              key = 'a',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              action = 'Telescope $DOTFILES',
              key = 'd',
            },
          },
        },
    },
}
