return {
    'Vigemus/iron.nvim',
    config = function()
        local iron = require("iron.core")
        local view = require("iron.view")
        local common = require("iron.fts.common")

        iron.setup({
            config = {
                -- scratch_repl = true,
                repl_open_cmd = require("iron.view").split.horizontal.botright(0.3),
                repl_definition = {
                    python = {
                        command = { "ipython", "--no-autoindent" },
                        format = common.bracketed_paste_python,
                        block_deviders = { "# %%", "#%%" },
                    },
                    sh = {
                        -- Can be a table or a function that
                        -- returns a table (see below)
                        command = { "zsh" }
                    }
                }
            },
            keymaps = {
                send_motion = "<leader>sc",
                visual_send = "<leader>sc",
                send_file = "<leader>sf",
                send_line = "<leader>sl",
                send_until_cursor = "<leader>su",
                send_mark = "<leader>sm",
                mark_motion = "<leader>mc",
                mark_visual = "<leader>mc",
                remove_mark = "<leader>md",
                cr = "<leader>s<cr>",
                interrupt = "<leader>s<leader>",
                exit = "<leader>sq",
                clear = "<leader>cl",
            },
            -- If the highlight is on, you can change how it looks
            -- For the available options, check nvim_set_hl
            highlight = {
                italic = true
            },
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        })

        vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl<cr>')
        vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<cr>')
        vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
        vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')
    end
}
