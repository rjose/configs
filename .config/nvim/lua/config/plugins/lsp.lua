return {
  {
    "neovim/nvim-lspconfig",
    enabled = false, -- Temporarily disable LSP
    dependencies = {
      "folke/lazydev.nvim",
      "b0o/schemastore.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- Get nvim-cmp capabilities if available
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      if has_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end
      
      -- Common LSP keymaps function
      local function setup_keymaps(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
        
        -- Format on save for this buffer
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end
      
      -- Lua LSP
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = setup_keymaps,
      }
      
      -- TypeScript LSP
      lspconfig.tsserver.setup {
        capabilities = capabilities,
        on_attach = setup_keymaps,
      }
      
      -- Ruby LSP (using solargraph)
      lspconfig.solargraph.setup {
        capabilities = capabilities,
        on_attach = setup_keymaps,
      }
      
      -- JSON LSP
      local json_settings = {
        json = {
          validate = { enable = true },
        },
      }
      
      -- Add schemastore schemas if available
      local has_schemastore, schemastore = pcall(require, 'schemastore')
      if has_schemastore then
        json_settings.json.schemas = schemastore.json.schemas()
      end
      
      lspconfig.jsonls.setup {
        capabilities = capabilities,
        on_attach = setup_keymaps,
        settings = json_settings,
      }
    end,
  }
}