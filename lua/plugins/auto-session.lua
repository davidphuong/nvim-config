-- =============================================================================
-- plugins/auto-session.lua — Session management
-- =============================================================================
-- Auto-session automatically saves and restores your session per directory.
--
-- How it works:
--   - Open nvim in a project directory → session is restored automatically
--   - Close nvim → session is saved automatically
--   - Each directory gets its own session
--
-- Useful commands:
--   :AutoSession save    — manually save session
--   :AutoSession restore — manually restore session
--   :AutoSession delete  — delete session for current directory
--
-- Note: if nvim is opened with a file argument (nvim file.txt), auto-session
-- will not restore automatically — only when opened with no arguments or a
-- directory (nvim or nvim .)
-- =============================================================================

return {
  {
    "rmagatti/auto-session",
    lazy = false,            -- must load at startup to restore session
    config = function()
      require("auto-session").setup({
        log_level = "error", -- only show errors, not info messages
        auto_save = true,    -- save session automatically on exit
        auto_restore = true,
        pre_save_cmds = { "Neotree close" },    -- close neo-tree before saving session
        post_restore_cmds = { "Neotree show" }, -- reopen neo-tree after restoring session
      })
    end,
  },
}

