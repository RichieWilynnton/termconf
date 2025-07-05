return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {  
      "clangd",           -- for c/c++ language server  
      "clang-format",     
      "cmake-language-server",  
      "gitleaks",  
      "lua-language-server",  
      "ocamlformat",  
      "coq-lsp",          -- Coq language server  
    },  
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  config = function()
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, { desc = "Go to Definition (LSP)" })
    -- Enable LSP capabilities (for autocompletion)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Configure clangd
    require("lspconfig").clangd.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, desc = "Format code" })
      end,
    })

    -- Configure Coq LSP
    require("lspconfig").coq_lsp.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>lp", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show Coq proof info" })
      end,
    })
  end,
}
