return {
	-- =====================================================================================
	-- Completion + snippts
	-- =====================================================================================
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "L3MON4D3/LuaSnip" },
		opts = {
			-- See `:help ins-completion`
			keymap = { preset = "default" }, -- see `:help ins-completion`
			appearance = { nerd_font_variant = "mono" },
			completion = {
				-- Show documentation with <C-space>.
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},
			sources = { default = { "lsp", "path", "snippets" } },
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "lua" }, -- 'prefer_rust' if you build the matcher
			signature = { enabled = true },
		},
	},
	-- =====================================================================================
	-- Formatting
	-- =====================================================================================
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = { "n", "v" },
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = function(bufnr)
				local enable_filetypes = { lua = true, rust = true }
				if enable_filetypes[vim.bo[bufnr].filetype] then
					return { timeout_ms = 500 }
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
			},
		},
	},
	-- =====================================================================================
	-- LSP
	-- =====================================================================================
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim", -- name mapping for tool-installer; no setup needed
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Provides an LSP UI, showing animated notifications about LSP progress.
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp", -- ensures blink loads first (full spec lives above)
		},
		config = function()
			-- Make sure default lsps are installed AND enabled
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"gopls",
				},
				automatic_enable = true,
			})
			-- =========================================================================
			-- Gets run when an LSP attaches to a particular buffer.
			-- Every time a new file is opened that is associated with an LSP
			-- (e.g. main.rs is associated with `rust_analyzer`) this function
			-- runs to configure the current buffer. It also adds the LSP keymaps.
			--
			-- It fires once per buffer<->server attachment (not once globally)
			-- because everything it sets is buffer-local: note the `buffer = event.buf`
			-- on every keymap and highlight autocmd below. Different buffers attach to
			-- different servers, and a keymap like `grn` only makes sense in a buffer
			-- that actually has an LSP, so it's scoped there rather than defined globally.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("daykoo-lsp-attach", { clear = true }),
				callback = function(event)
					-- Define key mappings specific to LSP items each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under the cursor.
					-- Most LSPs support renaming across files, etc.
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually the cursor needs to be
					-- on top of a suggestion from the LSP for this to activate.
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

					-- This is a Goto Declaration - not definition.
					-- E.g. in C this will take you to the header.
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following autocommands highlight references of the word
					-- under the cursor when the cursor rests there a little while.
					-- See `:help CursorHold`.
					--
					-- When moving the cursor, the highlights are cleared by the
					-- second autocommand.
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/documentHighlight", event.buf) then
						local highlight_augroup = vim.api.nvim_create_augroup("daykoo-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("daykoo-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "daykoo-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Create a keymap to toggle inlay hints in the code if the
					-- language supports it.
					if client and client:supports_method("textDocument/inlayHint", event.buf) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Broadcast blink's completion capabilities to every server so
			-- servers know the client can do snippets, resolve support, etc.
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- =========================================================================
			-- Default language servers
			-- =========================================================================
			-- These will automatically get installed (see mason-tool-installer below).
			-- See `:help lsp-config`.
			---@type table<string, vim.lsp.Config>
			local servers = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
				rust_analyzer = {},
				-- Special config as recommended by the neovim help docs.
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							-- NOTE: pulling the full runtime via nvim_get_runtime_file is
							-- a lot slower and causes issues when working on your own
							-- config. VIMRUNTIME + the `vim` global covers the common case.
							-- See https://github.com/neovim/nvim-lspconfig/issues/3189
							workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
							diagnostics = { globals = { "vim" } },
							-- Disable formatting, it is done by stylua.
							format = { enable = false },
						},
					},
				},
			}

			-- =========================================================================
			-- LSP helper tooling
			-- =========================================================================
			-- Automatically install LSPs and related tools.
			-- Ensure the servers above, plus any extra tools (formatters/linters),
			-- are installed.
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, {
				"stylua", -- Lua formatter (a tool, not an LSP -> lives here, not in `servers`)
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- Register and enable each server with its capabilities.
			for name, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(name, config)
				vim.lsp.enable(name)
			end
		end,
	},
}
