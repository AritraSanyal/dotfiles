return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",

      -- Debugging
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",

      -- Optional integrations
      "nvim-telescope/telescope.nvim",

      -- Refactoring
      "ThePrimeagen/refactoring.nvim",
    },

    config = function()
      -------------------------------------------------------
      -- DAP SETUP (Flutter / Dart)
      -------------------------------------------------------
      local dap = require("dap")
      require("nvim-dap-virtual-text").setup()

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
        -- DEBUGGER
        ---------------------------------------------------
        debugger = {
          enabled = false,
          exception_breakpoints = { "uncaught" },
          evaluate_to_string_in_debug_views = true,
        },

        ---------------------------------------------------
        -- PROJECT / SDK
        ---------------------------------------------------
        root_patterns = { ".git", "pubspec.yaml" },
        fvm = false,

        ---------------------------------------------------
        -- UI FEATURES
        ---------------------------------------------------
        widget_guides = {
          enabled = false,
        },

        closing_tags = {
          enabled = true,
          prefix = "> ",
          highlight = "ErrorMsg",
        },

        dev_log = {
          enabled = false,
          open_cmd = "15split",
          focus_on_open = true,
          notify_errors = false,
        },

        dev_tools = {
          autostart = true,
          auto_open_browser = false,
        },

        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },

        ---------------------------------------------------
        -- LSP (dartls managed internally)
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
      -- SNIPPETS (LuaSnip)
      -------------------------------------------------------
      pcall(function()
        require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
      end)

      -------------------------------------------------------
      -- REFACTORING
      -------------------------------------------------------
      require("refactoring").setup({
        prompt_func_return_type = {
          dart = true,
        },
        prompt_func_param_type = {
          dart = true,
        },
      })

      map("v", "<leader>fwr", function()
        require("refactoring").refactor("Extract Widget")
      end, { desc = "Refactoring: Extract Widget" })

      map("v", "<leader>fws", function()
        require("refactoring").refactor("Extract Function")
      end, { desc = "Refactoring: Extract Function" })

      map("v", "<leader>fwp", function()
        require("refactoring").refactor("Extract Variable")
      end, { desc = "Refactoring: Extract Variable" })

      map("v", "<leader>fwi", function()
        require("refactoring").refactor("Inline Variable")
      end, { desc = "Refactoring: Inline Variable" })

      -------------------------------------------------------
      -- WRAP WIDGET PICKER
      -------------------------------------------------------
      local wrap_widgets = {
        { name = "Container", template = "Container(child: %s)" },
        { name = "Padding (all)", template = "Padding(padding: EdgeInsets.all(8), child: %s)" },
        { name = "Padding (symmetric)", template = "Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), child: %s)" },
        { name = "Padding (only)", template = "Padding(padding: EdgeInsets.only(left: 8), child: %s)" },
        { name = "Center", template = "Center(child: %s)" },
        { name = "Column", template = "Column(children: [%s])" },
        { name = "Row", template = "Row(children: [%s])" },
        { name = "Expanded", template = "Expanded(child: %s)" },
        { name = "Flexible", template = "Flexible(child: %s)" },
        { name = "Builder", template = "Builder(builder: (context) => %s)" },
        { name = "FutureBuilder", template = "FutureBuilder(future: , builder: (context, snapshot) => %s)" },
        { name = "StreamBuilder", template = "StreamBuilder(stream: , builder: (context, snapshot) => %s)" },
        { name = "SafeArea", template = "SafeArea(child: %s)" },
        { name = "SliverToBoxAdapter", template = "SliverToBoxAdapter(child: %s)" },
        { name = "Wrap", template = "Wrap(children: [%s])" },
        { name = "Opacity", template = "Opacity(opacity: 0.5, child: %s)" },
        { name = "ClipRRect", template = "ClipRRect(borderRadius: BorderRadius.circular(8), child: %s)" },
        { name = "Card", template = "Card(child: %s)" },
        { name = "Material", template = "Material(child: %s)" },
        { name = "SingleChildScrollView", template = "SingleChildScrollView(child: %s)" },
        { name = "ListView", template = "ListView(children: [%s])" },
        { name = "SizedBox", template = "SizedBox(child: %s)" },
        { name = "ConstrainedBox", template = "ConstrainedBox(constraints: BoxConstraints(), child: %s)" },
        { name = "AspectRatio", template = "AspectRatio(aspectRatio: 16 / 9, child: %s)" },
        { name = "FittedBox", template = "FittedBox(fit: BoxFit.contain, child: %s)" },
        { name = "Stack", template = "Stack(children: [%s])" },
        { name = "Positioned", template = "Positioned(child: %s)" },
      }

      local function get_visual_selection()
        local s_start = vim.fn.getpos("'<")
        local s_end = vim.fn.getpos("'>")
        local start_row = s_start[2]
        local start_col = s_start[3]
        local end_row = s_end[2]
        local end_col = s_end[3]
        local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
        if #lines == 0 then return "" end
        lines[#lines] = string.sub(lines[#lines], 1, end_col - 1)
        lines[1] = string.sub(lines[1], start_col)
        return table.concat(lines, "\n")
      end

      local function wrap_with_widget(picker_choice)
        local selection = get_visual_selection()
        if selection == "" then
          vim.notify("No selection found", vim.log.levels.WARN)
          return
        end

        local template = picker_choice.template
        local wrapped = string.format(template, selection)

        vim.api.nvim_buf_set_text(0, vim.fn.line("'<") - 1, vim.fn.col("'<") - 1, vim.fn.line("'>") - 1, vim.fn.col("'>"), { wrapped })
      end

      map("v", "<leader>fw", function()
        local telescope = require("telescope.pickers")
        local finders = require("telescope.finders")
        local sorters = require("telescope.sorters")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local picker = telescope.new({
          prompt_title = "Wrap Widget",
          finder = finders.new_table({
            results = wrap_widgets,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.name,
                ordinal = entry.name,
              }
            end,
          }),
          sorter = sorters.get_generic_fuzzy_sorter(),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              wrap_with_widget(selection.value)
            end)
            return true
          end,
        })
        picker:find()
      end, { desc = "Flutter: Wrap Widget" })

      -------------------------------------------------------
      -- FLUTTER TEST RUNNER
      -------------------------------------------------------
      local function run_flutter_test(test_name)
        local cmd = "flutter test"
        if test_name and test_name ~= "" then
          cmd = cmd .. " --name " .. vim.fn.shellescape(test_name)
        end
        vim.cmd("terminal " .. cmd)
      end

      local function find_flutter_tests()
        local telescope = require("telescope.pickers")
        local finders = require("telescope.finders")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local test_patterns = {
          "**/*_test.dart",
          "**/test/**/*.dart",
        }

        local results = {}
        for _, pattern in ipairs(test_patterns) do
          local matches = vim.fn.glob(vim.fn.getcwd() .. "/" .. pattern, false, true)
          for _, file in ipairs(matches) do
            local lines = vim.fn.readfile(file)
            for i, line in ipairs(lines) do
              if line:match("test%(") or line:match("testWidgets%(") then
                local test_name = line:match("['\"](.-)['\"]")
                if test_name then
                  table.insert(results, {
                    name = test_name,
                    file = file,
                    line = i,
                  })
                end
              end
            end
          end
        end

        if #results == 0 then
          vim.notify("No tests found", vim.log.levels.INFO)
          return
        end

        local picker = telescope.new({
          prompt_title = "Flutter Tests",
          finder = finders.new_table({
            results = results,
            entry_maker = function(entry)
              local display = entry.name .. " (" .. vim.fn.fnamemodify(entry.file, ":.") .. ":" .. entry.line .. ")"
              return {
                value = entry,
                display = display,
                ordinal = entry.name,
              }
            end,
          }),
          sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              run_flutter_test(selection.value.name)
            end)
            map("n", "<C-r>", function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              vim.cmd("edit " .. selection.value.file)
              vim.fn.cursor(selection.value.line, 1)
            end)
            return true
          end,
        })
        picker:find()
      end

      map("n", "<leader>fT", find_flutter_tests, { desc = "Flutter: Run Test" })

      map("n", "<leader>fA", "<cmd>FlutterTest<CR>", { desc = "Flutter: Run All Tests" })

      -------------------------------------------------------
      -- ENHANCED CODE ACTIONS (Telescope)
      -------------------------------------------------------
      map("n", "<leader>fc", function()
        local telescope = require("telescope.builtin")
        telescope.lsp_code_actions({
          show_delay = 200,
        })
      end, { desc = "Flutter: Code Actions" })

      map("v", "<leader>fc", function()
        local telescope = require("telescope.builtin")
        telescope.lsp_code_actions({
          show_delay = 200,
        })
      end, { desc = "Flutter: Code Actions (visual)" })

      map("n", "<leader>fro", function()
        local telescope = require("telescope.builtin")
        telescope.lsp_references()
      end, { desc = "Flutter: Find References" })

      map("n", "<leader>fgd", function()
        local telescope = require("telescope.builtin")
        telescope.lsp_definitions()
      end, { desc = "Flutter: Goto Definition" })

      map("n", "<leader>fgi", function()
        local telescope = require("telescope.builtin")
        telescope.lsp_implementations()
      end, { desc = "Flutter: Goto Implementation" })

      map("n", "<leader>fty", function()
        vim.lsp.buf.hover()
      end, { desc = "Flutter: Type/Hover Info" })

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
