return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 20,
    open_mapping = nil, -- disable default Ctrl+\

    direction = "float",
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    close_on_exit = true,
    shade_terminals = true,

    float_opts = {
      border = "rounded",
      winblend = 5,
      width = function()
        return math.floor(vim.o.columns * 0.8)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
    },
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- 🔥 MAIN KEYBIND (your requirement)
    vim.keymap.set("n", "<leader>\\", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

    -- Better terminal escape
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
  end,
}
