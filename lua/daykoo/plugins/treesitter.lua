return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- must load early: config registers the FileType attach autocmd
	build = ":TSUpdate", -- keep parsers in lockstep with the plugin on every update
	config = function()
		require("nvim-treesitter").setup({})

		local parsers = { "bash", "diff", "luadoc", "vim" }
		require("nvim-treesitter").install(parsers)

		local function treesitter_try_attach(buf, language)
			if not vim.treesitter.language.add(language) then
				return
			end
			vim.treesitter.start(buf, language)
			-- If treesitter indentation is available, enable it (buffer-scoped:
			-- this can run inside an async install callback where the current
			-- buffer is no longer `buf`).
			local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil
			if has_indent_query then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		local available_parsers = require("nvim-treesitter").get_available()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf, filetype = args.buf, args.match
				local language = vim.treesitter.language.get_lang(filetype)
				if not language then
					return
				end
				local installed_parsers = require("nvim-treesitter").get_installed("parsers")
				if vim.tbl_contains(installed_parsers, language) then
					-- Parser present: attach immediately.
					treesitter_try_attach(buf, language)
				elseif vim.tbl_contains(available_parsers, language) then
					-- Parser known but not installed: install async, then attach.
					require("nvim-treesitter").install(language):await(function()
						treesitter_try_attach(buf, language)
					end)
				else
					-- Unknown to nvim-treesitter, but a parser may exist elsewhere
					-- on runtimepath (e.g. bundled with Neovim) — try anyway.
					treesitter_try_attach(buf, language)
				end
			end,
		})
	end,
}
