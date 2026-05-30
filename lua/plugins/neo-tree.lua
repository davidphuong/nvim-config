-- =============================================================================
-- plugins/neo-tree.lua — File tree
-- =============================================================================
-- Neo-tree shows a file system tree in a side panel for browsing unfamiliar
-- codebases without knowing exact filenames.
--
-- Dependencies:
--   - plenary.nvim  — already installed (Telescope dependency)
--   - nui.nvim      — UI component library required by neo-tree
--
-- Keymaps:
--   <leader>e — toggle file tree (current working directory)
--
-- Inside the tree:
--   <CR> or o  — open fil
--   <C-v>      — open in vertical split
--   <C-s>      — open in horizontal split
--   a          — create file/directory
--   d          — delete
--   r          — rename
--   y          — copy filename
--   q          — close tree
--   H          — toggle hidden files
--
-- Note: icons disabled — install a Nerd Font in Windows Terminal and add
--       nvim-tree/nvim-web-devicons back to dependencies to enable them
-- =============================================================================

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "3.41.0",           -- pinned version — change deliberately when upgrading
    dependencies = {
      "nvim-lua/plenary.nvim",    -- already installed via Telescope
      "MunifTanjim/nui.nvim",     -- UI component library
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,  -- close neo-tree if it's the last window open
        default_component_configs = {
          icon = {
            folder_closed = "+",
            folder_open = "-",
            folder_empty = "+",
            default = " ",            -- no icon for files
          },
          git_status = {
            symbols = {
              added     = "+",
              modified  = "~",
              deleted   = "-",
              renamed   = ">",
              untracked = "?",
              ignored   = ".",
              unstaged  = "u",
              staged    = "s",
              conflict  = "c",
            },
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,    -- show dotfiles by default
            hide_gitignored = true,   -- hide files in .gitignore
          },
          follow_current_file = {
            enabled = true,           -- highlight the current file in the tree
          },
        },
        window = {
          width = 35,                 -- panel width in columns
          mappings = {
            ["<C-v>"] = "open_vsplit",  -- match Telescope Ctrl+v
            ["<C-s>"] = "open_split",   -- match Telescope Ctrl+s
          },
        },
      })

      -- Toggle file tree
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Neo-tree: toggle file tree" })
    end,
  },
}
