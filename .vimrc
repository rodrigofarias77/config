" set clipboard+=unnamedplus
" set formatoptions-=tc
set guicursor+=a:blinkon1
set hlsearch
set ignorecase
set nojoinspaces
set linebreak
set mouse=
set ruler
set showcmd
set nostartofline
set title
set wildignorecase

let netrw_silent=1

map <CR> maHmb`a*`bzt`a
map <C-Down> <C-E>
map <C-End> G<End>
map <C-Home> gg<Home>
map <C-Up> <C-Y>
map <F2> :tabedit<CR>:e<Space>
" map <F3>
map <F4> yl/<C-R>"<CR>
map <F5> `dzt`c
map <F6> mcHmd`c
map <F7> :set spell! spell?<CR>
map <F8> :set wrap! wrap?<CR>
map <F9> :set et sw=4 ts=4<CR>
map <F10> :set et& sw& ts&<CR>
map <F12> :windo set syntax&<CR>
map <PageDown> Lzt
map <PageUp> Hzb
map <Space> :nohlsearch<CR>
map <Tab> gt
map <S-Tab> gT
