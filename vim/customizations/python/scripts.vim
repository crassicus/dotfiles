vim9script

import "../general/scripts.vim" as gen

# Toggle the return type of a function
def ToggleFnReturnType(): void
    var view = winsaveview()
    var result = gen.SearchUpwards(['def\s.*'])

    if result == -1
        echo "Failed to find function pattern."
        winrestview(view)
        return
    endif

    var line_content = getline('.')

    if match(line_content, ')') == -1
        exe "normal! /^).*:\<cr>"
        line_content = getline('.')
    endif

    if match(line_content, '\->.*:$') != -1
        exe "normal! $F-\<left>dt:"
        winrestview(view)
        return
    endif

    if match(line_content, '\->') != -1
      exe "normal! ^f)d/:\<cr>"
      winrestview(view)

    else
      exe "normal! $F)a\<space>->\<space>\<right>"
      startinsert
    endif

enddef
autocmd FileType python command! -nargs=0 ToggleFnReturnType call ToggleFnReturnType()


def TakeMeToFnArgs(): void
  var current_line = line(".")

  while current_line >= 1
    var line_content = getline(current_line)

    var matching = match(line_content, '\vdef\s\w+\(')
    if matching != -1
      cursor(current_line, 1)
      search(')', 'c')
      return
    endif

    current_line -= 1
  endwhile
enddef
autocmd FileType python
            \ command! -nargs=0 TakeMeToFnArgs
            \ call TakeMeToFnArgs()
