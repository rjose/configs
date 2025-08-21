return {
  -- Enhanced refactoring operations
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup({
        prompt_func_return_type = {
          go = false,
          java = false,
          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        prompt_func_param_type = {
          go = false,
          java = false,
          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        printf_statements = {},
        print_var_statements = {},
      })
      
      -- Keymaps for refactoring operations
      vim.keymap.set("x", "<leader>re", ":Refactor extract ")
      vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
      vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
      vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
      vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
      vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
      vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
    end,
  },
  
  -- Live symbol renaming with preview
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup({
        cmd_name = "IncRename", -- the name of the command
        hl_group = "Substitute", -- the highlight group used for highlighting the identifier
        preview_empty_name = false, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
        show_message = true, -- whether to display a message after a successful rename
        input_buffer_type = nil, -- the type of the external input buffer to use (the only supported value is currently "dressing")
        post_hook = nil, -- callback to run after renaming, receives the result table (with old_name, new_name and buffer)
      })
      
      -- Keymap for live rename
      vim.keymap.set("n", "<leader>rn", ":IncRename ")
      -- Override default LSP rename with inc-rename
      vim.keymap.set("n", "<space>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
  },
}