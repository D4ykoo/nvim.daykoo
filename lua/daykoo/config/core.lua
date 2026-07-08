-- =========================================
-- CORE
-- settings, leaders, options
-- =========================================

--Enable faster
-- startup by caching compiled Lua modules
vim.loader.enable()

-- [[globals]]
-- See :help vim.g

-- See `:help mapleader`
-- Set <space> as leader key 
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- leader leader to "hot reload" nvim config
-- it actually just sources the current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

