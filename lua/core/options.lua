-- =============================================================================
-- core/options.lua — Vim options
-- =============================================================================
-- These are vanilla Neovim settings — no plugins required.
-- vim.opt is the modern Lua API equivalent of :set in Vimscript.
-- =============================================================================

local opt = vim.opt

-- ----------------------------------------------------------------------------
-- Leader key
-- ----------------------------------------------------------------------------
-- The leader key is your personal namespace for keybindings.
-- Space is the most common choice — easy to reach, not used by default.
-- This MUST be set before lazy.nvim loads. It's set here in options.lua,
-- which init.lua loads first — before the lazy.nvim bootstrap block.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ----------------------------------------------------------------------------
-- Line numbers
-- ----------------------------------------------------------------------------
opt.number = true           -- show absolute line number on current line

-- ----------------------------------------------------------------------------
-- Tabs and indentation
-- ----------------------------------------------------------------------------
opt.tabstop = 4             -- a Tab character renders as 4 spaces wide
opt.shiftwidth = 4          -- >> and << shift by 4 spaces
opt.expandtab = true        -- pressing Tab inserts spaces, not a tab character
opt.smartindent = true      -- auto-indent new lines based on syntax

-- ----------------------------------------------------------------------------
-- Search
-- ----------------------------------------------------------------------------
opt.ignorecase = true       -- case-insensitive search by default
opt.smartcase = true        -- ...unless you type an uppercase letter
opt.hlsearch = true         -- highlight all matches
opt.incsearch = true        -- show matches as you type

-- ----------------------------------------------------------------------------
-- Appearance
-- ----------------------------------------------------------------------------
opt.termguicolors = true    -- enable 24-bit RGB colour (required by most themes)
opt.signcolumn = "yes"      -- always show the sign column (left gutter)
                            -- prevents layout jumping when LSP adds signs
opt.cursorline = true       -- highlight the line the cursor is on
opt.scrolloff = 8           -- keep 8 lines visible above/below cursor when scrolling
opt.sidescrolloff = 8       -- same for horizontal scrolling
opt.wrap = false            -- don't wrap long lines

-- ----------------------------------------------------------------------------
-- Splits
-- ----------------------------------------------------------------------------
opt.splitright = true       -- vertical splits open to the right (feels more natural)
opt.splitbelow = true       -- horizontal splits open below

-- ----------------------------------------------------------------------------
-- Files and backup
-- ----------------------------------------------------------------------------
opt.undofile = true         -- persist undo history across sessions
                            -- stored in ~/.local/state/nvim/undo/
opt.swapfile = false        -- no swap files — they're rarely useful and cause noise
opt.backup = false          -- no backup files

-- ----------------------------------------------------------------------------
-- Completion and command line
-- ----------------------------------------------------------------------------
opt.completeopt = "menu,menuone,noselect"  -- completion menu behaviour
                                            -- needed by nvim-cmp when you add it
opt.pumheight = 10          -- max items shown in the completion popup
opt.cmdheight = 1           -- command bar height (1 is standard)
opt.showmode = false        -- don't show -- INSERT -- etc (lualine handles this)

-- ----------------------------------------------------------------------------
-- Performance
-- ----------------------------------------------------------------------------
opt.updatetime = 250        -- reduce time before CursorHold fires (affects LSP hover)
opt.timeoutlen = 300        -- time to wait for a key sequence to complete (ms)

-- ----------------------------------------------------------------------------
-- Clipboard
-- ----------------------------------------------------------------------------
-- Sync Neovim's unnamed register with the system clipboard.
-- In WSL2 this requires xclip — see README.

-- vim.g.clipboard must be set BEFORE opt.clipboard so Neovim knows which
-- tool to use when it activates clipboard support.
vim.g.clipboard = {
  name = "xclip",
  copy = {
    ["+"] = "xclip -selection clipboard",
    ["*"] = "xclip -selection clipboard",
  },
  paste = {
    ["+"] = "xclip -selection clipboard -o",
    ["*"] = "xclip -selection clipboard -o",
  },
  cache_enabled = 0,
}

opt.clipboard = "unnamedplus"

-- ----------------------------------------------------------------------------
-- Mouse
-- ----------------------------------------------------------------------------
opt.mouse = "a"             -- enable mouse in all modes
                            -- useful for resizing splits and clicking around
                            -- set to "" to disable entirely if you prefer

-- ----------------------------------------------------------------------------
-- Diagnostics
-- ----------------------------------------------------------------------------
-- Controls how LSP diagnostics are displayed in the buffer.
vim.diagnostic.config({
  signs = true,             -- show E/W/I/H signs in the sign column (left gutter)
  underline = true,         -- underline the affected code
  virtual_text = false,     -- don't show inline text after the line (can be noisy)
  update_in_insert = false, -- don't update diagnostics while typing in insert mode
})
