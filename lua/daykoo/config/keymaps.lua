-- ==================================
-- Basic, non-plugin related keymaps
-- See `:help vim.keymap.set()`
-- ==================================

-- Clear highlights on search when pressing <Esc> in normal mode
-- See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- QuiDiagnostic opening
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list'})

-- Remap terminal mode closing from <C-\><C-n>
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Make split navigation easier.
-- CTRL+<hjkl> to switch between windows.
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move selected lines in visual move up or down.
-- Explaination:
--   :m		move command
--   '>+1`	>` refers to the last line of selection, +1 moves it down one line
--   <CR>	carriage return -> execute command after it
--   gv		selects previous visual selection
--   = 		performs automatic indent or alignment of the selection
--   gv		reselects lines again, since the `=` resets the visual mode selection 
-- Thanks @ThePrimeagen for this 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- [[Keep cursor in the middle]]
--  Let J stay in place instead of hoping to the end between the linebreaks.
--  Explaination:
--    mz	marks the current cursor position with z
--    J		joins the current line with the line below
--    `z	moves the cursor back to the position marked by the z mark
vim.keymap.set("n", "J", "mzJ`z")

-- Keeps the cursor in the middle when half page jumping up and down.
-- Makes it easier to follow the cursor by just having to look at the center.
-- Explaination:
--   zz		scrolls the current line to the center of the window
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- TODO 
-- Do the same for the searching, keep the cursor in the middle.
--   n		search forward
--   N		search backward
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "nzzzv")

-- When deleting and pasting highlighted words, they will be copied into the yank buffer when pasting over it.
-- Instead this one will yanks it into the void and the original yanked value is still available.
vim.keymap.set("x", "<leader>p", "\"_dP")

-- delete into void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")


-- Brings up menu that makes it possible to replace the current word the cursor is at in every occurance.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
