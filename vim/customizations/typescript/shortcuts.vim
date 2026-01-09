vim9script

# ==== Maps ====

autocmd FileType typescript
      \ nnoremap <buffer> hc
      \ ms:ImportStructureFrom react<cr>

autocmd FileType typescript
      \ nnoremap <buffer> hC
      \ ms:ImportTypeFrom react<cr>


# ==== Semantics ====

import "../general/scripts.vim" as utils

autocmd FileType typescript
      \ inoreabbre <expr> <buffer> int
      \ utils.Wrapper("interface x {}\<Esc>Fxcw")

autocmd FileType typescript
      \ inoreabbre <expr> <buffer> fn
      \ utils.Wrapper("function x() {}\<Esc>Fxcw")

autocmd FileType typescript
      \ inoreabbre <expr> <buffer> cf
      \ utils.Wrapper("const x = () => {};\<Esc>Fxs")

autocmd FileType typescript
      \ inoreabbre <expr> <buffer> co
      \ utils.Wrapper("console.log()\<Esc>i")


# ==== Aliases ====

autocmd FileType typescript
      \ cnoreabbrev <expr> <buffer> pkg
      \ getcmdline() ==# 'pkg' ? 'TSAddPackage' : 'pkg'
