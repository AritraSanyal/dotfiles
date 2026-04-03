return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufEnter*.md' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'markdown',
        'markdown_inline',
        'html',
        'latex',
        'yaml',
      },
      auto_install = true,
      highlight = { enable = true },
      incremental_selection = { enable = true },
      textobjects = { select = { enable = true } },
    }
  end,
}
