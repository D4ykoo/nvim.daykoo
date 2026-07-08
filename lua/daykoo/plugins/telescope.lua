-- [[ Fuzzy Finder (files, lsp, etc) ]]
--
-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		-- Requires make
		-- TODO:
		-- if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	opts = {
		defaults = {
			file_ignore_patterns = { "node_modules" },
		},
		extensions = {
			["ui-select"] = { require("telescope.themes").get_dropdown() },
		},
	},
	config = function()
		-- Load extensions
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- Set keymaps
		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[P]roject [F]iles" })
		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "[C-] [P]roject" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[ ] [F]ind existing [B]uffers" })

		-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
			callback = function(event)
				local buf = event.buf

				-- Find references for the word under the cursor.
				vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

				-- Jump to the implementation of the word under the cursor.
				-- Useful when the language has ways of declaring types without an actual implementation.
				vim.keymap.set(
					"n",
					"gri",
					builtin.lsp_implementations,
					{ buffer = buf, desc = "[G]oto [I]mplementation" }
				)

				-- Jump to the definition of the word under the cursor.
				-- This is where a variable was first declared, or where a function is defined, etc.
				-- To jump back, press, <C-t>.
				vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })

				-- Fuzzy find all the symbols in the current document.
				vim.keymap.set(
					"n",
					"g0",
					builtin.lsp_document_symbols,
					{ buffer = buf, desc = "Open Document Symbols" }
				)

				-- Fuzzy find all the symbols in the current workspace.
				vim.keymap.set("n", "gW", builtin.lsp_references, { buffer = buf, desc = "Open Workspace Symbols" })

				-- Jump to the type of the word under the cursor.
				-- Uesful when not sure what type a variable is.
				vim.keymap.set("n", "gW", builtin.lsp_references, { buffer = buf, desc = "Open Workspace Symbols" })
			end,
		})

		-- Override default beavior and theme when searching
		vim.keymap.set("n", "<leader>/", function()
			-- Pass additional configuration to Telescope
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Pass additional configuration options
		-- See `:help telescope.builtin_live_grep()`
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
				follow = true,
			})
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
