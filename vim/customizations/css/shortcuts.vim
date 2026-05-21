vim9script
import "../general/scripts.vim" as utils


# ==== Semantic shortcuts ====

autocmd FileType css
      \ inoreabbrev <expr> <buffer> va
      \ utils.Wrapper("var(--)<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> di
      \ utils.Wrapper("display: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> po
      \ utils.Wrapper("position: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> wi
      \ utils.Wrapper("width: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> he
      \ utils.Wrapper("height: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mw
      \ utils.Wrapper("min-width: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mh
      \ utils.Wrapper("min-height: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mxw
      \ utils.Wrapper("max-width: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mxh
      \ utils.Wrapper("max-height: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> in
      \ utils.Wrapper("inset: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ba
      \ utils.Wrapper("background-color: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ma
      \ utils.Wrapper("margin: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pa
      \ utils.Wrapper("padding: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> co
      \ utils.Wrapper("color: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> op
      \ utils.Wrapper("opacity: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> tr
      \ utils.Wrapper("transform: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> zi
      \ utils.Wrapper("z-index: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ff
      \ utils.Wrapper("font-family: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> fs
      \ utils.Wrapper("font-size: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> fw
      \ utils.Wrapper("font-weight: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> jc
      \ utils.Wrapper("justify-content: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ai
      \ utils.Wrapper("align-items: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> gp
      \ utils.Wrapper("gap: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> bo
      \ utils.Wrapper("border: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> br
      \ utils.Wrapper("border-radius: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> bw
      \ utils.Wrapper("border-width: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> bc
      \ utils.Wrapper("border-color: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> bt
      \ utils.Wrapper("border-style: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> fd
      \ utils.Wrapper("flex-direction: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> fp
      \ utils.Wrapper("flex-wrap: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> fb
      \ utils.Wrapper("flex-basis: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> fg
      \ utils.Wrapper("flex-grow: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> tf
      \ utils.Wrapper("transform: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> cu
      \ utils.Wrapper("cursor: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ts
      \ utils.Wrapper("transition: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> bs
      \ utils.Wrapper("box-shadow: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> fsh
      \ utils.Wrapper("flex-shrink: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ac
      \ utils.Wrapper("align-content: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pc
      \ utils.Wrapper("place-content: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> as
      \ utils.Wrapper("align-self: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pli
      \ utils.Wrapper("place-items: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pbs
      \ utils.Wrapper("padding-block-start: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pbe
      \ utils.Wrapper("padding-block-end: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pb
      \ utils.Wrapper("padding-block: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pi
      \ utils.Wrapper("padding-inline: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pie
      \ utils.Wrapper("padding-inline-end: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pis
      \ utils.Wrapper("padding-inline-start: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mbs
      \ utils.Wrapper("margin-block-start: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mbe
      \ utils.Wrapper("margin-block-end: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mie
      \ utils.Wrapper("margin-inline-end: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mis
      \ utils.Wrapper("margin-inline-start: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mi
      \ utils.Wrapper("margin-inline: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> mb
      \ utils.Wrapper("margin-block: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ta
      \ utils.Wrapper("text-align: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ov
      \ utils.Wrapper("overflow: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> tt
      \ utils.Wrapper("text-transform: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> td
      \ utils.Wrapper("text-decoration: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> rg
      \ utils.Wrapper("row-gap: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> cg
      \ utils.Wrapper("column-gap: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ga
      \ utils.Wrapper("grid-area: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> gc
      \ utils.Wrapper("grid-column: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> gs
      \ utils.Wrapper("grid-column-start: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ge
      \ utils.Wrapper("grid-column-end: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> gtc
      \ utils.Wrapper("grid-template-columns: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> gtr
      \ utils.Wrapper("grid-template-rows: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> gta
      \ utils.Wrapper("grid-template-areas: ;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> an
      \ utils.Wrapper("anchor-name: --;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pan
      \ utils.Wrapper("position-anchor: --;<Esc>i")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> par
      \ utils.Wrapper("position-area: ;<Esc>i")


autocmd FileType css
      \ inoreabbrev <expr> <buffer> bu
      \ utils.Wrapper("button { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> p
      \ utils.Wrapper("p { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> di
      \ utils.Wrapper("div { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> ah
      \ utils.Wrapper("a { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> sp
      \ utils.Wrapper("span { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> se
      \ utils.Wrapper("section { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> na
      \ utils.Wrapper("na { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> h1
      \ utils.Wrapper("h1 { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> h2
      \ utils.Wrapper("h2 { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> h3
      \ utils.Wrapper("h3 { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> h4
      \ utils.Wrapper("h4 { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> h5
      \ utils.Wrapper("h5 { <cr>}<Esc>O")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> na
      \ utils.Wrapper("na { <cr>}<Esc>O")

# ==== inoremaps ====

autocmd FileType css
      \ inoremap <buffer> {
      \  {<cr>}<esc>O


# ==== nnoremaps ====

# These mappings only apply when working in a React project
autocmd FileType css
      \ nnoremap <buffer> hx
      \ :ToggleTsxToCss<cr>

autocmd FileType css
      \ nnoremap <buffer> hb
      \ :GoToMainComponent<cr>


# ==== Callable functions ====

import "./scripts.vim" as cssScripts

autocmd FileType css
      \ inoreabbrev <expr> <buffer> bones
      \ utils.Wrapper(cssScripts.Write("scaffold") .. "\<Esc>")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> pro
      \ utils.Wrapper(cssScripts.Write("property") .. "\<Esc>3k3wlli")

autocmd FileType css
      \ inoreabbrev <expr> <buffer> me
      \ utils.Wrapper(cssScripts.Write("media_query") .. "\<Esc>k5wi")
