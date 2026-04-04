vim9script


# ==== Maps ====

autocmd FileType typescript
      \ nnoremap <buffer> hi
      \ ms:ImportFrom<space>

autocmd FileType typescript
      \ nnoremap <buffer> hp
      \ ms:TsAddExport<cr>

autocmd FileType typescript
      \ nnoremap <buffer> ha
      \ ms:TSAddAsync<cr>

autocmd FileType typescript
      \ nnoremap <buffer> <silent> tn
      \ ms:SwitchReturnType<cr>

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

autocmd FileType typescript
      \ inoreabbre <expr> <buffer> af
      \ utils.Wrapper("async function x() {}\<Esc>Fxcw")
