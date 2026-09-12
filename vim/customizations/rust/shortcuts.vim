vim9script

autocmd FileType rust
      \ nnoremap <buffer> <silent> hp
      \ :TogglePub<cr>

autocmd FileType rust
      \ nnoremap <buffer> <silent> ha
      \ :ToggleAsync<cr>

autocmd FileType rust
      \ nnoremap <buffer> <silent> hx
      \ ms:ToggleMut<cr>

autocmd FileType rust
      \ nnoremap <buffer> <silent> hc
      \ ms:ToggleVariable<cr>

autocmd FileType rust
      \ nnoremap <buffer> <silent> tn
      \ ms:ToggleFnReturnType<cr>

autocmd FileType rust
      \ nnoremap <buffer> hi
      \ :Implement<space>

autocmd FileType rust
      \ nnoremap <buffer> <silent> tp
      \ ms:AddSingularPublic<cr>

autocmd FileType rust
      \ nnoremap <buffer> <silent> ts
      \ ms:GoToFnArgs<cr>

autocmd FileType rust
      \ nnoremap <buffer> ti
      \ ms:BreakBrackets<cr>

autocmd FileType rust
      \ nnoremap <buffer> hhx
      \ :!clear; cargo run --<space>

autocmd FileType rust
      \ nnoremap <buffer> hht
      \ :!clear; cargo test<cr>

autocmd FileType rust
      \ nnoremap <buffer> hr
      \ :CargoAdd<space>


autocmd FileType rust
      \ inoremap <buffer> " '


# ==== Semantic shortcuts ====
import "../general/scripts.vim" as utils

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> pr
      \ utils.Wrapper("println!(\"{}\", );\<Esc>2F\"a")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> im
      \ utils.Wrapper("impl x for {\<cr>}\<up>\<esc>fxcw")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> af
      \ utils.Wrapper("async fn () {}\<esc>F(i")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> ae
      \ utils.Wrapper("assert_eq!(, );\<esc>T(i")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> fn
      \ utils.Wrapper("fn () {}\<esc>F(i")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> st
      \ utils.Wrapper("struct x {}<esc>Fxcw")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> en
      \ utils.Wrapper("enum x {}<esc>Fxcw")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> ass
      \ utils.Wrapper("assert!();\<esc>T(i")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> de
      \ utils.Wrapper("#[derive()]\<esc>F(a")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> ma
      \ utils.Wrapper("#[]\<esc>i")

autocmd FileType rust
      \ inoreabbrev <expr> <buffer> tf
      \ utils.Wrapper("#[test]<cr>fn xx() {<cr>}<up><esc>fxcw")


import "./scripts.vim" as rustScripts

autocmd FileType rust
      \ inoreabbre <expr> <buffer> iasref
      \ utils.Wrapper(rustScripts.Write("asref") .. "\<Esc>3kfT")

autocmd FileType rust
      \ inoreabbre <expr> <buffer> ideref
      \ utils.Wrapper(rustScripts.Write("deref") .. "\<Esc>5kfV")

autocmd FileType rust
      \ inoreabbre <expr> <buffer> ifrom
      \ utils.Wrapper(rustScripts.Write("from") .. "\<Esc>3kfT")

autocmd FileType rust
      \ inoreabbre <expr> <buffer> idisplay
      \ utils.Wrapper(rustScripts.Write("display") .. "\<Esc>5kfT")

autocmd FileType rust
      \ inoreabbre <expr> <buffer> itest
      \ utils.Wrapper(rustScripts.Write("test") .. "\<Esc>3kf(i")


# ==== Command line shortcuts ====
autocmd FileType rust
      \ cnoreabbrev <expr> <buffer> scf
      \ getcmdline() ==# 'scf' ? 'Scaffold' : 'scf'


defcompile
