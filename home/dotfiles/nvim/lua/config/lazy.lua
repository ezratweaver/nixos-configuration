local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Disable sql complete default keymaps
vim.g.omni_sql_no_default_maps = 1

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
    {
      'saghen/blink.cmp',
      opts = {
        keymap = {
          preset = 'super-tab',
          ['<Tab>'] = {
            function(cmp)
              if cmp.snippet_active() then return cmp.snippet_forward()
              else return cmp.select_next() end
            end,
            'fallback'
          },
          ['<S-Tab>'] = {
            function(cmp)
              if cmp.snippet_active() then return cmp.snippet_backward()
              else return cmp.select_prev() end
            end,
            'fallback'
          },
          ['<CR>'] = { 'accept', 'fallback' }
        }
      }
    },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "nordic", "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  lockfile = "~/nixos-configuration/home/dotfiles/nvim/lazy-lock.json", -- save lockfile in dotfiles directory
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
