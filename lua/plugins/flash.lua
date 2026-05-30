-- =============================================================================
-- plugins/flash.lua — Quick cursor jumping
-- =============================================================================
-- Flash lets you jump to any word on screen by typing a few characters.
--
-- How it works:
--   1. Press the keymap to activate flash
--   2. Type 1-2 characters of the word you want to jump to
--   3. Flash highlights all matches with letter labels
--   4. Press the label letter — cursor jumps there instantly
--
-- Keymaps:
--   s — activate flash jump (normal mode)
-- =============================================================================

return {
  {
    "folke/flash.nvim",
    version = "v2.1.0",    -- pinned version — change deliberately when upgrading
    config = function()
      local flash = require("flash")

      flash.setup({
        -- only jump to visible matches on screen
        search = {
          multi_window = false, -- don't jump across splits
        },
        label = {
          uppercase = false,    -- labels are lowercase letters — easier to type
        },
        modes = {
          char = {
            enabled = false,    -- disable flash for f/F/t/T — use Vim defaults
          },
        },
      })

      -- Activate flash jump in normal mode
      vim.keymap.set("n", "s", function() flash.jump() end, { desc = "Flash: jump to word" })
    end,
  },
}
