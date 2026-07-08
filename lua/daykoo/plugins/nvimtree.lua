-- The use of `nvim-tree` as file explorer is highly opinionated but sometimes
-- it does provide a better overview about big and bloated projects which makes
-- it easier to remeber directory structures.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	"nvim-tree/nvim-tree.lua",
	lazy = true,
	enabled = true,
	cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" }, -- load on these commands
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		disable_netrw = true,
		hijack_netrw = true,
		update_cwd = true,
		view = { width = 30, side = "left" },
		git = { enable = true, ignore = false },
		renderer = {
			icons = { show = { file = true, folder = true, git = true } },
		},
	},
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
		{ "<leader>r", "<cmd>NvimTreeRefresh<cr>", desc = "Refresh NvimTree" },
	},
}
