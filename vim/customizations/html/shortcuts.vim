vim9script

# ==== Semantics ====

import "../general/scripts.vim" as utils

autocmd FileType html
      \ inoreabbre <expr> <buffer> di
      \ utils.Wrapper("<div></div>\<Esc>F>a")

autocmd FileType html
      \ inoreabbre <expr> <buffer> vd
      \ utils.Wrapper("<>\<CR></>\<Esc>O")

autocmd FileType html
      \ inoreabbre <expr> <buffer> ip
      \ utils.Wrapper("<input type=\"text\" id=\"\" name=\"\" />\<Esc>F\"i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> h1
      \ utils.Wrapper("<h1></h1>\<Esc>FhT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> h2
      \ utils.Wrapper("<h2></h2>\<Esc>FhT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> h3
      \ utils.Wrapper("<h3></h3>\<Esc>FhT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> h4
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> h5
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> ma
      \ utils.Wrapper("<main></main>\<Esc>FmT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> sp
      \ utils.Wrapper("<span></span>\<Esc>FsT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> se
      \ utils.Wrapper("<section></section>\<Esc>FsT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> op
      \ utils.Wrapper("<option></option>\<Esc>FoT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> p
      \ utils.Wrapper("<p></p>\<Esc>FpT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> ul
      \ utils.Wrapper("<ul>\<CR></ul>\<Esc>O")

autocmd FileType html
      \ inoreabbre <expr> <buffer> ol
      \ utils.Wrapper("<ol>\<CR></ol>\<Esc>O")

autocmd FileType html
      \ inoreabbre <expr> <buffer> sel
      \ utils.Wrapper("<select>\<CR></select>\<Esc>O")

autocmd FileType html
      \ inoreabbre <expr> <buffer> li
      \ utils.Wrapper("<li></li>\<Esc>T>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> la
      \ utils.Wrapper("<label for=\"\"></label>\<Esc>FlT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> na
      \ utils.Wrapper("<nav></nav>\<Esc>FnT>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> fo
      \ utils.Wrapper("<form id=\"\">\<Cr></form>\<Esc>O")

autocmd FileType html
      \ inoreabbre <expr> <buffer> ah
      \ utils.Wrapper("<a href=\"\"></a>\<Esc>Fhf\"a")

autocmd FileType html
      \ inoreabbre <expr> <buffer> im
      \ utils.Wrapper("<img src=\"\" alt=\"\"/>\<Esc>Fclli")

autocmd FileType html
      \ inoreabbre <expr> <buffer> bu
      \ utils.Wrapper("<button type=\"button\" onclick=\"\"></button>\<Esc>F/hi")

autocmd FileType html
      \ inoreabbre <expr> <buffer> tr
      \ utils.Wrapper("<tr>\<Cr></tr>\<Esc>O")

autocmd FileType html
      \ inoreabbre <expr> <buffer> th
      \ utils.Wrapper("<th></th>\<Esc>T>i")

autocmd FileType html
      \ inoreabbre <expr> <buffer> td
      \ utils.Wrapper("<td></td>\<Esc>T>i")



# ==== Callable functions ====

import "./scripts.vim" as htmlScripts

autocmd FileType html
      \ inoreabbre <expr> <buffer> bones
      \ utils.Wrapper(htmlScripts.Write("scaffold") .. "\<Esc>")

autocmd FileType html
      \ inoreabbre <expr> <buffer> ta
      \ utils.Wrapper(htmlScripts.Write("table") .. "\<Esc>8kf<i")


defcompile
