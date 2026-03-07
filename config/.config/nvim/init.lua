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
    },
    config = function()
      local servers = { 'lua_ls', 'bashls', 'pyright' }

      require('mason').setup()
      require('mason-tool-installer').setup { ensure_installed = servers }

      require('mason-lspconfig').setup {
        ensure_installed = servers,
        handlers = {
          function(server_name)
            local config = vim.lsp.config {
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
              capabilities = vim.lsp.protocol.make_client_capabilities(),
              settings = {},
            }
            vim.lsp.start(config, { name = server_name })
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
      'L3MON4D3/LuaSnip',
      'folke/lazydev.nvim',
    },
    opts = {
      keymap = { preset = 'default' },
      sources = { default = { 'lsp', 'path', 'buffer', 'snippets' } },
      appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'normal' },
      fuzzy = {
        implementation = "lua", -- 👈 disables the Rust build warning
      },
    },
  },

  -----------------------------------------------------------
  -- UI Enhancements
  -----------------------------------------------------------
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        contrast = 'hard',
        transparent_mode = false,
      }
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'gruvbox'
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
