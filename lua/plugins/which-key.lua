-- =============================================================================
-- plugins/which-key.lua — Keybinding popup
-- =============================================================================
-- Which-key shows a popup of available keybindings as you type.
-- Press Space and wait ~300ms — a panel appears showing all leader keymaps.
-- Keep typing and it narrows down. Press Esc to dismiss.
--
-- Also works for other prefixes: g, z, [, ], Ctrl+w, etc.
--
-- No keymaps needed — it hooks into Neovim's keymap system automatically.
-- =============================================================================

return {
  {
    "folke/which-key.nvim",
    version = "v3.17.0",     -- pinned version — change deliberately when upgrading
    event = "VeryLazy",      -- load after startup so it doesn't slow down launch
    config = function()
      local wk = require("which-key")

      wk.setup({
        preset = "classic",  -- classic popup style
        delay = 300,         -- ms to wait before showing popup (matches your timeoutlen)
        icons = {
          mappings = false,  -- disable icons — no Nerd Font installed yet
        },
      })

      -- Register group names so the popup shows readable labels
      -- instead of just listing raw keymaps
      wk.add({
        { "<leader>f", group = "find (Telescope)" },
        { "<leader>b", group = "buffer" },
      })
    end,
  },
}
