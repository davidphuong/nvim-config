-- =============================================================================
-- core/autocmds.lua — Autocommands
-- =============================================================================
-- Autocommands run automatically when certain events happen.
-- vim.api.nvim_create_autocmd(event, opts)
--   event: the trigger (e.g. "BufWritePre" = before saving a file)
--   opts.group:    group name — keeps related autocmds together and prevents
--                  duplicates if the file is re-sourced
--   opts.pattern:  which files to match ("*" = all)
--   opts.callback: Lua function to run
-- =============================================================================

-- Helper: create an augroup (prevents duplicate autocmds on config reload)
local function augroup(name)
  return vim.api.nvim_create_augroup("nvim_" .. name, { clear = true })
end

-- ----------------------------------------------------------------------------
-- Highlight on yank
-- ----------------------------------------------------------------------------
-- Briefly highlights the yanked text so you can see what was copied.
-- Built into Neovim — no plugin needed.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
  desc = "Briefly highlight yanked text",
})

-- ----------------------------------------------------------------------------
-- Remove trailing whitespace on save
-- ----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)  -- save cursor position
    vim.cmd([[%s/\s\+$//e]])                     -- delete trailing whitespace (e = no error if none found)
    vim.api.nvim_win_set_cursor(0, pos)          -- restore cursor position
  end,
  desc = "Remove trailing whitespace on save",
})

-- ----------------------------------------------------------------------------
-- Remember last cursor position
-- ----------------------------------------------------------------------------
-- When you re-open a file, jump back to where you were.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_cursor_position"),
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
  desc = "Jump to last cursor position when opening a file",
})

-- ----------------------------------------------------------------------------
-- Auto-resize splits when terminal window is resized
-- ----------------------------------------------------------------------------
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  pattern = "*",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Equalise split sizes when Neovim window is resized",
})

-- ----------------------------------------------------------------------------
-- Filetype-specific settings
-- ----------------------------------------------------------------------------
-- Different indentation for certain file types.
-- Add more as needed when you work with new languages.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("filetype_indent"),
  pattern = { "yaml", "yml", "json", "html", "css", "javascript", "typescript", "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
  desc = "Use 2-space indent for web/config file types",
})

-- C++ specific
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("cpp_settings"),
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.colorcolumn = "80,120"
  end,
  desc = "C/C++ indent and column rulers",
})

-- ----------------------------------------------------------------------------
-- Remove Windows carriage returns on save
-- ----------------------------------------------------------------------------
-- Pastes from Windows host can introduce \r (shown as ^M) at line endings.
-- This strips them silently on every save.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("strip_carriage_returns"),
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\r//e]])
  end,
  desc = "Remove Windows carriage returns (^M) on save",
})

-- ----------------------------------------------------------------------------
-- Jinja2 template filetype
-- ----------------------------------------------------------------------------
-- Treat .j2/.jinja/.jinja2 files as YAML for syntax highlighting.
-- Covers Ansible templates which are YAML with Jinja2 expressions.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("jinja2_filetype"),
  pattern = { "*.j2", "*.jinja", "*.jinja2" },
  callback = function()
    vim.bo.filetype = "yaml"
  end,
  desc = "Treat Jinja2 template files as YAML for syntax highlighting",
})
-- ----------------------------------------------------------------------------
-- If you do :e lua/some/new/path/file.lua and the dirs don't exist, this
-- creates them automatically when you save.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dirs"),
  pattern = "*",
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    local dir = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
  desc = "Create parent directories if they don't exist on save",
})
