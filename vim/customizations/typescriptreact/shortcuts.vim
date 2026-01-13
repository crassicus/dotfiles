vim9script


# ==== Maps ====

autocmd FileType typescriptreact
      \ nnoremap <buffer> ha
      \ :CreateComponent<space>

autocmd FileType typescriptreact
      \ nnoremap <buffer> hA
      \ ms:ImportFromLib<space>

autocmd FileType typescriptreact
      \ nnoremap <buffer> hhc
      \ :TSAddPackage<space>

autocmd FileType typescriptreact
      \ nnoremap <buffer> hv
      \ :ToggleTsxToCss<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> hb
      \ :GoToMainComponent<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> tn
      \ :AddClassName<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> to
      \ :AddAttribute<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> ts
      \ ms:JumpToComponentHead<cr>zz

autocmd FileType typescriptreact
      \ nnoremap <buffer> tr
      \ ms:JumpToJsxReturn<cr>zz

autocmd FileType typescriptreact
      \ nnoremap <buffer> tc
      \ :CommentWord<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> ti
      \ ms:BreakBrackets<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> hp
      \ :Props<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> hc
      \ ms:ImportStructureFrom react<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> hC
      \ ms:ImportTypeFrom react<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> hr
      \ ms:ImportStructureFrom @/components/index<cr>

autocmd FileType typescriptreact
      \ nnoremap <buffer> hi
      \ ms:ImportStructureFrom<space>

autocmd FileType typescriptreact
      \ nnoremap <silent> <buffer> c.
      \ :EditAfterTag<cr>



# ==== Semantics ====

import "../general/scripts.vim" as utils

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> di
      \ utils.Wrapper("<div></div>\<Esc>F>a")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> vd
      \ utils.Wrapper("<>\<CR></>\<Esc>O")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> ip
      \ utils.Wrapper("<input type=\"text\" id=\"\" />\<Esc>F\"i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> h1
      \ utils.Wrapper("<h1></h1>\<Esc>FhT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> h2
      \ utils.Wrapper("<h2></h2>\<Esc>FhT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> h3
      \ utils.Wrapper("<h3></h3>\<Esc>FhT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> h4
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> h5
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> ma
      \ utils.Wrapper("<main></main>\<Esc>FmT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> sp
      \ utils.Wrapper("<span></span>\<Esc>FsT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> se
      \ utils.Wrapper("<section></section>\<Esc>FsT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> op
      \ utils.Wrapper("<option></option>\<Esc>FoT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> p
      \ utils.Wrapper("<p></p>\<Esc>FpT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> ul
      \ utils.Wrapper("<ul>\<CR></ul>\<Esc>O")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> sel
      \ utils.Wrapper("<select>\<CR></select>\<Esc>O")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> li
      \ utils.Wrapper("<li></li>\<Esc>T>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> la
      \ utils.Wrapper("<label htmlFor=\"\"></label>\<Esc>FlT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> na
      \ utils.Wrapper("<nav></nav>\<Esc>FnT>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> fo
      \ utils.Wrapper("<form id=\"\">\<Cr></form>\<Esc>O")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> ah
      \ utils.Wrapper("<a href=\"\"></a>\<Esc>Fhf\"a")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> co
      \ utils.Wrapper("console.log()\<Esc>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> im
      \ utils.Wrapper("<img src={} alt=\"\"/>\<Esc>Frf}i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> bu
      \ utils.Wrapper("<button type=\"button\" onClick={() => {}}></button>\<Esc>F/hi")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> int
      \ utils.Wrapper("interface x {}\<Esc>Fxcw")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> st
      \ utils.Wrapper("const [, set] = useState();\<Esc>F,i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> cf
      \ utils.Wrapper("const x = () => {};\<Esc>Fxs")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> fn
      \ utils.Wrapper("function x() {}\<Esc>Fxcw")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> tr
      \ utils.Wrapper("<tr>\<Cr></tr>\<Esc>O")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> th
      \ utils.Wrapper("<th></th>\<Esc>T>i")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> td
      \ utils.Wrapper("<td></td>\<Esc>T>i")


# ==== Callable functions ====

import "./scripts/extras.vim" as extraScripts

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> ta
      \ utils.Wrapper(extraScripts.Write("table") .. "\<Esc>8k2fh")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> fc
      \ utils.Wrapper(extraScripts.Write("component") .. "\<Esc>?function\<cr>wi")

autocmd FileType typescriptreact
      \ inoreabbre <expr> <buffer> cc
      \ utils.Wrapper(extraScripts.Write("callback_component") .. "\<Esc>?const\<cr>whi")

# ==== Aliases ====

autocmd FileType typescriptreact
      \ cnoreabbrev <expr> <buffer> lib
      \ getcmdline() ==# 'lib' ? 'ImportFromLib' : 'lib'

autocmd FileType typescriptreact
      \ cnoreabbrev <expr> <buffer> pkg
      \ getcmdline() ==# 'pkg' ? 'TSAddPackage' : 'pkg'

autocmd FileType typescriptreact
      \ cnoreabbrev <expr> <buffer> rmc
      \ getcmdline() ==# 'rmc' ? 'RemoveComponent' : 'rmc'


defcompile
