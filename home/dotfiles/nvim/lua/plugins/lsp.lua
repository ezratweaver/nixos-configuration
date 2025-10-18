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
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.fn.expand("$VIMRUNTIME/lua"),   -- built-in Neovim runtime
                  vim.fn.stdpath("config") .. "/lua", -- config files
                  vim.fn.stdpath("data") .. "/lazy",  -- all Lazy-installed plugins
                },
              },
            },
          },
        },
        ts_ls = {},
        powershell_es = {},
        blueprint_ls = {}
      },
    },
  },
}
