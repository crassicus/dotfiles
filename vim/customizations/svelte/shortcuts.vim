vim9script
# vim/customizations/svelte/shortcuts.ts

autocmd FileType svelte
      \ nnoremap <silent> <buffer> c.
      \ :ChangeTagContent<cr>

autocmd FileType svelte
      \ nnoremap <silent> <buffer> tn
      \ :AddClass<cr>

autocmd FileType svelte
      \ nnoremap <silent> <buffer> to
      \ :AddAttribute<cr>


# ==== Semantics ====
import "../general/scripts.vim" as utils

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> di
      \ utils.Wrapper("<div></div>\<Esc>F>a")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> sc
      \ utils.Wrapper('<script lang="ts"><esc>^d0o</script><esc>^d0O<esc>0i<tab>')

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> st
      \ utils.Wrapper('<style><esc>^d0o</style><esc>^d0O<esc>0i<tab>')

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> ip
      \ utils.Wrapper("<input type=\"text\" id=\"\" />\<Esc>F\"i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h1
      \ utils.Wrapper("<h1></h1>\<Esc>FhT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h2
      \ utils.Wrapper("<h2></h2>\<Esc>FhT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h3
      \ utils.Wrapper("<h3></h3>\<Esc>FhT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h4
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h5
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> ma
      \ utils.Wrapper("<main></main>\<Esc>FmT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> sp
      \ utils.Wrapper("<span></span>\<Esc>FsT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> se
      \ utils.Wrapper("<section></section>\<Esc>FsT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> op
      \ utils.Wrapper("<option></option>\<Esc>FoT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> pa
      \ utils.Wrapper("<p></p>\<Esc>FpT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> ul
      \ utils.Wrapper("<ul><esc>o</ul><esc>O")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> sel
      \ utils.Wrapper("<select>\<CR></select>\<Esc>O")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> li
      \ utils.Wrapper("<li></li>\<Esc>T>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> la
      \ utils.Wrapper("<label for=\"\"></label>\<Esc>FlT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> na
      \ utils.Wrapper("<nav></nav>\<Esc>FnT>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> fo
      \ utils.Wrapper("<form id=\"\">\<Cr></form>\<Esc>O")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> ah
      \ utils.Wrapper("<a href=\"\"></a>\<Esc>Fhf\"a")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> co
      \ utils.Wrapper("console.log()\<Esc>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> im
      \ utils.Wrapper("<img src={} alt=\"\"/>\<Esc>Frf}i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> bu
      \ utils.Wrapper("<button type=\"button\" onclick={() => {}}></button>\<Esc>F/hi")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> int
      \ utils.Wrapper("interface x {}\<Esc>Fxcw")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> cf
      \ utils.Wrapper("const x = () => {};\<Esc>Fxs")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> fn
      \ utils.Wrapper("function x() {}\<Esc>Fxcw")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> tr
      \ utils.Wrapper("<tr>\<Cr></tr>\<Esc>O")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> th
      \ utils.Wrapper("<th></th>\<Esc>T>i")

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> td
      \ utils.Wrapper("<td></td>\<Esc>T>i")



# ==== Callable functions ====
import "./scripts.vim" as extraScripts


defcompile
