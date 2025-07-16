-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local setKeyMap = vim.keymap.set
local deleteKeyMap = vim.keymap.del
local opts = { silent = true, noremap = true }
local function yank_until_newline()
  vim.cmd("normal! y/\n")
end

vim.api.nvim_set_option("clipboard", "unnamedplus")

setKeyMap("n", "<S-4>", ":lua yank_until_newline()<CR>", opts)
