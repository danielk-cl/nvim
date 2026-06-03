return {
    "nvim-telescope/telescope.nvim",

    tag = "v0.2.0",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                -- vimgrep_arguments = {
                    -- 'rg',
                    -- '--hidden',
                    -- '--no-heading',
                    -- '--no-ignore',
                -- }
            }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>Pf', function ()
            builtin.find_files({ no_ignore = true })
        end)
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>Ps', function ()
            builtin.live_grep({ no_ignore = true })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
