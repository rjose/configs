return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "day",
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
                    
                    -- Enhanced git diff colors for better readability
                    highlights.DiffAdd = {
                        bg = "#dcfce7",  -- Very light green background
                        fg = "#166534",  -- Dark green text
                    }
                    highlights.DiffDelete = {
                        bg = "#fef2f2",  -- Very light red background  
                        fg = "#dc2626",  -- Bright red text
                    }
                    highlights.DiffChange = {
                        bg = "#fef3c7",  -- Very light yellow background
                        fg = "#92400e",  -- Dark orange text
                    }
                    highlights.DiffText = {
                        bg = "#fed7aa",  -- Light orange background
                        fg = "#9a3412",  -- Dark orange text
                        bold = true,
                    }
                    
                    -- Terminal colors for better git integration
                    highlights.Terminal = {
                        bg = colors.bg,
                        fg = colors.fg,
                    }
                end,
            })
            vim.cmd.colorscheme("tokyonight")
        end,
    },
}
