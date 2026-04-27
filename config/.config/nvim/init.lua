-----------------------------------------------------------
-- Neovim Configuration (Kickstart + Lazy + Custom)
-----------------------------------------------------------

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- General Settings
-----------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 10
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
local map = vim.keymap.set
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics list' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })
map('i', 'jk', '<Esc>', { desc = 'Exit Insert mode with jk' })
map('n', '<leader>mr', function()
  require('render-markdown').toggle()
end, { desc = 'Toggle Markdown Render' })
-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------

-- Highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = 'Highlight text on yank',
})

-- Disable indent line for dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  callback = function()
    vim.b.ibl_disable = true
    vim.opt_local.colorcolumn = ""
    vim.opt_local.cursorline = false
    vim.opt_local.relativenumber = false
  end,
})

-----------------------------------------------------------
-- Plugins (Lazy.nvim)
-----------------------------------------------------------
require('lazy').setup {

  -----------------------------------------------------------
  -- Core Plugins
  -----------------------------------------------------------
  { 'NMAC427/guess-indent.nvim', config = true },
  { 'folke/which-key.nvim',      event = 'VeryLazy', config = true },

  -----------------------------------------------------------
  -- Telescope
  -----------------------------------------------------------
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local telescope = require 'telescope'
      local builtin = require 'telescope.builtin'
      telescope.setup()
      map('n', '<leader>sf', builtin.find_files, { desc = 'Find files' })
      map('n', '<leader>sg', builtin.live_grep, { desc = 'Live grep' })
      map('n', '<leader>sb', builtin.buffers, { desc = 'Find buffers' })
      map('n', '<leader>sh', builtin.help_tags, { desc = 'Find help' })
    end,
  },

  -----------------------------------------------------------
  -- Git Signs
  -----------------------------------------------------------
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -----------------------------------------------------------
  -- LSP + Mason (Modern API)
  -----------------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',                  config = true },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'j-hui/fidget.nvim',                        opts = {} },
      { 'folke/lazydev.nvim',                       ft = 'lua',   opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      local servers = { 'lua_ls', 'bashls', 'pyright', 'texlab' }

      require('mason').setup()
      require('mason-tool-installer').setup { ensure_installed = servers }

      require('mason-lspconfig').setup {
        ensure_installed = servers,
        handlers = {
          function(server_name)
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require('lspconfig')[server_name].setup {
              on_attach = function(_, bufnr)
                local map = function(keys, func, desc)
                  if desc then desc = 'LSP: ' .. desc end
                  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end
                map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
                map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
              end,
              capabilities = capabilities,
              settings = {},
            }
          end,
        },
      }
    end,
  },

  -----------------------------------------------------------
  -- Formatter
  -----------------------------------------------------------
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    config = function()
      require('conform').setup {
        format_on_save = function(bufnr)
          local disable = { c = true, cpp = true }
          if disable[vim.bo[bufnr].filetype] then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        formatters_by_ft = { lua = { 'stylua' } },
      }
    end,
  },

  -----------------------------------------------------------
  -- Autocompletion
  -----------------------------------------------------------
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        config = function()
          require('luasnip.loaders.from_lua').load { paths = { './snippets' } }
        end,
      },
      'folke/lazydev.nvim',
    },
    opts = {
      keymap = {
        preset = 'default',

        ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<C-y>'] = false, -- disable ctrl+y
      },

      snippets = { preset = 'luasnip' },

      sources = { default = { 'lsp', 'path', 'buffer', 'snippets' } },
      appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'normal' },
      fuzzy = {
        implementation = 'lua', -- 👈 disables the Rust build warning
      },
    },
  },

  -----------------------------------------------------------
  -- UI Enhancements
  -----------------------------------------------------------
  -- {
  --   'ellisonleao/gruvbox.nvim',
  --   priority = 1000,
  --   config = function()
  --     require('gruvbox').setup {
  --       contrast = 'hard',
  --       transparent_mode = false,
  --     }
  --     vim.o.background = 'dark'
  --     vim.cmd.colorscheme 'gruvbox'
  --   end,
  -- },

  -- catpuchin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = {    -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        float = {
          transparent = false,          -- enable transparent floating windows
          solid = false,                -- use solid styling for floating windows, see |winborder|
        },
        term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false,              -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,            -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,              -- Force no italic
        no_bold = false,                -- Force no bold
        no_underline = false,           -- Force no underline
        styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" },      -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        auto_integrations = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme "catppuccin-nvim"
    end,

  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  -----------------------------------------------------------
  -- Imports
  -----------------------------------------------------------
  { import = 'kickstart.plugins' },
  { import = 'custom.plugins' },
}

-----------------------------------------------------------
-- Done
-----------------------------------------------------------
