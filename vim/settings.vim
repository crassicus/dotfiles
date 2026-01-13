set number
set nocompatible
set relativenumber
set encoding=UTF-8
set laststatus=2
set noshowmode
set autoindent expandtab tabstop=2 shiftwidth=2
set hidden
set autoread
set nostartofline
set termguicolors
set background=dark
set pumheight=5
set nohlsearch

" ==== Buffers security ====
" Never persist buffers, useful when working with encrypted files.
set nobackup
set nowritebackup
set noswapfile
set viminfo=
if has('persistent_undo')
      set noundofile
endif

" ==== Syntax ====
syntax on
filetype plugin indent on
autocmd BufWinEnter *.html,*.css,*.svelte ++once syntax on

" ==== Buffer Cursor Position ====
autocmd BufLeave * let b:winview = winsaveview()
autocmd BufEnter * if exists('b:winview') | call winrestview(b:winview) | endif

" ==== Cursor ====
let &t_EI = "\e[4 q"
let &t_SI = "\e[5 q"
let &t_SR = "\e[4 q"

colorscheme gruvbox
