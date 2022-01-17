" Auto install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " ----------------- Accepted --------------------

    " Start Screen
    Plug 'mhinz/vim-startify'

    " Color Scheme
    Plug 'lifepillar/vim-solarized8'
    Plug 'franbach/miramare'
    Plug 'npxbr/gruvbox.nvim'
    Plug 'rktjmp/lush.nvim'
    Plug 'shaunsingh/nord.nvim'
    Plug 'sainnhe/sonokai'

    " Text Color
    Plug 'folke/todo-comments.nvim'

    " Better Comments
    Plug 'b3nj5m1n/kommentary'

    " Documentation
    Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

    " Cursor
    Plug 'yamatsum/nvim-cursorline'

    " Text Navigation
    " Plug 'justinmk/vim-sneak'
    Plug 'ggandor/lightspeed.nvim'
    Plug 'chentau/marks.nvim'

    " Text Modification
    Plug 'tpope/vim-unimpaired' " Inserting newline without going into Insert Mode (]<Space> and [<Space>)
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'brooth/far.vim'

    Plug 'MunifTanjim/nui.nvim'
    Plug 'VonHeikemen/searchbox.nvim'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'hrsh7th/nvim-compe'
    " Plug 'hrsh7th/nvim-cmp'
    " Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'ray-x/lsp_signature.nvim'

    " Cool Icons
    Plug 'onsails/lspkind-nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'

    " Indentation Guide
    Plug 'lukas-reineke/indent-blankline.nvim'

    " Status Line
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    Plug 'glepnir/galaxyline.nvim'
    Plug 'akinsho/nvim-bufferline.lua'

    " Interactive Code
    Plug 'metakirby5/codi.vim'

    " Smooth Scroll
    Plug 'psliwka/vim-smoothie'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'junegunn/gv.vim'
    " Plug 'sindrets/diffview.nvim'

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Telescope Extension
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope-file-browser.nvim'

    " Quickfix Window
    Plug 'kevinhwang91/nvim-bqf'

    " Switch between .h and .cpp
    Plug 'derekwyatt/vim-fswitch'

    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

    " Hex Coloring
    Plug 'ap/vim-css-color'

    " Maintain Window Layout
    Plug 'moll/vim-bbye'

    " Vim Key Information
    Plug 'folke/which-key.nvim'

    " Register
    " Plug 'AckslD/nvim-neoclip.lua'

    " Snippets
    " Plug 'L3MON4D3/LuaSnip' 
    " Plug 'saadparwaiz1/cmp_luasnip'
    " Plug 'rafamadriz/friendly-snippets'
    " Plug 'hrsh7th/vim-vsnip' 

    " --------------- End Accepted ------------------


    " Plug 'glepnir/lspsaga.nvim'
    " Plug 'kosayoda/nvim-lightbulb'
    " Plug 'mfussenegger/nvim-jdtls'
    " Plug 'mfussenegger/nvim-dap'

    " File Explorer
    " Plug 'kyazdani42/nvim-tree.lua'


    " Tags
    " Plug 'ludovicchabant/vim-gutentags'

call plug#end()

