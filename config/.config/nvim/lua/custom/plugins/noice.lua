return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    presets = {
      bottom_search = true, -- classic search bar at bottom
      command_palette = true, -- command palette UI
      long_message_to_split = true, -- show long messages in a split window
      inc_rename = false,
      lsp_doc_border = false,
    },
  },

  config = function(_, opts)
    require('noice').setup(opts)

    -- 🧠 Keybindings for Noice
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true, desc = '' }

    -- Show message history (like :messages)
    keymap('n', '<leader>nh', '<cmd>Noice history<CR>', { desc = 'Noice History' })

    -- Show all recent notifications
    keymap('n', '<leader>nn', '<cmd>Noice<CR>', { desc = 'Noice Notifications' })

    -- Dismiss all current notifications
    keymap('n', '<leader>nd', '<cmd>Noice dismiss<CR>', { desc = 'Noice Dismiss' })

    -- Show last message quickly (like :messages last)
    keymap('n', '<leader>nl', '<cmd>Noice last<CR>', { desc = 'Noice Last Message' })
  end,
}
