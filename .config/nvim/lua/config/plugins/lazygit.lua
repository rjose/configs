return {
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
  config = function()
    -- Simple terminal fallback mapping
    vim.keymap.set("n", "<leader>lg", function()
      -- Try the plugin first, fallback to terminal
      local ok = pcall(vim.cmd, "LazyGit")
      if not ok then
        vim.cmd("terminal lazygit")
      end
    end, { desc = "LazyGit" })
    
    -- Alternative: direct terminal mapping
    vim.keymap.set("n", "<leader>lgt", ":terminal lazygit<CR>", { desc = "LazyGit in terminal" })
    
    -- Floating terminal for lazygit
    vim.keymap.set("n", "<leader>lgg", function()
      vim.cmd("tabnew")
      vim.cmd("terminal lazygit")
      vim.cmd("startinsert")
    end, { desc = "LazyGit in new tab" })
  end,
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  }
}
