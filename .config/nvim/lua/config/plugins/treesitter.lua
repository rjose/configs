return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "typescript", "tsx", "javascript", "lua", "vim", "vimdoc", "ruby", "html", "css", "json" },
                auto_install = false,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                fold = {
                    enable = true,
                },
            })
        end,
    },
}