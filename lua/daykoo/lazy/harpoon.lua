-- note: when coming from harpoon 2: delete nvim data dir
-- lazy made some problems when not deleting 
-- rm -rf ~/.local/share/nvim
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        -- open list and add to list
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        -- select menu entry
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

        -- toggle previous & next buffers stored within harpoon list
        vim.keymap.set("n", "<C-S-K>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-J>", function() harpoon:list():next() end)

        -- quick replace menu entries, using *nearly* the same motions
        vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
        vim.keymap.set("n", "<leader><C-j>", function() harpoon:list():replace_at(2) end)
        vim.keymap.set("n", "<leader><C-k>", function() harpoon:list():replace_at(3) end)
        vim.keymap.set("n", "<leader><C-l>", function() harpoon:list():replace_at(4) end)
    end
}
