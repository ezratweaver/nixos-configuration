local lua_ls_path = vim.fn.trim(vim.fn.system("which stylua")) -- Find the NixOS linked executable for the lua formatter

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["astro"] = { "prettierd" },
        ["javascript"] = { "prettierd" },
        ["javascriptreact"] = { "prettierd" },
        ["typescript"] = { "prettierd" },
        ["typescriptreact"] = { "prettierd" },
        ["vue"] = { "prettierd" },
        ["css"] = { "prettierd" },
        ["scss"] = { "prettierd" },
        ["less"] = { "prettierd" },
        ["html"] = { "prettierd" },
        ["json"] = { "prettierd" },
        ["jsonc"] = { "prettierd" },
        ["yaml"] = { "prettierd" },
        ["markdown"] = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        ["graphql"] = { "prettierd" },
        ["handlebars"] = { "prettierd" },
        ["nix"] = { "nixfmt-rfc-style" },
        ["python"] = { "black" },
        ["lua"] = { lua_ls_path }
      },
    },
  },
}
