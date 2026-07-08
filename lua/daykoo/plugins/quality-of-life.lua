return {
	{
		"folke/todo-comments.nvim",
		opts = {
			signs = false,
		},
	},
	{
		"NMAC427/guess-indent.nvim",
		opts = {},
	},
	{
		"mbbill/undotree",

		config = function()
			vim.keymap.set("n", "<leader><C-u>", vim.cmd.UndotreeToggle)
		end,
	},
}
