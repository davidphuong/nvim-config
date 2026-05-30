-- =============================================================================
-- init.lua — Entry point
-- =============================================================================
-- Neovim reads this file first. We keep it minimal: just import the core
-- modules and bootstrap the plugin manager. Nothing else lives here.
-- =============================================================================

require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Bootstrap lazy.nvim (plugin manager)
-- This block downloads lazy.nvim if it isn't already installed.
-- It will only run once — on a fresh machine or after wiping ~/.local/share/nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialise lazy.nvim — plugins live in lua/plugins/, one file per plugin.
-- To add a plugin: create lua/plugins/<name>.lua and return a lazy.nvim spec.
require("lazy").setup({
  spec = { import = "plugins" },
  change_detection = {
    notify = false, -- don't notify on config file changes
  },
})
