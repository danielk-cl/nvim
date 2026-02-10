return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            dependencies = {
                "mason-org/mason.nvim",
                opts = {}
            },
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = {
                    "lua_ls",        -- lua
                    "rust_analyzer", -- rust
                    -- "gopls",         -- golang
                    -- python
                    "basedpyright",
                    "pylsp",
                    "clangd", -- C, C++, and more
                },
                -- handlers = {
                --     function(server_name) -- default handler (optional)
                --         require("lspconfig")[server_name].setup {
                --             capabilities = capabilities
                --         }
                --     end,
                --
                --     ["clangd"] = function()
                --         local lspconfig = require("lspconfig")
                --         lspconfig.clangd.setup {
                --             capabilities = capabilities,
                --             cmd = { "clangd", "--background-index", "--clang-tidy" },
                --             filetypes = { "c", "cpp", "h", "hpp" },
                --             root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt"),
                --         }
                --     end,
                --
                --     ["lua_ls"] = function()
                --         local lspconfig = require("lspconfig")
                --         lspconfig.lua_ls.setup {
                --             capabilities = capabilities,
                --             settings = {
                --                 Lua = {
                --                     runtime = { version = "Lua 5.1" },
                --                     diagnostics = {
                --                         globals = { "vim", "it", "describe", "before_each", "after_each" },
                --                     }
                --                 }
                --             }
                --         }
                --     end,
                --
                --     ["basedpyright"] = function()
                --         local lspconfig = require("lspconfig")
                --
                --         lspconfig.basedpyright.setup {
                --             capabilities = capabilities,
                --             on_attach = function(client, bufnr)
                --                 client.server_capabilities.definitionProvider = false
                --                 client.server_capabilities.referencesProvider = false
                --             end
                --         }
                --     end
                -- }
            },
        },
        "L3MON4D3/LuaSnip",
        {
            "j-hui/fidget.nvim",
            opts = {}
        },
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
        vim.lsp.config('basedpyright', { settings = { basedpyright = { disableLanguageServices = true } } } )
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
