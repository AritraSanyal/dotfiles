return {
  'mrcjkb/rustaceanvim',
  version = '^9',
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
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
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      },
    }
  end,
}
