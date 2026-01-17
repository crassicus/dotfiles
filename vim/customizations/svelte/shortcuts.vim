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



# ==== HTML Shortcuts ====
import "../general/scripts.vim" as utils
import "./scripts.vim" as extraScripts

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> sc
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper(extraScripts.Write("script") .. "\<esc>^d0O\<tab>")
      \ : "sc"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> st
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper(extraScripts.Write("style") .. "\<esc>kddpO")
      \ : "st"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> ip
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<input type=\"text\" id=\"\" />\<Esc>F\"i")
      \ : "ip"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h1
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<h1></h1>\<Esc>FhT>i")
      \ : "h1"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h2
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<h2></h2>\<Esc>FhT>i")
      \ : "h2"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h3
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<h3></h3>\<Esc>FhT>i")
      \ : "h3"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h4
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")
      \ : "h4"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> h5
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<h4></h4>\<Esc>FhT>i")
      \ : "h5"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> sp
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<span></span>\<Esc>FsT>i")
      \ : "sp"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> se
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<section></section>\<Esc>FsT>i")
      \ : "se"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> ul
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<ul><esc>o</ul><esc>O")
      \ : "ul"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> sel
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<select>\<CR></select>\<Esc>O")
      \ : "sel"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> li
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<li></li>\<Esc>T>i")
      \ : "li"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> la
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<label for=\"\"></label>\<Esc>FlT>i")
      \ : "la"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> na
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<nav></nav>\<Esc>FnT>i")
      \ : "na"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> fo
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<form id=\"\">\<Cr></form>\<Esc>O")
      \ : "fo"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> ah
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<a href=\"\"></a>\<Esc>Fhf\"a")
      \ : "ah"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> im
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<img src={} alt=\"\"/>\<Esc>Frf}i")
      \ : "im"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> bu
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<button type=\"button\" onclick={() => {}}></button>\<Esc>F/hi")
      \ : "bu"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> th
      \ (!extraScripts.FindContext(['<script lang="ts">', '</script>']) &&
      \ !extraScripts.FindContext(["<style>", "</style>"])) ?
      \ utils.Wrapper("<th></th>\<Esc>T>i")
      \ : "th"



# ==== Typescript shortcuts ====
autocmd FileType svelte
      \ inoreabbre <expr> <buffer> int
      \ extraScripts.FindContext(['<script lang="ts">', '</script>']) ?
      \ utils.Wrapper("interface x {}\<Esc>Fxcw") : "int"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> cf
      \ extraScripts.FindContext(['<script lang="ts">', '</script>']) ?
      \ utils.Wrapper("const x = () => {};\<Esc>Fxs") : "cf"

autocmd FileType svelte
      \ inoreabbre <expr> <buffer> fn
      \ extraScripts.FindContext(['<script lang="ts">', '</script>']) ?
      \ utils.Wrapper("function x() {}\<Esc>Fxcw") : "fn"



# ==== Crossed shortcuts ====
autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> di
      \ extraScripts.FindContext(['<script lang="ts">', '</script>'])
      \ ? "di" :
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("display: ;<Esc>i") :
      \ utils.Wrapper("<div></div>\<Esc>F>a")

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pa
      \ extraScripts.FindContext(['<script lang="ts">', '</script>'])
      \ ? "pa" :
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("padding: ;<Esc>i") :
      \ utils.Wrapper("<p></p>\<Esc>FpT>i")

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ma
      \ extraScripts.FindContext(['<script lang="ts">', '</script>'])
      \ ? "ma" :
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("margin: ;<Esc>i") :
      \ utils.Wrapper("<main></main>\<Esc>FmT>i")

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> op
      \ extraScripts.FindContext(['<script lang="ts">', '</script>'])
      \ ? "op" :
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("opacity: ;<Esc>i") :
      \ utils.Wrapper("<option></option>\<Esc>FoT>i")

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> tr
      \ extraScripts.FindContext(['<script lang="ts">', '</script>'])
      \ ? "tr" :
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("transform: ;<Esc>i") :
      \ utils.Wrapper("<tr>\<Cr></tr>\<Esc>O")

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> td
      \ extraScripts.FindContext(['<script lang="ts">', '</script>'])
      \ ? "td" :
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("text-decoration: ;<Esc>i") :
      \ utils.Wrapper("<td></td>\<Esc>T>i")

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> co
      \ extraScripts.FindContext(['<script lang="ts">', '</script>']) ?
      \ utils.Wrapper("console.log()\<Esc>i") :
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("color: ;<Esc>i") : "co"

autocmd FileType svelte
      \ inoremap <expr> <buffer> {
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ "{<cr>}<esc>O" : "{}<esc>i"



# ==== Css shortcuts ====
autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> va
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("var(--)<Esc>i") : "va"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> po
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("position: ;<Esc>i") : "po"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> wi
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("width: ;<Esc>i") : "wi"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> he
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("height: ;<Esc>i") : "he"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> mw
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("min-width: ;<Esc>i")

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> mh
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("min-height: ;<Esc>i") : "mh"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> mxw
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("max-width: ;<Esc>i")

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> mxh
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("max-height: ;<Esc>i") : "mxh"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> le
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("inset-line-start: ;<Esc>i") : "le"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ri
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("inset-inline-end: ;<Esc>i") : "ri"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> to
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("inset-block-start: ;<Esc>i") : "to"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> bot
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("inset-block-end: ;<Esc>i") : "bot"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ba
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("background-color: ;<Esc>i") : "ba"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> zi
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("z-index: ;<Esc>i") : "zi"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ff
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("font-family: ;<Esc>i") : "ff"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> fs
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("font-size: ;<Esc>i") : "fs"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> fw
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("font-weight: ;<Esc>i") : "fw"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> jc
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("justify-content: ;<Esc>i") : "jc"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ai
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("align-items: ;<Esc>i") : "ai"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> gp
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("gap: ;<Esc>i") : "gp"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> bo
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("border: ;<Esc>i") : "bo"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> br
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("border-radius: ;<Esc>i") : "br"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> bw
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("border-width: ;<Esc>i") : "bw"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> bc
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("border-color: ;<Esc>i") : "bc"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> bt
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("border-style: ;<Esc>i") : "bt"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> fd
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("flex-direction: ;<Esc>i") : "fd"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> fp
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("flex-wrap: ;<Esc>i") : "fp"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> fb
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("flex-basis: ;<Esc>i") : "fb"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> fg
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("flex-grow: ;<Esc>i") : "fg"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> tf
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("transform: ;<Esc>i") : "tf"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> cu
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("cursor: ;<Esc>i") : "cu"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ts
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("transition: ;<Esc>i") : "ts"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> bs
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("box-shadow: ;<Esc>i") : "bs"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> fsh
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("flex-shrink: ;<Esc>i") : "fsh"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ac
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("align-content: ;<Esc>i") : "ac"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pc
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("place-content: ;<Esc>i") : "pc"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> as
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("align-self: ;<Esc>i") : "as"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pi
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("place-items: ;<Esc>i") : "pi"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pin
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("place-inline: ;<Esc>i") : "pin"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pt
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("padding-block-start: ;<Esc>i") : "pt"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pb
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("padding-block-end: ;<Esc>i") : "pb"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pbl
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("padding-block: ;<Esc>i") : "pbl"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pr
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("padding-inline-end: ;<Esc>i") : "pr"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pl
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("padding-inline-start: ;<Esc>i") : "pl"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> mt
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("margin-block-start: ;<Esc>i") : "mt"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> mb
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("margin-block-end: ;<Esc>i") : "mb"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> mr
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("margin-inline-end: ;<Esc>i") : "mr"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ml
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("margin-inline-start: ;<Esc>i") : "ml"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ta
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("text-align: ;<Esc>i") : "ta"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ov
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("overflow: ;<Esc>i") : "ov"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> tt
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("text-transform: ;<Esc>i") : "tt"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> rg
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("row-gap: ;<Esc>i") : "rg"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> cg
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("column-gap: ;<Esc>i") : "cg"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ga
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("grid-area: ;<Esc>i") : "ga"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> gc
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("grid-column: ;<Esc>i") : "gc"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> gs
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("grid-column-start: ;<Esc>i") : "gs"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> ge
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("grid-column-end: ;<Esc>i") : "ge"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> gtc
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("grid-template-columns: ;<Esc>i") : "gtc"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> gtr
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("grid-template-rows: ;<Esc>i") : "gtr"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> gta
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("grid-template-areas: ;<Esc>i") : "gta"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> an
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("anchor-name: --;<Esc>i") : "an"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> pan
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("position-anchor: --;<Esc>i") : "pan"

autocmd FileType svelte
      \ inoreabbrev <expr> <buffer> par
      \ extraScripts.FindContext(["<style>", "</style>"]) ?
      \ utils.Wrapper("position-area: ;<Esc>i") : "par"



defcompile
