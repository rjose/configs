return {
  "kelly-lin/ranger.nvim",
  config = function()
    require("ranger-nvim").setup({ 
      replace_netrw = true,
      ui = {
        border = "rounded",
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5
      }
    })
    vim.keymap.set("n", "<leader>ef", function()
      require("ranger-nvim").open(true)
    end, { desc = "Open ranger file manager" })
  end,
}