-- Thank you @ThePrimeagen for sharing your nvim config
-- This config is based mainly on this one

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- netrw

-- great tip from @TJ in kickstart.nvim
-- disables the arrow keys
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- my own spice to disable also the ctrl movement with the arrow keys
-- which is like the default word jumping in like every editor
vim.keymap.set({'n', 'i'}, '<C-Left>', '<cmd>echo "Use b to move!!"<CR>')
vim.keymap.set({'n', 'i'}, '<C-Right>', '<cmd>echo "Use e or w to move!!"<CR>')
vim.keymap.set({'n', 'i'}, '<C-Up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set({'n', 'i'}, '<C-Down>', '<cmd>echo "Use j to move!!"<CR>')


-- GREAT thanks @ThePrimeagen
-- move: when highlighted lines move them up or down
-- works also with brackets
-- :m       move command
-- '>+1     > refers to last line of selection, +1 moves it down one line
-- <CR>     enter key to execute command
-- gv       selects previous visual selction
-- =        performs automtic indent or alignment of selection
-- gv       reselets lines again after alignment
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- to let J stay in place instead of hopping to the end
-- mz       marks the current cursor position with a mark named z
-- J        joins the curernt line with the line below it, merging them into one line
-- `z       moves the cursor back to the position marked by the z mark
vim.keymap.set("n", "J", "mzJ`z")

-- keeps the cursor in the middle when half page jumping up and down
-- zz       scrolls the current line to the center of the window
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in the middle while searching
-- n        search forward
-- N        search backward
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- when deleting and pasting the highlighted word which will be deleted
-- would be copied into the buffer when pasting
-- instead leader p yanks it into the void and is the original highlighted yanked
-- term is still available
-- e. g.
-- original: 
-- foo
-- bar
-- after leader p:
-- foo
-- foo foo foo 
-- without:
-- foo
-- foo bar bar
vim.keymap.set("x", "<leader>p", "\"_dP")

-- copy to system clipboard with leader Y
-- just incredible 
-- requirements: clipboard provider like xclip
--               when it does not work even though xclip is installed
--               reinstall
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete into void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- no multiple commands in ex mode
vim.keymap.set("n", "Q", "<nop>")

-- brings up menu that makes it possible to replace the highlighted work in every occurance
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- leader leader to "hot reload" nvim config
-- it actually just sources the current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)


-- here comes some programming language specific stuff e. g.
-- vim.keymap.set(
--     "n",
--     "<leader>ee",
--     "if err != nil {<CR>}<Esc>Oreturn err<Esc>"
-- )

-- auto closing paranthesis and brackets
-- vim.keymap.set("i", "(", "()<Left>")
-- vim.keymap.set("i", "{", "{}<Left>")
-- vim.keymap.set("i", "[", "[]<Left>")
