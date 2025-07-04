return {
    -- Git signs in the gutter
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 500,
                    ignore_whitespace = false,
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true})

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, {expr=true})

                    -- Actions
                    map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
                    map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
                    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage hunk' })
                    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset hunk' })
                    map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
                    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
                    map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
                    map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
                    map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = 'Blame line' })
                    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle blame' })
                    map('n', '<leader>hd', gs.diffthis, { desc = 'Diff this' })
                    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })
                    map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle deleted' })

                    -- Text object
                    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                    
                    -- Diff selection
                    map('v', '<leader>hd', function()
                        local start_line = vim.fn.line("'<")
                        local end_line = vim.fn.line("'>")
                        gs.diffthis('~1')
                    end, { desc = 'Diff selection' })
                end
            })
        end,
    },

    -- Git wrapper
    {
        'tpope/vim-fugitive',
        cmd = { 'Git', 'Gblame', 'Gdiffsplit', 'Gvdiffsplit' },
        keys = {
            { '<leader>gs', '<cmd>Git<cr>', desc = 'Git status' },
            { '<leader>gb', '<cmd>Git blame<cr>', desc = 'Git blame' },
            { '<leader>gd', '<cmd>Gdiffsplit<cr>', desc = 'Git diff split' },
            { '<leader>gc', '<cmd>Git commit<cr>', desc = 'Git commit' },
            { '<leader>gp', '<cmd>Git push<cr>', desc = 'Git push' },
            { '<leader>gl', '<cmd>Git log<cr>', desc = 'Git log' },
        },
    },

    -- LazyGit integration
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
}