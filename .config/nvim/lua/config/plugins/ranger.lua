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
    
    -- Set darker background for ranger terminal windows
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*ranger*",
      callback = function()
        vim.api.nvim_set_hl(0, "RangerNormal", { bg = "#0f0f0f", fg = "#e0e0e0" })
        vim.wo.winhighlight = "Normal:RangerNormal"
      end,
    })
    
    vim.keymap.set("n", "<leader>ef", function()
      require("ranger-nvim").open(true)
    end, { desc = "Open ranger file manager" })
  end,
}