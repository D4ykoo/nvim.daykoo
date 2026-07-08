return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = {},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		-- use telescope
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		-- open list and add to list
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)

		-- toggle harpoon builtin list
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- toogle harpoon as telescope list
		vim.keymap.set("n", "<leader><C-e>", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon window" })

		-- select menu entry
		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-j>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-k>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-l>", function()
			harpoon:list():select(4)
		end)

		-- toggle previous & next buffers stored within harpoon list
		vim.keymap.set("n", "<C-S-K>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-J>", function()
			harpoon:list():next()
		end)

		-- quick replace menu entries, using *nearly* the same motions
		vim.keymap.set("n", "<leader><C-h>", function()
			harpoon:list():replace_at(1)
		end)
		vim.keymap.set("n", "<leader><C-j>", function()
			harpoon:list():replace_at(2)
		end)
		vim.keymap.set("n", "<leader><C-k>", function()
			harpoon:list():replace_at(3)
		end)
		vim.keymap.set("n", "<leader><C-l>", function()
			harpoon:list():replace_at(4)
		end)
	end,
}
