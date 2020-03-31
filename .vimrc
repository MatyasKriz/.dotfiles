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
filetype indent on
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

" inoremap jk <esc>
nnoremap <leader>s :mksession<CR>

nnoremap gV `[v`]

let mapleader=","

nnoremap <leader>a :Ag

colorscheme badwolf
let g:badwolf_tabline=0
let g:badwolf_darkgutter=1
set cursorline

" When editing `RubyPlayground.rb`, execute it on save.
autocmd BufWritePost RubyPlayground.rb !ruby %

" When editing `GoPlayground.go`, execute it on save.
autocmd BufWritePost GoPlayground.go !go run %

" Use ruby syntax highlight on Fastfile, Podfile, and podspecs.
autocmd BufReadPost Fastfile,Podfile,*.podspec set syntax=ruby

autocmd BufReadPost *.swift set syntax=swift

" Make all Haskell files playgrounds.
autocmd BufWritePost *.hs !ghc % && ./%:r

" Select text without line numbers. Need to use YANK to copy then.
""set mouse=a
""set clipboard=unnamed

" Moves ALL undoes into a single dir saving undoes on closed files.
if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif
set undofile
set undodir=~/.vim/undodir
" And delete it after 90 days.
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')

" Needs Gundo. GUI Undo tree.
nnoremap <F5> :GundoToggle<CR>
