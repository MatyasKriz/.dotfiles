set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set autoindent
set backup
set nu
set showmatch
syntax on
set t_Co=256
filetype on
filetype plugin on
set modeline
set wildmenu
set lazyredraw
set ls=2

set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>

set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set foldmethod=indent

nnoremap B ^
nnoremap E $

nnoremap $ <nop>
nnoremap ^ <nop>

nnoremap j gj
nnoremap k gk

inoremap jk <esc>
nnoremap <leader>s :mksession<CR>

nnoremap gV `[v`]

let mapleader=","

nnoremap <leader>a :Ag

colorscheme badwolf
let g:badwolf_tabline=0
let g:badwolf_darkgutter=1
set cursorline
