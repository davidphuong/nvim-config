-- =============================================================================
-- plugins/telescope.lua — Fuzzy finder
-- =============================================================================
-- Telescope lets you fuzzy-find files, search text inside files, and more.
--
-- Dependencies:
--   - plenary.nvim  — Lua utility library required by Telescope
--   - ripgrep (rg)  — required for live_grep (installed via install.sh)
--   - fd-find       — used for file finding (installed via install.sh)
--
-- Keymaps:
--   <leader>ff — find files by name
--   <leader>fg — live grep (search text inside files)
--   <leader>fb — list open buffers
--
-- Inside Telescope:
--   <C-v>  — open in vertical split
--   <C-s>  — open in horizontal split
--   <C-j>  — move down results
--   <C-k>  — move up results
--   <C-x>  — delete buffer (buffers picker only)
-- =============================================================================

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.1",           -- pinned version — change deliberately when upgrading
    dependencies = {
      "nvim-lua/plenary.nvim" -- required utility library
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-s>"] = actions.select_horizontal,  -- open in horizontal split
              ["<C-x>"] = actions.delete_buffer,      -- delete buffer (buffers picker)
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = {
            -- fdfind is the Ubuntu binary name for fd
            -- --hidden: show dotfiles
            -- --exclude .git: skip the .git directory
            find_command = { "fdfind", "--type", "f", "--hidden", "--exclude", ".git" },
          },
          live_grep = {
            -- ripgrep flags:
            -- --hidden: search dotfiles
            -- --glob !.git: exclude .git directory
            additional_args = { "--hidden", "--glob", "!.git" },
          },
        },
      })

      -- Find files by name
      -- Opens a fuzzy finder over all files in the current directory
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: find files" })

      -- Live grep — search text inside files
      -- Opens a prompt where you type and results update in real time
      -- Requires ripgrep (rg) to be installed
      vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Telescope: live grep" })

      -- Buffers — list all open buffers and switch between them
      vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Telescope: buffers" })
    end,
  },
}
