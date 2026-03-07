return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      scope = { enabled = true },
      exclude = {
        filetypes = {
          'dashboard',
          'NvimTree',
          'Trouble',
          'lazy',
          'mason',
          'help',
          'alpha',
          'TelescopePrompt',
          'TelescopeResults',
        },
        buftypes = { 'terminal', 'nofile' },
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)

      -- Also disable manually if the dashboard loads late
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dashboard" },
        callback = function()
          vim.b.ibl_disable = true
        end,
      })
    end,
  },
}
