" Install Instructions
" :PlugInstall
" Follow install instructions in nvim/plug-config/rnvimr.vim
" :LspInstall {insert language here}
" sudo apt install ccls
" sudo apt install ripgrep

" General Settings
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/plug-config/sonokai.vim
" source $HOME/.config/nvim/general/functions.vim
" source $HOME/.config/nvim/general/paths.vim

" Plugin Configuration (.vim)
" source $HOME/.config/nvim/plug-config/vim-sneak-config.vim
source $HOME/.config/nvim/plug-config/vim-doge-config.vim
source $HOME/.config/nvim/plug-config/vim-fugitive-config.vim
source $HOME/.config/nvim/plug-config/vim-fswitch-config.vim
source $HOME/.config/nvim/plug-config/rnvimr.vim
source $HOME/.config/nvim/plug-config/start-screen-config.vim

" Plugin Configuration (.lua)
luafile $HOME/.config/nvim/lua/plugins/telescope-config.lua
luafile $HOME/.config/nvim/lua/plugins/kommentary.lua
" luafile $HOME/.config/nvim/lua/plugins/diffview-config.lua
luafile $HOME/.config/nvim/lua/plugins/gitsigns.lua
luafile $HOME/.config/nvim/lua/plugins/lspkind.lua
luafile $HOME/.config/nvim/lua/plugins/lsp-signature-config.lua
luafile $HOME/.config/nvim/lua/plugins/nvim-bufferline.lua
luafile $HOME/.config/nvim/lua/plugins/galaxyline-config.lua
luafile $HOME/.config/nvim/lua/plugins/nvim-treesitter.lua
luafile $HOME/.config/nvim/lua/plugins/compe-config.lua
luafile $HOME/.config/nvim/lua/plugins/todo-comments.lua
luafile $HOME/.config/nvim/lua/plugins/which-key.lua
luafile $HOME/.config/nvim/lua/plugins/nvim-searchbox.lua
luafile $HOME/.config/nvim/lua/plugins/nvim-lightspeed.lua
luafile $HOME/.config/nvim/lua/plugins/nvim-marks.lua
" luafile $HOME/.config/nvim/lua/plugins/nvim-neoclip.lua
" luafile $HOME/.config/nvim/lua/plugins/nvim-cmp.lua
" luafile $HOME/.config/nvim/lua/plugins/cmp-nvim-lsp.lua
" luafile $HOME/.config/nvim/lua/plugins/nvim-luasnip.lua
" luafile $HOME/.config/nvim/lua/plugins/nvim-cmp-luasnip.lua
" luafile $HOME/.config/nvim/lua/plugins/friendly-snippets.lua

luafile $HOME/.config/nvim/lua/lsp/lsp-config.lua
luafile $HOME/.config/nvim/lua/lsp/ccls-ls.lua
luafile $HOME/.config/nvim/lua/lsp/python-ls.lua
luafile $HOME/.config/nvim/lua/lsp/vim-ls.lua
" luafile $HOME/.config/nvim/lua/lsp/lua-ls.lua
" luafile $HOME/.config/nvim/lua/lsp/bash-ls.lua
" luafile $HOME/.config/nvim/lua/lsp/json-ls.lua

