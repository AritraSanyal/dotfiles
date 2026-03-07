return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local db = require('dashboard')

    db.setup {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        disable_move = true,
        shortcut = {
          { desc = ' Find File', group = '@property', action = 'Telescope find_files', key = 'f' },
          { desc = ' New File', group = 'Label', action = 'enew', key = 'n' },
          { desc = '󰒲 Lazy', group = 'DiagnosticHint', action = 'Lazy', key = 'l' },
          { desc = ' Config', group = 'Number', action = 'edit $MYVIMRC', key = 'c' },
          { desc = ' Quit', group = 'DiagnosticError', action = 'qa', key = 'q' },
        },
        project = {
          enable = true,
          limit = 8,
          icon = ' ',
          label = 'Recent Projects',
          action = 'Telescope find_files cwd=',
        },
        mru = {
          limit = 6,
          icon = ' ',
          label = 'Recent Files',
        },
        footer = {
          '🏛️  Veni  |  Vidi  |  Vici  🏛️',
        },
      },
    }
  end,
}
