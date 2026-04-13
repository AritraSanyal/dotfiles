return {
  -- Browser-based markdown preview
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
    config = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
    end,
  },

  -- In-editor markdown rendering
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.nvim',
  },
  opts = {
    render = {
      enabled = false,
      mix_signs = true,
      max_width = nil,
      max_priority = 1000,
      sign_priority = 4,
      namespace_padding = nil,
      conceal = {
        cursor = false,
        replacement = nil,
      },
      highlight = {
        enable = true,
        use_syntax = false,
      },
      indent = {
        active = true,
        relative = 'overlay',
        indicator = '▎',
      },
      heading = {
        enabled = true,
        signs = { '󰎤', '󰎧', '󰎪', '󰎭', '󰎱', '󰎳' },
        icons = { '󰉋', '󰉌', '󰉍', '󰉎', '󰉏', '󰉐' },
        style = 'icon',
        separator = ' ',
        conceal = false,
        priority = 0,
        stop_at_end = true,
      },
      code = {
        enabled = true,
        style = 'normal',
        text = nil,
        border = nil,
        min_priority = 2,
        padding = nil,
        syntax = nil,
        highlight = nil,
        signs = true,
      },
      dash = {
        enabled = true,
        padding = nil,
      },
      bullet = {
        enabled = true,
        padding = nil,
      },
      html = {
        enabled = true,
        conceal = true,
        style = 'inline',
        padding = nil,
      },
      latex = {
        enabled = true,
        conceal = true,
        style = 'tex2unicode',
        text = nil,
        border = nil,
        padding = nil,
        highlight = nil,
        min_priority = 2,
        keep_padding = false,
      },
      table = {
        enabled = true,
        align = {
          left = true,
          right = false,
          center = false,
        },
        separator = nil,
        padding = nil,
        min_priority = 2,
        conceal = false,
        border = nil,
      },
      sign = {
        enabled = true,
        telescope = true,
        priority = 4,
      },
      checkbox = {
        enabled = true,
        style = 'raw',
        unchecked = { icon = '󰈙', text = ' ' },
        checked = { icon = '󰸉', text = ' ' },
        priority = 0,
        width = nil,
        align = nil,
        padding = nil,
      },
      call = {
        enabled = true,
        tex = true,
        math = true,
      },
      macro = {
        enabled = true,
        highlight = 'Macro',
      },
      link = {
        enabled = true,
        enable_without_url = true,
        hide_url = false,
        style = 'auto',
        markdown_ext_to_exclude = {},
        conceal = false,
        highlight = {
          enable = false,
          vim_highlight = false,
        },
      },
      snippet = {
        enabled = true,
        region = 'region',
        width = nil,
        indent = nil,
        padding = nil,
        title = nil,
      },
      inline_code = {
        enabled = true,
        padding = nil,
        highlight = nil,
        style = 'inline',
      },
      vertical_pad = {
        enabled = true,
        amount = 1,
      },
      win_options = {
        conceallevel = 2,
        concealcursor = vim.opt.concealcursor:get(),
      },
    },
    states = {
      conceal = {
        level = 2,
      },
      raw = {
        enable = true,
        filetypes = {},
        exclude_filetypes = {},
      },
      render = {
        enable = true,
        include_filetypes = {},
        exclude_filetypes = { 'Neorg' },
      },
      filetype = {
        enabled = false,
        to_exclude = { 'neorg' },
      },
    },
    lazy_require = {
      enabled = true,
      log = false,
      modules = {
        'markdown',
        'markdown2',
        'vimtex',
        'tex',
      },
    },
  },
}
