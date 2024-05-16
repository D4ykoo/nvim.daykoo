-- lines numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tab stops
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.scrolloff = 4
vim.opt.pumblend = 10
vim.opt.pumheight = 10

vim.opt.shiftround = true

-- usefull for e. g. LaTex
vim.opt.wrap = true
-- vim.opt.sidescrolloff = 8

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.smoothscroll = true
end

-- Create an autocmd group for Tex file settings
vim.api.nvim_create_augroup('TexLineWrap', { clear = true })

-- Set line wrapping and visual line navigation for .tex files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    vim.opt_local.wrap = true
    vim.api.nvim_buf_set_keymap(0, 'n', 'j', 'gj', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'k', 'gk', { noremap = true, silent = true })
  end,
  group = 'TexLineWrap'
})
