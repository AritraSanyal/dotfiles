return {
  "devswiftzone/swift.nvim",
  ft = "swift",
  config = function()
    require("swift").setup({
      enabled = true,

      features = {
        -- Project Detection
        project_detector = {
          enabled = true,
          auto_detect = true,        -- Auto-detect on buffer enter
          show_notification = false, -- Show notification when project detected
          cache_results = true,      -- Cache detection results
        },

        -- LSP Integration
        lsp = {
          enabled = true,
          auto_setup = true,      -- Automatically setup LSP
          sourcekit_path = nil,   -- Auto-detect if nil
          inlay_hints = true,     -- Enable inlay hints
          semantic_tokens = true, -- Enable semantic tokens
          on_attach = nil,        -- Custom on_attach function
          capabilities = nil,     -- Custom capabilities
          cmd = nil,              -- Custom command
          root_dir = nil,         -- Custom root_dir function
          filetypes = { "swift" },
          settings = {},
        },

        -- Target Manager
        target_manager = {
          enabled = true,
          cache_timeout = 60, -- Cache targets for 60 seconds
        },

        -- Build Runner
        build_runner = {
          enabled = true,
          auto_save = true,             -- Save all files before building
          show_output = true,           -- Show output in split window
          output_position = "botright", -- Position of output window
          output_height = 15,           -- Height of output window
          close_on_success = false,     -- Auto-close on successful build
          focus_on_open = false,        -- Focus output window when opened
        },

        -- Code Formatting
        formatter = {
          enabled = true,
          tool = nil,            -- Auto-detect: "swift-format" | "swiftformat"
          format_on_save = true, -- Format on save
          config_file = nil,     -- Auto-detect
        },

        -- Linting
        linter = {
          enabled = true,
          lint_on_save = true, -- Lint on save
          auto_fix = false,    -- Auto-fix issues
          config_file = nil,   -- Auto-detect
        },

        -- Xcode Integration
        xcode = {
          enabled = true,
          default_scheme = nil,    -- Default scheme to build
          default_simulator = nil, -- Default simulator
          show_output = true,      -- Show build output
          output_position = "botright",
          output_height = 15,
        },
      },

      log_level = "info",
    })
  end,
}
