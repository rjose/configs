return {
    -- Debug Adapter Protocol
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            'theHamsta/nvim-dap-virtual-text',
            'suketa/nvim-dap-ruby',
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            -- Setup dap-ui
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                mappings = {
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                element_mappings = {},
                expand_lines = vim.fn.has("nvim-0.7") == 1,
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 0.25,
                        position = "bottom",
                    },
                },
                controls = {
                    enabled = true,
                    element = "repl",
                    icons = {
                        pause = "",
                        play = "",
                        step_into = "",
                        step_over = "",
                        step_out = "",
                        step_back = "",
                        run_last = "↻",
                        terminate = "□",
                    },
                },
                floating = {
                    max_height = nil,
                    max_width = nil,
                    border = "single",
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil,
                    max_value_lines = 100,
                },
            })

            -- Setup virtual text
            require("nvim-dap-virtual-text").setup({
                enabled = true,
                enabled_commands = true,
                highlight_changed_variables = true,
                highlight_new_as_changed = false,
                show_stop_reason = true,
                commented = false,
                only_first_definition = true,
                all_references = false,
                filter_references_pattern = '<module',
                virt_text_pos = 'eol',
                all_frames = false,
                virt_lines = false,
                virt_text_win_col = nil
            })

            -- Ruby DAP configuration
            dap.adapters.ruby = function(callback, config)
                callback {
                    type = "server",
                    host = "127.0.0.1",
                    port = "${port}",
                    executable = {
                        command = "bundle",
                        args = { "exec", "rdbg", "-n", "--open", "--port", "${port}",
                               "-c", "--", "ruby", config.program }
                    }
                }
            end

            dap.configurations.ruby = {
                {
                    type = "ruby",
                    name = "debug current file",
                    request = "attach",
                    localfs = true,
                    program = "${file}",
                },
                {
                    type = "ruby",
                    name = "run current spec file",
                    request = "attach",
                    localfs = true,
                    program = "bundle exec rspec ${file}",
                },
            }

            -- Automatically open/close UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Key mappings
            vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Debug continue' })
            vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Debug step over' })
            vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Debug step into' })
            vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Debug step out' })
            vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
            vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end, { desc = 'Set breakpoint' })
            vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'Set log point' })
            vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = 'Debug REPL' })
            vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = 'Debug run last' })
            vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
                require('dap.ui.widgets').hover()
            end, { desc = 'Debug hover' })
            vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
                require('dap.ui.widgets').preview()
            end, { desc = 'Debug preview' })
            vim.keymap.set('n', '<Leader>df', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end, { desc = 'Debug frames' })
            vim.keymap.set('n', '<Leader>ds', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end, { desc = 'Debug scopes' })
        end,
    },
}