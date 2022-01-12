" :SLoad       Load a session
" :SSave[!]    Save a session
" :SDelete[!]  Delete a session
" :SClose      Close a session

let g:startify_session_dir = '~/.config/nvim/session'

" We can specify what shows up in our menu like this:
let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   Recent Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'z': '~/.zshrc' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ '~/TestA',
            \ '~/TestB',
            \ '~/TestC',
            \ ]

" If this option is enabled and you start Vim in a directory that contains a Session.vim, that session will be loaded automatically
let g:startify_session_autoload = 1

" Let Startify take care of buffers
let g:startify_session_delete_buffers = 1

" Similar to Vim-rooter
let g:startify_change_to_vcs_root = 1

" If you want Unicode
let g:startify_fortune_use_unicode = 1

" Automatically Update Sessions
let g:startify_session_persistence = 1

" Get rid of empty buffer and quit
let g:startify_enable_special = 0

let g:startify_custom_header = [
        \ '   _  __     _         __  ___         __     ___ ',
        \ '  / |/ /  __(_)_ _    /  |/  /__ _____/ /    |_  |',
        \ ' /    / |/ / /  ` \  / /|_/ / _ `/ __/ _ \  / __/ ',
        \ '/_/|_/|___/_/_/_/_/ /_/  /_/\_,_/\__/_//_/ /____/ ',
        \]

