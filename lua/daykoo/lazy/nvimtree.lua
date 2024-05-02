-- uncomment line 2, 3 when using nvim-tree
-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

return {
   "nvim-tree/nvim-tree.lua",
    -- if it does not work when uncomment .setup()
    -- set it to false
    lazy = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- uncomment to enable nvim-tree
        -- require("nvim-tree").setup{ }
    end,
}
