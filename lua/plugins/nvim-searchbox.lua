require('searchbox').setup({
  popup = {
    relative = 'win',
    position = {
      row = '95%',
      col = '2%',
    },
    size = 30,
    border = {
      style = 'rounded',
      highlight = 'FloatBorder',
      text = {
        top = ' Search ',
        top_align = 'left',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal',
    },
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end
  }
})

vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>lua require("searchbox").replace()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>S', '<cmd>lua require("searchbox").replace({confirm = "menu"})<CR>', {noremap = true})

