--[[ function ColorMyPencils(color)
    color = color or "catppuccin"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none" })

end ]]

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
                }
            })
                vim.cmd("colorscheme catppuccin")
        end
    },
}
