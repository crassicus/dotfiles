" ==== Keyboard (colemak-dh) ====
vnoremap n j
vnoremap m h
vnoremap e k
vnoremap i l

nnoremap n j
nnoremap m h
nnoremap e k
nnoremap i l

vnoremap j n
vnoremap h m
vnoremap k e
vnoremap l i

nnoremap j n
nnoremap h m
nnoremap k e
nnoremap l i

nmap gn gj
nmap ge gk

" ==== Scape ====
nnoremap a i
inoremap aa <esc>`^
vnoremap aa <esc>

" ==== Toggle capitalization ====
nnoremap t, :ToggleWord<cr>

" ==== Commenter ====
nmap te \c<space>
vmap te \c<space>
" Toggle between alternate comment modes
nmap ta \ca

" ==== Move from word to word ====
nnoremap s W
nnoremap r B
nnoremap w zz

nnoremap f s
nnoremap q <C-r>
nnoremap Q q

" ==== Copy and paste (system clipboard) ====
vmap <S-y> "+y
nmap <S-p> "+p

" ==== Save current buffer ====
nmap vv :w<cr>

" ==== Miscellaneous ====
nnoremap <silent> H :ToggleNerdTree<cr>
nnoremap <space> :FZF $ROOT<cr>
nnoremap <silent> WW :CloseSaving<cr>
nnoremap <silent> FF :CloseNotSaving<cr>
nnoremap > >>
nnoremap < <<

" ==== Toggle tabs and buffers ====
nnoremap B :tabnext<cr>
nnoremap <silent> tt :SwitchToBuffer<cr>
nnoremap <silent> b :GoToNerdTreeWindow<cr>

" ==== General ====
inoremap ' ""<Esc>i
inoremap " ''<Esc>i
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap ;b ``<Esc>i
inoremap ;s ~<Esc>a

nnoremap cu ci(
nnoremap cl ci[
nnoremap cy ci{

nnoremap ctu ct)
nnoremap ctl ct]
nnoremap cty ct}

nnoremap cfu cT(
nnoremap cfl cT[
nnoremap cfy cT{

nnoremap tu ms/)<cr>
nnoremap tl ms/]<cr>
nnoremap ty ms/}<cr>

nnoremap gu ms?(<cr>
nnoremap gl ms?[<cr>
nnoremap gy ms?{<cr>

nnoremap vu vi(
nnoremap vl vi[
nnoremap vy vi{

nnoremap c" ci'
nnoremap c' ci"
nnoremap cw ciw
nnoremap cW ciW
nnoremap vw vaw
nnoremap v' vi"
nnoremap v" vi'
vnoremap // :s/
nnoremap /  ms/
nnoremap ?  ms?

nnoremap d' F"df"
nnoremap di D
nnoremap dm d^
nnoremap dp {d}
nnoremap cp {c}
nnoremap vp {<down>V}
nnoremap yp mt{<down>y}`t
nnoremap gg msgg
nnoremap G  msG

nnoremap ht  :
nnoremap hd  :ALEDetail<cr>
nnoremap hw  :ALEGoToDefinition<cr>
nnoremap hq  :ALEFindReferences<cr>
nnoremap hs  :Spaces<cr>
nnoremap hf  :echo expand("%")<cr>
nnoremap ti  :BreakBrackets<cr>

cnoreabbrev SS source $MYVIMRC

autocmd FileType *
      \ cnoreabbrev <expr> <buffer> cmd
      \ getcmdline() ==# 'cmd' ? 'CommandFromRoot' : 'cmd'


" ==== Selectors ====
nnoremap ci C
nnoremap cm c^
nnoremap cn cb

nnoremap v, v^
nnoremap v. v$

nnoremap I $
nnoremap M ^

nnoremap R A
nnoremap A I

nnoremap N n
nnoremap E N

" ==== Markers ====
nnoremap ,t `tzz
nnoremap ,s `szz
nnoremap ,r `rzz
nnoremap ,,t mt
nnoremap ,,s ms
nnoremap ,,r mr

" ==== Fugitive remaps ====
command!    G       ToggleFugitive
cnoreabbrev Gg      Ggrep
cnoreabbrev Gi      Git init
cnoreabbrev Gl      Git log --all --graph
cnoreabbrev Go      Git checkout
cnoreabbrev Gc      Git commit -m
cnoreabbrev Gs      Git switch
cnoreabbrev Gb      Git branch
cnoreabbrev Gh      Git push
cnoreabbrev Gp      Git pull
cnoreabbrev Gf      Git fetch
cnoreabbrev Gm      Git merge
cnoreabbrev Gr      Git rebase
cnoreabbrev Gt      Git stash
"" Vertical diff comparasion
cnoreabbrev Gvd     Gverdiff
"" Create tabs to carry on the differentiation
cnoreabbrev Gtd     Git difftool -y
