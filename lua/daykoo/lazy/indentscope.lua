-- for the nice little animations 
-- default: not enabled
-- why? since i only need it for web dev i toggle it 
return {
    "echasnovski/mini.indentscope",
    opts = {
        symbol = "│",
        options = { try_as_border = true },
    },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help",
                "lazy",
                "mason",
            },
            callback = function()
                vim.b.miniindentscope_disable = true
                vim.g.miniindentscope_disable = true
            end,
        })

        vim.b.miniindentscope_disable = true
        vim.g.miniindentscope_disable = true

        vim.keymap.set("n", "<leader>lh", function() vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable end)
    end,
}
