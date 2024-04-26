-- best fuzzy finder in the world

return {
    "nvim-telescope/telescope.nvim",
    
    tag = "0.1.6",

    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        require('telescope').setup({})
        
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        
        -- usefull to prevent searches in node modules, so it searches just the git files
        vim.keymap.set("n", "<C-p>", builtin.git_files, {}) 

        vim.keymap.set("n", "<leader>pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        -- project search with grep
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        -- help tags from treesitter
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end
}
