return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true

        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
        })

        vim.api.nvim_create_user_command('Explore', function(opts)
            require("nvim-tree.api").tree.open(
                {
                    find_file = true,
                    focus = opts.bang,
                })
        end, {
            bang = true,
            desc = "Open NvimTree and find the current file",
        })
    end
}
