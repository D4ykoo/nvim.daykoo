-- ===============================
-- Options and configurations
-- ===============================

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- set `true`if nerd font is installed
vim.g.have_nord_font = true

-- See `:help vim.o`
-- For more options see `:help option-list`

-- Line numbers
vim.o.number = true

-- Relative, useful for jumping
vim.o.relativenumber = true

-- Mouse mode, useful for resizing etc.
vim.o.mouse = "a"
vim.o.showmode = false

-- Enable break indent
vim.o.breakindent = true

-- Enable smart indent
vim.o.smartindent = true

-- Enable undo/redo changes even after closing and reponing a file.
-- It saves lifes.
vim.o.undofile = true

-- -- Set default tab stop size.
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.opt.shiftwidth = 4 -- one indent level = 4
vim.opt.expandtab = true

-- Case-insensitive searching.
-- Unless there is \C or one or more capital letters in the search term.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default.
vim.o.signcolumn = "yes"

-- Decrease update time.
vim.o.updatetime = 50

-- Decrease mapped sequence wait time.
vim.o.timeoutlen = 300

-- Configure how new splits sould be opened.
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
-- Opens a preview buffer at the bottom.
vim.o.inccommand = "split"

-- Show which line the cursor is on.
vim.o.cursorline = true

-- Minimal numbr of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Diagnostic config
-- See `:help vim.diagnostic.Opts`
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	-- Text shows up at the end of the line
	virtual_text = true,
	-- Text shows up underneath the line
	-- virtual_lines = true,

	-- Auto open the float, so it can be read easily  when jumping with `[d` and `]d`
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})
