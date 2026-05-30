-- =============================================================================
-- plugins/gitsigns.lua — Git integration
-- =============================================================================
-- Gitsigns shows git diff indicators in the sign column (left gutter):
--   + added lines
--   ~ changed lines
--   - deleted lines
--
-- Also provides:
--   - inline git blame on the current line
--   - hunk navigation (jump between changes)
--   - stage/reset individual hunks without leaving Neovim
--   - diff view of current file against last git commit
--
-- No external dependencies — uses Neovim's built-in diff and git directly.
--
-- Keymaps:
--   ]h          — jump to next hunk
--   [h          — jump to previous hunk
--   <leader>gb  — toggle inline git blame
--   <leader>gp  — preview hunk
--   <leader>gs  — stage hunk
--   <leader>gr  — reset hunk
--   <leader>gd  — diff current file against last commit
--   <leader>gx  — exit diff mode and close temp buffer
-- =============================================================================

return {
  {
    "lewis6991/gitsigns.nvim",
    version = "v2.1.0",      -- pinned version — change deliberately when upgrading
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup({
        signs = {
          add          = { text = "+" },
          change       = { text = "~" },
          delete       = { text = "-" },
          topdelete    = { text = "-" },
          changedelete = { text = "~" },
          untracked    = { text = "?" },
        },
        current_line_blame = false,       -- toggle with <leader>gb
        current_line_blame_opts = {
          delay = 500,                    -- ms before blame appears on current line
        },
      })

      -- Navigate between hunks
      vim.keymap.set("n", "]h", gitsigns.next_hunk, { desc = "Gitsigns: next hunk" })
      vim.keymap.set("n", "[h", gitsigns.prev_hunk, { desc = "Gitsigns: previous hunk" })

      -- Toggle inline blame for current line
      vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "Gitsigns: toggle line blame" })

      -- Preview, stage, reset hunk
      vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk,  { desc = "Gitsigns: preview hunk" })
      vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk,    { desc = "Gitsigns: stage hunk" })
      vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk,    { desc = "Gitsigns: reset hunk" })

      -- Show diff of current file against last git commit in a split
      vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Gitsigns: diff current file" })

      -- Exit diff mode and close the temp buffer, returning to normal editing
      vim.keymap.set("n", "<leader>gx", function()
        vim.cmd("diffoff!")       -- turn off diff mode in all windows
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local name = vim.api.nvim_buf_get_name(buf)
          if name:match("^//0:") then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
        vim.cmd("wincmd p")       -- jump to the previous window (the temp one)
        vim.cmd("wincmd c")       -- close it
      end, { desc = "Gitsigns: exit diff mode" })
    end,
  },
}
