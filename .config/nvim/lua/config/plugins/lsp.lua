return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = {"vim%.uv" } },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- Lua LSP
      lspconfig.lua_ls.setup {}
      
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
      
      -- TypeScript/JavaScript LSP (disabled for Deno projects)
      lspconfig.ts_ls.setup({
        on_attach = setup_keymaps,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        root_dir = function(fname)
          local root = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname)
          if root then
            return nil -- Don't attach if Deno project
          end
          return lspconfig.util.root_pattern("package.json")(fname)
        end,
        single_file_support = false,
      })
      
      -- Deno LSP
      lspconfig.denols.setup({
        on_attach = setup_keymaps,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        init_options = {
          lint = true,
          unstable = true,
          suggest = {
            imports = {
              hosts = {
                ["https://deno.land"] = true,
                ["https://jsr.io"] = true,
              }
            }
          }
        }
      })
      
      -- Ruby LSP (Solargraph - commented out)
      -- lspconfig.solargraph.setup({
      --   on_attach = setup_keymaps,
      --   capabilities = vim.lsp.protocol.make_client_capabilities(),
      --   settings = {
      --     solargraph = {
      --       diagnostics = true,
      --       completion = true,
      --       hover = true,
      --       formatting = true,
      --       symbols = true,
      --       definitions = true,
      --       rename = true,
      --       references = true,
      --     }
      --   }
      -- })
      
      -- Ruby LSP
      lspconfig.ruby_lsp.setup({
        on_attach = setup_keymaps,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })
      
      -- HTML LSP
      lspconfig.html.setup({
        on_attach = setup_keymaps,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        filetypes = { "html", "erb", "eruby" },
      })
      
      -- CSS LSP
      lspconfig.cssls.setup({
        on_attach = setup_keymaps,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })
      
      -- Emmet LSP (HTML abbreviations)
      lspconfig.emmet_ls.setup({
        on_attach = setup_keymaps,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        filetypes = { "html", "css", "erb", "eruby" },
      })
    end
  }
}
