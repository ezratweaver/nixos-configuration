local lua_ls_path = vim.fn.trim(vim.fn.system("which lua-language-server")) -- Find the NixOS linked executable for the lua lsp

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = true,
      },
      servers = {
        prismals = {},
        clangd = {},
        sqlls = {},
        pyright = {},
        gopls = {},
        lua_ls = {
          cmd = { lua_ls_path }, -- dynamically using the path found by which
        },
        ts_ls = {},
        powershell_es = {},
      },
    },
  },
}

