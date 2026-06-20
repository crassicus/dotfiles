" ==== Plugins ====
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive',
Plug 'sheerun/vim-polyglot',
Plug 'frazrepo/vim-rainbow',
Plug 'scrooloose/nerdcommenter',
Plug 'itchyny/lightline.vim',
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' },
Plug 'scrooloose/nerdtree',
Plug 'vim-scripts/loremipsum',
Plug 'w0rp/ale',
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'itchyny/vim-gitbranch',
Plug 'jpalardy/vim-slime',
Plug 'makerj/vim-pdf',
call plug#end()


" ==== ALE ====
let g:ale_linters = {
      \ 'rust': ['analyzer'],
      \ 'sh': ['shellcheck'],
      \ 'python': ['pyrefly'],
      \ 'svelte': ['svelteserver'],
      \ 'typescript': ['biome', 'eslint', 'tsserver'],
      \ 'typescriptreact': ['biome', 'tsserver'],
      \ }

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'rust': ['rustfmt'],
      \ 'python': ['ruff_format'],
      \ 'typescript': ['biome', 'prettier'],
      \ 'typescriptreact': ['biome', 'prettier'],
      \ 'css': ["biome", "prettier"],
      \ 'html': ["prettier"],
      \ 'svelte': ["prettier"],
      \ }


let g:ale_set_highlights = 0
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_set_balloons = 1
let g:ale_sign_error = '👹'
let g:ale_sign_warning = '👽'
let g:ale_sign_info = '🎃'
let g:ale_lint_delay = 0
let g:ale_completion_delay = 0
let g:ale_rust_rustfmt_options = '--edition 2021'


" ==== Lightline ====
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

" Makes Tab the switcher for ALE floating suggestions menu
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"

let g:rainbow_active = 1
let g:slime_target = "tmux"
let g:livepreview_previewer = 'zathura'

let NERDTreeMenuDown='n'
let NERDTreeMenuUp='e'
let NERDTreeMapOpenExpl='B'
let g:NERDTreeDirArrowExpandable = '󱧬'
let g:NERDTreeDirArrowCollapsible = '⟩'

" Removes `q` as a key to close NerdTree
augroup NerdTreeCustom
  autocmd!
  autocmd FileType nerdtree silent! unmap <buffer> q
augroup END

" Force Vim to apply the normal mode cursor at startup
augroup CursorShapeFix
  autocmd!
  autocmd VimEnter * silent! exe "normal! \<Esc>"
augroup END

let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden ' .
      \ '--exclude target ' .
      \ '--exclude .git ' .
      \ '--exclude node_modules ' .
      \ '--exclude .next'

autocmd BufEnter *.py ALEStopAllLSPs | ALELint
