"  function! AirlineInit()
"      let g:airline_section_a = airline#section#create(['mode',' ','branch'])
"      let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
"      let g:airline_section_c = airline#section#create(['filetype'])
"      let g:airline_section_x = airline#section#create(['%P'])
"      let g:airline_section_y = airline#section#create(['%B'])
"      let g:airline_section_z = airline#section#create_right(['%l', '%c'])
"  endfunction
"  autocmd VimEnter * call AirlineInit()

"  let g:airline_theme='solarized_flood'
 let g:airline_theme = 'miramare'

 " Automatically displays all buffers when there's only one tab open
 let g:airline#extensions#tabline#buffer_nr_show = 1
 let g:airline#extensions#tabline#enabled = 1

 autocmd VimEnter * AirlineRefresh

