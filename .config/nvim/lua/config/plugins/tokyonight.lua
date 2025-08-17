return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    sidebars = "dark",
                    floats = "normal",
                },
                on_highlights = function(highlights, colors)
                    highlights.FloatBorder = {
                        fg = colors.blue,
                        bg = colors.bg_float,
                    }
                end,
            })
            -- vim.cmd.colorscheme("tokyonight")
        end,
    },
}