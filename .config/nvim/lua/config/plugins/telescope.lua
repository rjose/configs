return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup({
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          selection_caret = "▶ ",
          entry_prefix = "  ",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "bottom",
              preview_width = 0.55,
              results_width = 0.8,
            },
          },
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key"
            }
          }
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          }
        }
      })
      
      -- Load fzf extension
      require('telescope').load_extension('fzf')
      

      -- Key mappings
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fn', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end, { desc = 'Edit neovim config' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope recent files' })
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Telescope commands' })
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope document symbols' })
    end,
  },
}
