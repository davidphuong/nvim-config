-- sudo apt install ripgrep

local actions = require "telescope.actions"

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        width = 0.85,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = { 'tags' },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = { shorten = 6 },
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,

    mappings = {
      i = {
        ["<C-x>"] = actions.delete_buffer,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
      },
      n = {
        ["<CR>"] = actions.select_default + actions.center,
        ["<C-x>"] = actions.delete_buffer,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
      },
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    file_browser = {
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  }
}

require('telescope').load_extension('fzf')
require("telescope").load_extension "file_browser"

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>f<space>", "<cmd>Telescope resume<cr>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>1ff", "<cmd>Telescope find_files cwd=../<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>2ff", "<cmd>Telescope find_files cwd=../../<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>3ff", "<cmd>Telescope find_files cwd=../../../<cr>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>fd", ":Telescope file_browser", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>1fg", "<cmd>Telescope live_grep cwd=../<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>2fg", "<cmd>Telescope live_grep cwd=../../<cr>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>fG", "<cmd>Telescope grep_string<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>1fG", "<cmd>Telescope grep_string cwd=../<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>2fG", "<cmd>Telescope grep_string cwd=../../<cr>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>fy", "<cmd>Telescope neoclip<cr>", {noremap = true, silent = true})

