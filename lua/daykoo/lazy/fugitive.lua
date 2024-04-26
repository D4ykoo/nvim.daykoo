-- plugin for git 
-- TODO: investigate if this workflow fits me or if there are other plugins

return {
    "tpope/vim-fugitive",

    vim.keymap.set("n", "<leader>gs", vim.cmd.Git) -- git status
    
    -- TODO: maybe something like git pull with --rebase
    -- TODO: maybe git push
    -- TODO: maybe git logs or diff
}
