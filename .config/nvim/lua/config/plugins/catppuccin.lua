return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "latte", -- latte, frappe, macchiato, mocha
                transparent_background = false,
                integrations = {
                    dap = { enabled = true, enable_ui = true },
                    nvimtree = true,
                    telescope = {
                        enabled = true,
                        style = "nvchad"
                    },
                    treesitter = true,
                },
            })
            -- vim.cmd.colorscheme("catppuccin")
        end,
    },
}