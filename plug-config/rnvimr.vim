" pip3 install ranger-fm pynvim
" sudo apt install ranger
" git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
" mkdir ~/.config/ranger
" touch ~/.config/ranger/rc.conf
" Put the following in rc.conf
" default_linemode devicons
" set show_hidden true

" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1

nmap <space>r :RnvimrToggle<CR>


