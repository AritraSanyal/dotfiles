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
      max_height_window_percentage = 75,
      max_width_window_percentage = 100,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = {
        'cmp_menu',
        'cmp_docs',
        'noice',
      },
      editor_only_render_when_focused = false,
    },
    config = function(_, opts)
      require('image').setup(opts)
      -- center diagrams horizontally to match centered code blocks
      local ok, kitty = pcall(require, 'image/backends/kitty')
      if ok and kitty and kitty.render then
        local orig_render = kitty.render
        kitty.render = function(image, x, y, width, height)
          local win_info = vim.fn.getwininfo(image.window)[1]
          if win_info then
            local text_width = win_info.width - win_info.textoff
            if text_width > width then
              x = win_info.wincol - 1 + win_info.textoff + math.floor((text_width - width) / 2)
            end
          end
          return orig_render(image, x, y, width, height)
        end
      end
    end,
  },

  -- 3. Diagram plugin scoped to Mermaid
  {
    '3rd/diagram.nvim',
    dependencies = { '3rd/image.nvim' },
    ft = { 'markdown' },
    keys = {
      {
        '<leader>td',
        function()
          local diagram = require 'diagram'
          -- clear teh existing diagram
          diagram.clear()
          vim.schedule(function()
            diagram.render()
            vim.b.diagram_active = true
          end)
        end,
        ft = { 'markdown' },
        desc = '[T]oggle [D]iagram',
      },
      {
        '<leader>tc',
        function()
          local diagram = require 'diagram'
          diagram.clear()
          vim.b.diagram_active = false
        end,
        ft = { 'markdown' },
        desc = '[T]oggle Diagram [C]lear',
      },
    },
    opts = {
      events = {
        render_buffer = { 'BufWritePost' },
        clear_buffer = { 'BufLeave' },
      },
      renderer_options = {
        --NOTE: D2 config
        d2 = {
          -- theme options 200->dark_mauve 201->dark_flagship 300->terminal_hacker
          theme_id = 200, -- something called "Dark Mauve" matches with catppuccin
          -- dark_theme_id = 200,
          layout = 'dagre',
          scale = 2,
          sketch = false, -- hand drawn look
        },
      },
    },
  },
}
