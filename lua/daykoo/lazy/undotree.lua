return {
    "mbbill/undotree",

    config = function()
        vim.keymap.set("n", "<leader>u",":wincmd w", vim.cmd.UndotreeToggle)
    end
}
