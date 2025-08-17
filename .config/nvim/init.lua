require("config.lazy")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- Clear search highlights with ESC
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

-- Edit file in current directory
vim.keymap.set("n", "<leader>e", ":e %:h/", { desc = "Edit file in current directory" })

vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true

vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.opt.updatetime = 500
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  command = "checktime",
  pattern = { "*" },
})

-- Show diagnostics inline
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- vim.opt.foldcolumn = "1"

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Use indent folding for ERB files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "eruby", "erb" },
  callback = function()
    vim.opt_local.foldmethod = "indent"
  end,
})

-- Configure quickfix to open on the left side
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.cmd("wincmd H")
  end,
})

-- Customize diff colors for git hunks and fold highlighting
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2d4a2c", fg = "#a6e3a1" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#3a3a2e", fg = "#f9e2af" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#4a2d2d", fg = "#f38ba8" })
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#4a4a2e", fg = "#f9e2af" })

    -- Better fold highlighting
    vim.api.nvim_set_hl(0, "Folded", { bg = "#1e1e2e", fg = "#89b4fa", italic = true })
    vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE", fg = "#6c7086" })

    -- Subtle current line highlight (commented out for light theme)
    -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#262638" })

    -- Make window borders more visible
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#89b4fa", bold = true })
    vim.api.nvim_set_hl(0, "VertSplit", { fg = "#89b4fa", bold = true })

    -- Make statuslines more visible
    vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { bg = "#45475a", fg = "#cdd6f4" })
    -- Try setting all mini.statusline sections with background
    vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { bg = "#89b4fa", fg = "#1e1e2e" })
    -- vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { bg = "#89b4fa", fg = "#1e1e2e" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#89b4fa", fg = "#1e1e2e" })

    -- Harmonizing current line highlight (commented out for light theme)
    -- -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3a3a2e" })
  end,
})

-- Apply immediately (commented out for light theme)
-- vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2d4a2c", fg = "#a6e3a1" })
-- vim.api.nvim_set_hl(0, "DiffChange", { bg = "#3a3a2e", fg = "#f9e2af" })
-- vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#4a2d2d", fg = "#f38ba8" })
-- vim.api.nvim_set_hl(0, "DiffText", { bg = "#4a4a2e", fg = "#f9e2af" })

-- Apply fold highlighting immediately (commented out for light theme)
-- vim.api.nvim_set_hl(0, "Folded", { bg = "#1e1e2e", fg = "#89b4fa", italic = true })
-- vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE", fg = "#6c7086" })

-- Apply current line highlight immediately (commented out for light theme)
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#313244" })

-- Tmux focus-responsive background dimming (commented out for light theme)
-- vim.api.nvim_create_augroup("TmuxFocusBackground", { clear = true })
-- vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
--   group = "TmuxFocusBackground",
--   callback = function()
--     -- Active: use dark charcoal background (matches your preferred color)
--     vim.api.nvim_set_hl(0, "Normal", { bg = "#1a1a1a" })
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "FocusLost" }, {
--   group = "TmuxFocusBackground",
--   callback = function()
--     -- Inactive: use dimmed background (matches tmux inactive pane)
--     vim.api.nvim_set_hl(0, "Normal", { bg = "#303030" })
--   end,
-- })

-- Only show cursor line in active window
vim.api.nvim_create_augroup("CursorLineOnlyInActiveWindow", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = "CursorLineOnlyInActiveWindow",
  callback = function()
    vim.wo.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = "CursorLineOnlyInActiveWindow",
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- Apply window border highlighting immediately
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#89b4fa", bold = true })
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#89b4fa", bold = true })

-- Apply statusline highlighting immediately
vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { bg = "#45475a", fg = "#cdd6f4" })
vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { bg = "#89b4fa", fg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "#89b4fa", fg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { bg = "#89b4fa", fg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#89b4fa", fg = "#1e1e2e" })
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3a3a2e" })

-- Custom fold text function for better fold display
vim.opt.fillchars = {
  fold = " ",
  foldopen = "-",
  foldclose = "+",
  foldsep = " ",
}

function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local fold_text = string.format("  %s lines: %s", line_count, line:gsub("^%s*", ""))
  return fold_text
end

vim.opt.foldtext = "v:lua.custom_fold_text()"

-- Ensure treesitter folding for TypeScript files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})

-- JSON folding configuration
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.opt_local.foldmethod = "syntax"
  end,
})

-- Save file and go to normal mode
vim.keymap.set({'n', 'i', 'v'}, '<C-s>', '<Esc>:w<CR>', { desc = 'Save file and go to normal mode' })

-- Scratch buffer command
vim.api.nvim_create_user_command('Scratch', function()
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
end, { desc = 'Create a scratch buffer that can be closed without saving' })