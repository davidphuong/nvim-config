-- =============================================================================
-- core/keymaps.lua — Keybindings
-- =============================================================================
-- vim.keymap.set(mode, lhs, rhs, opts)
--   mode: "n" normal, "i" insert, "v" visual, "x" visual block, "t" terminal
--   lhs:  the key combo you press
--   rhs:  what it does (string command or Lua function)
--   opts: table of options — always include desc="" so :map shows useful info
--
-- We use noremap behaviour by default (set implicitly by vim.keymap.set).
-- This means your mapping won't be remapped by other mappings — safer.
-- =============================================================================

local map = vim.keymap.set

-- ----------------------------------------------------------------------------
-- General
-- ----------------------------------------------------------------------------

-- Clear search highlights with Escape in normal mode
-- After searching, hit Esc to clear the yellow highlight without leaving normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Save file
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })

-- Quit
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })

-- ----------------------------------------------------------------------------
-- Better defaults
-- ----------------------------------------------------------------------------

-- Keep cursor centred when scrolling half-page
-- Ctrl-d and Ctrl-u are the standard half-page scroll keys
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page (centred)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page (centred)" })

-- Keep search result centred when jumping through matches
map("n", "n", "nzzzv", { desc = "Next search result (centred)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centred)" })

-- Don't lose the visual selection when indenting
-- Normally < and > drop your selection after one use
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })

-- Paste without overwriting the register
-- When you paste over selected text, the default yanks the replaced text
-- into your register, clobbering what you wanted to paste next time.
-- This fixes that.
map("v", "p", '"_dP', { desc = "Paste without yanking replaced text" })

-- ----------------------------------------------------------------------------
-- Window navigation
-- ----------------------------------------------------------------------------
-- Ctrl + hjkl to move between splits (much faster than Ctrl-w then hjkl)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Resize splits with arrow keys
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Resize split up" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Resize split down" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })

-- ----------------------------------------------------------------------------
-- Buffer navigation
-- ----------------------------------------------------------------------------
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete (close) buffer" })

-- ----------------------------------------------------------------------------
-- Terminal
-- ----------------------------------------------------------------------------
-- Open a terminal in a horizontal split at the bottom
map("n", "<leader>tt", "<cmd>split | terminal<CR>", { desc = "Open terminal (horizontal split)" })

-- ----------------------------------------------------------------------------
-- Diagnostics (built-in LSP)
-- ----------------------------------------------------------------------------
-- Jump between errors and warnings in the current buffer
map("n", "[d", vim.diagnostic.goto_prev,  { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
map("n", "<leader>sl", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })

