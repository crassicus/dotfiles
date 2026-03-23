vim9script

autocmd FileType python
        \ nnoremap <buffer> hhx
        \ :!clear; uv run main.py

autocmd FileType python
      \ nnoremap <buffer> tn
      \ ms:ToggleFnReturnType<cr>

# autocmd FileType
#         \ python xmap kk
#         \ <Plug>SlimeRegionSend
# autocmd FileType
#         \ python nmap kk
#         \ <Plug>SlimeParagraphSend


# ==== Semantic shortcuts ====


import "../general/scripts.vim" as utils

autocmd FileType python
        \ inoreabbrev <expr> <buffer> pr
        \ utils.Wrapper("print(f\"{}\")<esc>F{i")

autocmd FileType python
        \ inoreabbrev <expr> <buffer> fn
        \ utils.Wrapper("def ():<esc>F(i")

autocmd FileType python
        \ inoreabbrev <expr> <buffer> af
        \ utils.Wrapper("async def ():<esc>F(i")

autocmd FileType python
        \ inoreabbrev <expr> <buffer> ifn
        \ utils.Wrapper("if __name__ == \"__main__\":<esc><cr>S")

autocmd FileType python
        \ inoreabbrev <expr> <buffer> cl
        \ utils.Wrapper("class x:<esc>hs")

autocmd FileType python
        \ inoreabbrev <expr> <buffer> ic
        \ utils.Wrapper("def __init__(self, ) -> None:<esc>F,lli")
