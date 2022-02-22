nnoremap <F3> :e $MYVIMRC<CR>
map <F4> :source $MYVIMRC<CR>

" Substitute for <ESC>
imap jj <Esc>

nmap <leader>q :qa<CR>

" Faster save
nnoremap <Leader>w :w<CR>

" Behave vim
nnoremap Y y$

" Don't yank deleted lines when pasting
vnoremap p "0p
vnoremap P "0P
vnoremap y "0y
vnoremap d "0d

" Every character specified below is added as an action to the undo redo tree
" This will allow a more refiner undo action
inoremap <space> <space><c-g>u
inoremap , ,<c-g>u
inoremap [ [<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ( (<c-g>u
inoremap ) )<c-g>u
inoremap { {<c-g>u
inoremap } }<c-g>u

" Jumplist mutations
" Relative jumps are now added to the jump list history if large enough
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <Leader>k :m .-2<CR>==
nnoremap <Leader>j :m .+1<CR>==

" Close current window
nmap <Leader>c :close<CR>

" Close current buffer
nmap <Leader>x :Bdelete<CR>

" Select what was just pasted
nnoremap <Leader>V V`]

" Clears and redraws the screen. This mapping builds on top of the usual behavior
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Don't jump to next word search straight away
nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Window movement
" Move the cursor to the window left of the current one
noremap <silent> ,h :wincmd h<cr>
" Move the cursor to the window below the current one
noremap <silent> ,j :wincmd j<cr>
" Move the cursor to the window above the current one
noremap <silent> ,k :wincmd k<cr>
" Move the cursor to the window right of the current one
noremap <silent> ,l :wincmd l<cr>
" Close the current window
noremap <silent> ,c :close<cr>
" Move the current window to the right of the main Vim window
noremap <silent> ,ml <C-W>L
" Move the current window to the top of the main Vim window
noremap <silent> ,mk <C-W>K
" Move the current window to the left of the main Vim window
noremap <silent> ,mh <C-W>H
" Move the current window to the bottom of the main Vim window
noremap <silent> ,mj <C-W>J

" This shortcut will list the available buffers and prepare :b for you
" Then you can just type the buffer number, and hit Enter
nnoremap <Leader>b :ls<CR>:b<Space>

" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <silent>[b :BufferLineCyclePrev<CR>

