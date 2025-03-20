return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,

        config = function()
            require('catppuccin').setup({
                flavour = "mocha",
                transparent_background = true,
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    treesitter = true,
                    mason = true,
                }
            })
                vim.cmd("colorscheme catppuccin")
        end
    },
}
