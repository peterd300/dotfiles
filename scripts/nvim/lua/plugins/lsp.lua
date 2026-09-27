return {
  {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" }, -- bashls comes from xbps
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "K", vim.lsp.buf.hover, "LSP: Hover docs")
        map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
        map("n", "gr", vim.lsp.buf.references, "LSP: References")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
        map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "LSP: Format buffer")
        map("n", "<leader>cd", vim.diagnostic.open_float, "LSP: Show diagnostic")
        map("n", "[d", vim.diagnostic.goto_prev, "LSP: Previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "LSP: Next diagnostic")
      end

      vim.lsp.config("bashls", { on_attach = on_attach })
      vim.lsp.enable("bashls")

      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })
      vim.lsp.enable("lua_ls")
    end,
  },
}
