return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    -- Ensure clangd is installed via Mason
    ensure_installed = { "clangd" },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- Set up clangd with formatting capabilities
    require("lspconfig").clangd.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = function(client, bufnr)
        -- Enable formatting
        client.server_capabilities.documentFormattingProvider = true
        -- Keybinding to format the buffer
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, desc = "Format code" })
      end,
    })
  end,
}
