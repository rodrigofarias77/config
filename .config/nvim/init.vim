" set clipboard+=unnamedplus
" set formatoptions-=tc
set guicursor+=a:blinkon1
set ignorecase
set linebreak
set mouse=
set nojoinspaces
set nostartofline
set showbreak=...\ 
set title
set wildignorecase

let netrw_silent=1

map <CR> :let z=winsaveview()<CR>*:call winrestview(z)<CR>
map <C-Down> <C-E>
map <C-Up> <C-Y>
map <F2> :tabedit<CR>:e<Space>
" map <F3>
map <F4> yl/<C-R>"<CR>
map <F5> :call winrestview(a)<CR>
map <F6> :let a=winsaveview()<CR>
map <F7> :set spell! spell?<CR>
map <F8> :set wrap! wrap?<CR>
map <F9> :set et sw=4 ts=4<CR>
map <F10> :set et& sw& ts&<CR>
map <F12> :windo set syntax&<CR>
map <Space> :nohlsearch<CR>
map <S-PageDown> gt
map <S-PageUp> gT
