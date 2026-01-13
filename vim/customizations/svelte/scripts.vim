vim9script
# vim/customizations/svelte/scripts.vim


def EditAfterTag(): void
  if getline(".") =~ "<.*>.*<\/.*>"
    exec "silent normal! 0/<\\/\<cr>"
    exec "silent normal! cT>\<esc>\<right>"
    startinsert
  endif
enddef
autocmd FileType svelte command! -nargs=* EditAfterTag call EditAfterTag()
