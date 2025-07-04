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
            require('nvim-dap-virtual-text').setup({
                enabled = false,
                enabled_commands = true,
                highlight_changed_variables = true,
                highlight_new_as_changed = false,
                show_stop_reason = true,
                commented = false,
                only_first_definition = true,
                all_references = false,
                clear_on_continue = false,
                display_callback = function(variable, buf, stackframe, node, options)
                    if options.virt_text_pos == 'inline' then
                        return ' = ' .. variable.value
                    else
                        return variable.name .. ' = ' .. variable.value
                    end
                end,
            })

            -- Setup Ruby DAP
            require('dap-ruby').setup()
            
            -- Additional Rails-specific configuration
            dap.configurations.ruby = vim.list_extend(dap.configurations.ruby or {}, {
                {
                    type = 'ruby',
                    name = 'Attach to Rails (port 38698)',
                    request = 'attach',
                    host = '127.0.0.1',
                    port = 38698,
                    localfs = true,
                    cwd = '${workspaceFolder}',
                },
            })

            -- Copy Ruby configuration for ERB files
            dap.configurations.eruby = dap.configurations.ruby

            -- Auto open/close dap-ui
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
            vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
            vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
            vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
            vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
            vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>B', function()
                dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end, { desc = 'Debug: Set Conditional Breakpoint' })
            vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: Toggle UI' })
            vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug: Open REPL' })
            vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last' })
        end,
    },
}