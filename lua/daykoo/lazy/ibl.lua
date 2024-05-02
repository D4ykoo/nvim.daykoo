-- for indent lines
-- default: disabled
-- why? it can be sometimes usefull but i  
-- currently do not want it as default
return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            char = "|",
        },
        scope = { enabled = false },
        exclude = {
            filetypes = {
                "help",
                "lazy",
                "mason",
            }
        },
    },
    config = function()
        require("ibl").setup {
        }
        vim.keymap.set("n", "<leader>ll", vim.cmd.IBLToggle)

        require("ibl").overwrite {
            enabled = false,
        }
    end,
}

