return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = function(bufnr)
      return { async = true, lsp_fallback = true }
    end,
  },
}

