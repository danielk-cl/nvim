return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        'jay-babu/mason-nvim-dap.nvim',
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
    },
    keys = {
        -- Basic debugging keymaps, feel free to change to your liking!
        {
            '<F5>',
            function() require('dap').continue() end,
            desc = 'Debug: Start/Continue',
        },
        {
            '<F1>',
            function() require('dap').step_into() end,
            desc = 'Debug: Step Into',
        },
        {
            '<F2>',
            function() require('dap').step_over() end,
            desc = 'Debug: Step Over',
        },
        {
            '<F3>',
            function() require('dap').step_out() end,
            desc = 'Debug: Step Out',
        },
        {
            '<leader>b',
            function() require('dap').toggle_breakpoint() end,
            desc = 'Debug: Toggle Breakpoint',
        },
        {
            '<leader>B',
            function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
            desc = 'Debug: Set Breakpoint',
        },
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        {
            '<F7>',
            function() require('dapui').toggle() end,
            desc = 'Debug: See last session result.',
        },
        {
            "<leader>gb",
            function() require('dap').run_to_cursor() end,
            desc = 'Debug: Run to cursor',
        },
        -- Eval var under cursor
        {
            "<space>?",
            function() require("dapui").eval(nil, { enter = true }) end,
            desc = 'Debug: Evaluate',
        },
    },
    config = function()
        local dap = require "dap"
        local dapui = require("dapui")
        require("nvim-dap-virtual-text").setup({
            commented = true,
        })
        -- require("dap-go").setup()
        require("dap-python").setup("python3")

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'delve',
                'debugpy',
            },
        }

        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }


        -- Handled by nvim-dap-go
        -- dap.adapters.go = {
        --   type = "server",
        --   port = "${port}",
        --   executable = {
        --     command = "dlv",
        --     args = { "dap", "-l", "127.0.0.1:${port}" },
        --   },
        -- }

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close


        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}
