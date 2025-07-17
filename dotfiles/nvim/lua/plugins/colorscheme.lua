return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg = "#191919",
              fg = "#BBBBBB",
              fg_dim = "#8E8E8E",
            },
            syn = {
              string = "#8BAE68",
              number = "#D68C67",
              constant = "#61ABDA",
              identifier = "#8E8E8E",
              statement = "#CF86C1",
              fun = "#65B8C1",
              operator = "#E8838F",
              keyword = "#DE6E7C",
              type = "#B279A7",
              regex = "#819B69",
              deprecated = "#8E8E8E",
            },
            diff = {
              add = "#8BAE68",
              delete = "#E8838F",
              change = "#D68C67",
              text = "#61ABDA",
            },
            diag = {
              error = "#E8838F",
              warn = "#D68C67",
              info = "#61ABDA",
              hint = "#65B8C1",
            },
          },
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
    },
  },
}
