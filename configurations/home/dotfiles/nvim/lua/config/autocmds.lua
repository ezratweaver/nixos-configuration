-- Hyprland config filetype detection
vim.filetype.add({
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    ["hyprland%.conf"] = "hyprlang",
  },
})
