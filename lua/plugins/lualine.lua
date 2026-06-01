-- =============================================================================
-- plugins/lualine.lua — Statusline
-- =============================================================================
-- Lualine shows useful info at the bottom of the screen:
--   left:   vim mode, git branch, file name, modified flag
--   middle: (empty)
--   right:  LSP diagnostics, file type, cursor position
--
-- Uses the catppuccin theme to match the colorscheme.
-- =============================================================================

return {
  {
    "nvim-lualine/lualine.nvim",
    version = "v3.0.0",               -- pinned version — change deliberately when upgrading
    dependencies = { "catppuccin/nvim" }, -- ensure catppuccin loads first
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin-latte",
          globalstatus = true,    -- single statusline across all splits
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              path = 1,  -- 0 = filename only, 1 = relative path, 2 = absolute path
            }
          },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
}
