vim9script

autocmd FileType rust
      \ nnoremap <buffer> hp
      \ :RustAddPublic<cr>

autocmd FileType rust
      \ nnoremap <buffer> ha
      \ :RustAddAsync<cr>

autocmd FileType rust
      \ nnoremap <buffer> hm
      \ :RustAddMacro<cr>

autocmd FileType rust
      \ nnoremap <buffer> hx
      \ ms:RustToggleMutability<cr>

autocmd FileType rust
      \ nnoremap <buffer> hc
      \ ms:ToggleLeadingUnderscore<cr>

autocmd FileType rust
      \ nnoremap <buffer> hi
      \ :Implement<space>

autocmd FileType rust
      \ nnoremap <buffer> tn
      \ ms:RustToggleFunctionReturnType<cr>

autocmd FileType rust
      \ nnoremap <buffer> tc
      \ :CommentWord<CR>

autocmd FileType rust
      \ nnoremap <buffer> tp
      \ ms:AddSingularPublic<cr>

autocmd FileType rust
      \ nnoremap <buffer> ts
      \ ms:TakeMeToArgs<cr>

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


# Creates a test interface
autocmd FileType rust
      \ inoremap <buffer> kkt
      \ #[cfg(test)]<cr>
      \ mod tests {<cr>use super::*;<cr><cr><left><space>#[test]<cr><left><space>
      \ fn xx() {<cr>}<cr>}<up><up><esc>fxcw


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
      \ inoreabbrev <expr> <buffer> ra
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


# ==== Command line shortcuts ====
autocmd FileType rust
      \ cnoreabbrev <expr> <buffer> scf
      \ getcmdline() ==# 'scf' ? 'Scaffold' : 'scf'

autocmd FileType rust
      \ cnoreabbrev <expr> <buffer> imp
      \ getcmdline() ==# 'imp' ? 'Implement' : 'imp'

defcompile
