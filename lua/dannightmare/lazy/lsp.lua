return {
    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        opts = {
            ensure_installed = {
                "lua_ls", -- lua
                -- python
                "basedpyright",
                "pylsp",
                "clangd", -- C, C++, and more
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "L3MON4D3/LuaSnip",
            { "j-hui/fidget.nvim", opts = {} },
            "hrsh7th/cmp-nvim-lsp",
            {
                "SmiteshP/nvim-navic",
                dependencies = {
                    "neovim/nvim-lspconfig"
                },
                opts = { lsp = { auto_attach = true, preference = { "pylsp" } } },
            },
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } }
            }

        },

        config = function()
            vim.lsp.config('basedpyright', { settings = { basedpyright = { disableLanguageServices = true } } })
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
        end
    }
}
