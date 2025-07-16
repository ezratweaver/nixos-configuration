return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type vim.diagnostic.Opts
      diagnostics = {
        update_in_insert = true,
      },
      servers = {
        prismals = {},
        clangd = {},
        sqlls = {},
        pyright = {},
        gopls = {},
      },
    },
  },
}
