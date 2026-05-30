-- =============================================================================
-- plugins/catppuccin.lua — Colorscheme
-- =============================================================================
-- Catppuccin is a warm, pastel dark theme.
-- Flavours: latte (light), frappe, macchiato, mocha (darkest)
-- =============================================================================

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",      -- needed because repo name is "nvim" which is ambiguous
    version = "v2.0.0",       -- pinned version — change deliberately when upgrading
    priority = 1000,          -- load before all other plugins so colours are set first
    config = function()
      require("catppuccin").setup({
        flavour = "latte",
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
