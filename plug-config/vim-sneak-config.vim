map s <Plug>Sneak_s
map S <Plug>Sneak_S
let g:sneak#prompt = '🔎 '

" Shows character label for word if there's multiples of that word
let g:sneak#label = 1
"
" Case insensitive sneak
let g:sneak#use_ic_scs = 0

highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

