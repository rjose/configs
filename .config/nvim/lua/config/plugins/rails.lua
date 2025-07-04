return {
    -- Essential Rails plugin
    {
        "tpope/vim-rails",
        ft = { "ruby", "eruby" },
        dependencies = {
            "tpope/vim-bundler",
            "tpope/vim-rake",
        },
    },
    
    -- File navigation for Rails
    {
        "tpope/vim-projectionist",
        ft = { "ruby", "eruby" },
    },
    
    -- Test runner
    {
        "vim-test/vim-test",
        ft = { "ruby", "eruby" },
        config = function()
            -- Test strategy
            vim.g["test#strategy"] = "neovim"
            
            -- Key mappings for tests
            vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Test nearest" })
            vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Test file" })
            vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { desc = "Test suite" })
            vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Test last" })
            vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Test visit" })
        end,
    },
}