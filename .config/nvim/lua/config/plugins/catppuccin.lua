return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = false,
                integrations = {
                    dap = { enabled = true, enable_ui = true },
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}