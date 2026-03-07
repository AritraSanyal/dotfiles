return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",

      -- Debugging
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",

      -- Optional integrations
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      -------------------------------------------------------
      -- DAP SETUP (Flutter / Dart)
      -------------------------------------------------------
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- Auto open/close debugger UI
      dap.listeners.after.event_initialized["flutter_dapui"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["flutter_dapui"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["flutter_dapui"] = function()
        dapui.close()
      end

      -------------------------------------------------------
      -- DEBUGGER KEYMAPS
      -------------------------------------------------------
      local map = vim.keymap.set
      map("n", "<F5>", dap.continue, { desc = "DAP Continue" })
      map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
      map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
      map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
      map("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
      map("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP Conditional Breakpoint" })

      -------------------------------------------------------
      -- LSP CAPABILITIES (Blink CMP)
      -------------------------------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      pcall(function()
        capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      end)

      -------------------------------------------------------
      -- FLUTTER TOOLS SETUP
      -------------------------------------------------------
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
          notification_style = "native",
        },

        ---------------------------------------------------
        -- DEBUGGER (VS CODE LEVEL)
        ---------------------------------------------------
        debugger = {
          enabled = true,
          exception_breakpoints = { "uncaught" },
          evaluate_to_string_in_debug_views = true,
        },

        ---------------------------------------------------
        -- PROJECT / SDK
        ---------------------------------------------------
        root_patterns = { ".git", "pubspec.yaml" },
        fvm = false, -- set true if you use FVM

        ---------------------------------------------------
        -- UI FEATURES
        ---------------------------------------------------
        widget_guides = {
          enabled = false, -- experimental
        },

        closing_tags = {
          enabled = true,
          prefix = "> ",
          highlight = "ErrorMsg",
        },

        dev_log = {
          enabled = true,
          open_cmd = "15split",
          focus_on_open = true,
          notify_errors = false,
        },

        dev_tools = {
          autostart = true, -- DevTools like VS Code
          auto_open_browser = false,
        },

        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },

        ---------------------------------------------------
        -- LSP (dartls is managed internally!)
        ---------------------------------------------------
        lsp = {
          capabilities = capabilities,
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
          },
        },
      })

      -------------------------------------------------------
      -- TELESCOPE EXTENSION
      -------------------------------------------------------
      pcall(function()
        require("telescope").load_extension("flutter")
      end)

      -------------------------------------------------------
      -- FLUTTER COMMAND KEYMAPS
      -------------------------------------------------------
      map("n", "<leader>fr", "<cmd>FlutterRun<CR>", { desc = "Flutter Run" })
      map("n", "<leader>fD", "<cmd>FlutterDebug<CR>", { desc = "Flutter Debug" })
      map("n", "<leader>fh", "<cmd>FlutterReload<CR>", { desc = "Flutter Hot Reload" })
      map("n", "<leader>fR", "<cmd>FlutterRestart<CR>", { desc = "Flutter Hot Restart" })
      map("n", "<leader>fd", "<cmd>FlutterDevices<CR>", { desc = "Flutter Devices" })
      map("n", "<leader>fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter Emulators" })
      map("n", "<leader>fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Flutter Outline" })
      map("n", "<leader>fl", "<cmd>FlutterLogToggle<CR>", { desc = "Flutter Logs" })
      map("n", "<leader>fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter Quit" })
      map("n", "<leader>ft", "<cmd>FlutterDevTools<CR>", { desc = "Flutter DevTools" })
    end,
  },
}
