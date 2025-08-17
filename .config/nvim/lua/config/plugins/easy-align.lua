return {
  "junegunn/vim-easy-align",
  keys = {
    { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy align" },
  },
  config = function()
    -- Set default left margin to 3 spaces for space delimiter
    vim.g.easy_align_delimiters = {
      [' '] = {
        pattern = ' ',
        left_margin = 0,  -- 3 spaces before each column
        right_margin = 0, -- no extra spaces after
      }
    }

    -- Optional: additional keymaps for common alignments
    vim.keymap.set({ "n", "x" }, "gA", "<Plug>(EasyAlign)", { desc = "Easy align (interactive)" })
  end,
}