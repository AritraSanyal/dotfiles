return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",

      -- Optional integrations
      "nvim-telescope/telescope.nvim",

      -- Refactoring
      "ThePrimeagen/refactoring.nvim",
    },

    config = function()
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
          enabled = true,
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
          on_attach = function(_, bufnr)
            local map = function(keys, func, desc)
              if desc then desc = 'LSP: ' .. desc end
              vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end
            map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
            map('K', vim.lsp.buf.hover, 'Hover Documentation')
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            -- Note: <leader>ca and <leader>fc both work for code actions now
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          end,
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
      -- REFACTORING
      -------------------------------------------------------
      local map = vim.keymap.set

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
        { name = "Container",             template = "Container(child: %s)" },
        { name = "Padding (all)",         template = "Padding(padding: EdgeInsets.all(8), child: %s)" },
        { name = "Padding (symmetric)",   template = "Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), child: %s)" },
        { name = "Padding (only)",        template = "Padding(padding: EdgeInsets.only(left: 8), child: %s)" },
        { name = "Center",                template = "Center(child: %s)" },
        { name = "Column",                template = "Column(children: [%s])" },
        { name = "Row",                   template = "Row(children: [%s])" },
        { name = "Expanded",              template = "Expanded(child: %s)" },
        { name = "Flexible",              template = "Flexible(child: %s)" },
        { name = "Builder",               template = "Builder(builder: (context) => %s)" },
        { name = "FutureBuilder",         template = "FutureBuilder(future: , builder: (context, snapshot) => %s)" },
        { name = "StreamBuilder",         template = "StreamBuilder(stream: , builder: (context, snapshot) => %s)" },
        { name = "SafeArea",              template = "SafeArea(child: %s)" },
        { name = "SliverToBoxAdapter",    template = "SliverToBoxAdapter(child: %s)" },
        { name = "Wrap",                  template = "Wrap(children: [%s])" },
        { name = "Opacity",               template = "Opacity(opacity: 0.5, child: %s)" },
        { name = "ClipRRect",             template = "ClipRRect(borderRadius: BorderRadius.circular(8), child: %s)" },
        { name = "Card",                  template = "Card(child: %s)" },
        { name = "Material",              template = "Material(child: %s)" },
        { name = "SingleChildScrollView", template = "SingleChildScrollView(child: %s)" },
        { name = "ListView",              template = "ListView(children: [%s])" },
        { name = "SizedBox",              template = "SizedBox(child: %s)" },
        { name = "ConstrainedBox",        template = "ConstrainedBox(constraints: BoxConstraints(), child: %s)" },
        { name = "AspectRatio",           template = "AspectRatio(aspectRatio: 16 / 9, child: %s)" },
        { name = "FittedBox",             template = "FittedBox(fit: BoxFit.contain, child: %s)" },
        { name = "Stack",                 template = "Stack(children: [%s])" },
        { name = "Positioned",            template = "Positioned(child: %s)" },
      }

      local function get_visual_selection()
        -- Ensure we are getting the latest marks
        vim.cmd('noau normal! "vy"')
        return vim.fn.getreg('v')
      end

      local function wrap_with_widget(picker_choice, selection)
        if not selection or selection == "" then
          vim.notify("No selection found", vim.log.levels.WARN)
          return
        end

        local template = picker_choice.template
        local wrapped = string.format(template, selection)

        -- Replace the visual selection with the wrapped version
        -- We use 'gv' to re-select and then 'p' to paste
        vim.fn.setreg('v', wrapped)
        vim.cmd('normal! gv"vp')

        -- Format the code if conform is available
        local ok, conform = pcall(require, "conform")
        if ok then
          conform.format({ lsp_fallback = true, timeout_ms = 500 })
        end
      end

      map("v", "<leader>fw", function()
        local selection = get_visual_selection()

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
              local selected_entry = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              wrap_with_widget(selected_entry.value, selection)
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

        local Terminal = require("toggleterm.terminal").Terminal
        local test_term = Terminal:new({
          cmd = cmd,
          direction = "horizontal",
          close_on_exit = false,
          on_open = function(term)
            vim.cmd("startinsert!")
          end,
        })
        test_term:toggle()
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
        vim.lsp.buf.code_action()
      end, { desc = "Flutter: Code Actions" })

      map("v", "<leader>fc", function()
        vim.lsp.buf.code_action()
      end, { desc = "Flutter: Code Actions (visual)" })

      -------------------------------------------------------
      -- FLUTTER COMMAND KEYMAPS
      -------------------------------------------------------
      local function flutter_notify(msg)
        pcall(function()
          local notify = require("notify")
          notify(msg, vim.log.levels.INFO, {
            title = "Flutter",
            timeout = 3,
            icon = "🔥",
          })
        end)
      end

      local FLUTTER_TERM_ID = 1

      local function flutter_run_toggle()
        local toggleterm = require("toggleterm")
        local Term = require("toggleterm.terminal")

        local existing = Term.get(FLUTTER_TERM_ID)
        if existing then
          existing:toggle()
        else
          local flutter_term = Term.Terminal:new({
            id = FLUTTER_TERM_ID,
            cmd = "flutter run",
            direction = "float",
            float_opts = { border = "curved" },
            hidden = false, -- Open immediately on creation
            on_exit = function()
              vim.notify("Flutter stopped", vim.log.levels.INFO, { title = "Flutter" })
            end,
          })
          flutter_term:toggle()
        end
      end

      local function flutter_quit_toggle()
        local Term = require("toggleterm.terminal")
        local existing = Term.get(FLUTTER_TERM_ID)
        if existing then
          existing:shutdown()
        end
        pcall(function()
          vim.cmd("FlutterQuit")
        end)
      end

      local function flutter_reload()
        local Term = require("toggleterm.terminal")
        local existing = Term.get(FLUTTER_TERM_ID)
        if existing then
          existing:send("r")
          flutter_notify("Hot Reload Sent")
        else
          vim.cmd("FlutterReload")
        end
      end

      local function flutter_restart()
        local Term = require("toggleterm.terminal")
        local existing = Term.get(FLUTTER_TERM_ID)
        if existing then
          existing:send("R")
          flutter_notify("Hot Restart Sent")
        else
          vim.cmd("FlutterRestart")
        end
      end

      map("n", "<leader>ff", flutter_run_toggle, { desc = "Flutter Run (Toggle Terminal)" })
      map("n", "<leader>fD", "<cmd>FlutterDebug<CR>", { desc = "Flutter Debug" })

      -- Hot Reload on Save
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.dart",
        callback = function()
          flutter_reload()
        end,
        desc = "Auto Hot Reload Flutter on save",
      })

      map("n", "<leader>fR", flutter_restart, { desc = "Flutter Hot Restart" })

      map("n", "<leader>fd", function()
        flutter_notify("Loading Flutter devices...")
        vim.cmd("FlutterDevices")
      end, { desc = "Flutter Devices" })

      map("n", "<leader>fe", function()
        flutter_notify("Loading Flutter emulators...")
        vim.cmd("FlutterEmulators")
      end, { desc = "Flutter Emulators" })

      map("n", "<leader>fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "Flutter Outline" })
      map("n", "<leader>fl", "<cmd>FlutterLogToggle<CR>", { desc = "Flutter Logs" })

      map("n", "<leader>fq", flutter_quit_toggle, { desc = "Flutter Quit" })
      map("n", "<leader>ft", "<cmd>FlutterDevTools<CR>", { desc = "Flutter DevTools" })
    end,
  },
}
