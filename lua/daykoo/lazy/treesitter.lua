return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "c", "lua", "rust", "go", "bash",
            },

            sync_install = false,

            -- automatically install missing parsers when entering buffer
            -- only works with tree sitter cli
            auto_install = true,

            indent = {
                enable = true,

                additional_vim_regex_highlighting = { "markdown" },
            },
        })

    local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        treesitter_parser_config.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = {"src/parser.c", "src/scanner.c"},
                branch = "master",
            },
        }

        vim.treesitter.language.register("templ", "templ")
    end
}
