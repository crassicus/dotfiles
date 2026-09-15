vim9script

# HTML shortcuts

import "../general/scripts.vim" as utils

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> di
      \ utils.Wrapper("<div></div>\<Esc>F>a")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> vd
      \ utils.Wrapper("<>\<CR></>\<Esc>O")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> ip
      \ utils.Wrapper("<input type=\"text\" id=\"\" name=\"\" />\<Esc>F\"i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> h1
      \ utils.Wrapper("<h1></h1>\<Esc>FhT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> h2
      \ utils.Wrapper("<h2></h2>\<Esc>FhT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> h3
      \ utils.Wrapper("<h3></h3>\<Esc>FhT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> h4
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> h5
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> ma
      \ utils.Wrapper("<main></main>\<Esc>FmT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> sp
      \ utils.Wrapper("<span></span>\<Esc>FsT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> se
      \ utils.Wrapper("<section></section>\<Esc>FsT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> op
      \ utils.Wrapper("<option></option>\<Esc>FoT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> pa
      \ utils.Wrapper("<p></p>\<Esc>FpT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> ul
      \ utils.Wrapper("<ul>\<CR></ul>\<Esc>O")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> ol
      \ utils.Wrapper("<ol>\<CR></ol>\<Esc>O")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> sl
      \ utils.Wrapper("<select>\<CR></select>\<Esc>O")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> li
      \ utils.Wrapper("<li></li>\<Esc>T>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> la
      \ utils.Wrapper("<label for=\"\"></label>\<Esc>FlT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> na
      \ utils.Wrapper("<nav></nav>\<Esc>FnT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> fo
      \ utils.Wrapper("<footer></footer>\<Esc>FfT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> ti
      \ utils.Wrapper("<title></title>\<Esc>FtT>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> fo
      \ utils.Wrapper("<form action=\"\" method=\"\">\<cr></form>\<esc>kfn3li")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> ah
      \ utils.Wrapper("<a href=\"\"></a>\<Esc>Fhf\"a")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> im
      \ utils.Wrapper("<img src=\"\" alt=\"\"/>\<Esc>Fclli")

autocmd FileType html
      \ inoreabbre <expr> <buffer> bu
      \ utils.Wrapper("<button type=\"button\" onclick=\"\"></button>\<Esc>F/hi")

autocmd FileType htmldjango
      \ inoreabbre <expr> <buffer> bu
      \ utils.Wrapper("<button type=\"button\"></button>\<Esc>F/hi")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> tr
      \ utils.Wrapper("<tr>\<Cr></tr>\<Esc>O")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> th
      \ utils.Wrapper("<th></th>\<Esc>T>i")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> td
      \ utils.Wrapper("<td></td>\<Esc>T>i")

autocmd FileType htmldjango
      \ inoreabbre <expr> <buffer> tb
      \ utils.Wrapper("{% block T %}{% endblock %}\<esc>FTs")

autocmd FileType htmldjango
      \ inoreabbre <expr> <buffer> tn
      \ utils.Wrapper("{% T %}\<esc>FTs")


# nnoremaps
autocmd FileType html,htmldjango
      \ nnoremap <buffer> <silent> to
      \ :AddAttribute<cr>

autocmd FileType html,htmldjango
      \ nnoremap <buffer> <silent> c.
      \ :EditAfterTag<cr>

# inoreabbres
import "./scripts.vim" as htmlScripts

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> scf
      \ utils.Wrapper(htmlScripts.Write("scaffold") .. "\<Esc>")

autocmd FileType html,htmldjango
      \ inoreabbre <expr> <buffer> scfta
      \ utils.Wrapper(htmlScripts.Write("table") .. "\<Esc>8kf<i")


defcompile
