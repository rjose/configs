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
                highlight_overrides = {
                    latte = function(colors)
                        return {
                            CursorLine = { bg = colors.surface0 },
                        }
                    end,
                },
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