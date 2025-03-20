return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- mason for lsp management -> easy install
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- cmp: completion engine plugin 
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",

        -- snipptes: required for cmp
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
},

    config = function()
        -- globals
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )


        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                -- the daily  
                "lua_ls",
                "rust_analyzer",
                "gopls",
                -- c/ c++ 
                -- "clangd",
                -- "cmake",
                -- the shit
                -- "html",
                -- "htmx",
                -- "tailwindcss",
                -- "cssls",
                -- "tsserver",
                -- "angularls",
                -- "eslint",
                -- other stuff like md, toml, json, yml... 
                -- "marksman",
                -- "taplo",
                -- "jsonls",
            },
            automatic_installation = true,
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        -- cmp
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            -- Required
            -- different snippet engines possible
            -- native nvim: vim.snippet.expand(args.body)
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-j>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-k>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                -- TODO: maybe abort
                ['<C-Space'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
