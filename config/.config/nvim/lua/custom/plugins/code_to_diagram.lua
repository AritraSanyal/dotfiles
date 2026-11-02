---@diagnostic disable:undefined-global
return {
  -- 1. Luarocks for the 'magick' rock
  {
    'vhyrro/luarocks.nvim',
    priority = 1001,
    opts = {
      rocks = { 'magick' },
    },
  },

  -- 2. Image renderer configured for Ghostty's Kitty graphics protocol
  {
    '3rd/image.nvim',
    dependencies = { 'luarocks.nvim' },
    opts = {
      backend = 'kitty', -- for ghostty natively supports this
      processor = 'magick_rock',
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { 'markdown' },
        },
      },
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = {
        'cmp_menu',
        'cmp_docs',
        'noice',
      },
      editor_only_render_when_focused = false,
    },
  },

  -- 3. Diagram plugin scoped to Mermaid
  {
    '3rd/diagram.nvim',
    dependencies = { '3rd/image.nvim' },
    ft = { 'markdown' },
    opts = {
      events = {
        render_buffer = {
          'InsertLeave',
          'BufWinEnter',
          'TextChanged',
        },
        clear_buffer = { 'BufLeave' },
      },
      renderer_options = {
        mermaid = {
          background = 'transparent', -- 'transparent' | 'white' | '#hex'
          theme = 'dark', -- matches your Catppuccin Mocha theme
          scale = 1, -- crisp rendering on high-DPI / Retina displays
          cli_args = {
            '-c',
            vim.fn.expand '~/dotfiles/config/.config/nvim/mermaidConf/mermaid-config-catppuccin.json',
            '-C',
            vim.fn.expand '~/dotfiles/config/.config/nvim/mermaidConf/mermaid-clean.css',
          },
          width = nil, -- nil | 800 | 400 | ...
          height = nil, -- nil | 600 | 300 | ...
          -- cli_grags = {"--no-sandbox"}, -- uncomment if Puppeteer permissions complain
        },
      },
    },
  },
}
