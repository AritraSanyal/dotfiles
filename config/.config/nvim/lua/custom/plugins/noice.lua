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

    notify = {
      enabled = true,
      view = "notify",
    },

    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
  },

  config = function(_, opts)
    -- ✅ FIX: background highlight
    vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })

    require('noice').setup(opts)

    local keymap = vim.keymap.set

    keymap('n', '<leader>nh', '<cmd>Noice history<CR>', { desc = 'Noice History' })
    keymap('n', '<leader>nn', '<cmd>Noice<CR>', { desc = 'Noice Notifications' })
    keymap('n', '<leader>nd', '<cmd>Noice dismiss<CR>', { desc = 'Noice Dismiss' })
    keymap('n', '<leader>nl', '<cmd>Noice last<CR>', { desc = 'Noice Last Message' })
  end,
}
