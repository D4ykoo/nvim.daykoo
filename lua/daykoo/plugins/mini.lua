return {
	-- [[mini.nvim]]
	-- Collection of various small plugins.
	--
	-- Load prettier icons.
	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {
			style = vim.g.have_nerd_font and "glyph" or "ascii",
		},
		init = function()
			-- backwards compatibility with plugins that require `nvim-web-devicons` like telescope.nvim
			require("mini.icons").mock_nvim_web_devicons()
		end,
	},
	-- Better Around/ Inside textobjects
	--
	-- Examples:
	--  - va)   [V]isually select [A]round [)]paren
	--  - yiiq  [Y]ank [I]nside [I]+1 [Q]uote
	--  - ci'   [C]hange [I]nside [']quote
	{
		"nvim-mini/mini.ai",
		opts = {
			mapping = {
				around_next = "aa",
				inside_next = "ii",
			},
			n_lines = 500,
		},
	},
	-- Add/delete/replace surroundings (brackets, quotes, etc.)
	--
	-- Examples:
	--  - saiw)     [S]urround [A]dd [I]nner [W]ord [)]Paren
	--  - sd'       [S]urround [D]elete [']quotes
	--  - sr)'       [S]urround [R]eplace [)] [']
	{
		"nvim-mini/mini.surround",
		opts = {},
		config = {},
	},
	-- Simple status line
	{
		"nvim-mini/mini.statusline",
		opts = {
			use_icons = vim.g.have_nerd_font,
			section_location = function()
				return "%2l:%-2v"
			end,
		},
	},
}
