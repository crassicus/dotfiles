vim9script
# vim/customizations/svelte/scripts.vim

def ChangeTagContent(): void
  # Remove the content and place the cursor in insert mode
  # at the center of the inline tag
  if getline(".") =~ "<.*>.*<\/.*>"
    exec "silent normal! 0/<\\/\<cr>"
    exec "silent normal! cT>\<esc>\<right>"
    startinsert
  endif
enddef
autocmd FileType svelte command! -nargs=* ChangeTagContent call ChangeTagContent()


def AddClass()
  var line_content = getline(".")

  var condition = "class=\".*\""
  var matches = match(line_content, condition)
  if matches != -1
    cursor(line("."), matches + 1)
    execute "normal! 2f\""
    startinsert
    feedkeys(' ')
    return
  endif

  condition = "\/>"
  matches = match(line_content, condition)
  if matches != -1
    cursor(line("."), matches + 1)
    execute "normal! iclass=\"\""
    startinsert
    return
  endif

  condition = "[^=<]>"
  matches = match(line_content, condition)
  if matches != -1
    execute "normal! 0/[^=]>\<cr>a\<space>class=\"\""
    startinsert
    return
  endif

  echo "Failed to find tag!"
enddef
autocmd FileType svelte command! -nargs=0 AddClass call AddClass()


def AddAttribute()
  var line_content = getline(".")

  var first_approach = "[^=]\/>"
  var matching_column = match(line_content, first_approach)
  if matching_column != -1
    cursor(line("."), matching_column + 2)
    startinsert
    return
  endif

  var second_approach = "[^=]>"
  matching_column = match(line_content, second_approach)
  if matching_column != -1
    cursor(line("."), matching_column + 2)
    startinsert
    feedkeys(" ")
    return
  endif

  echo "Failed to find tag!"
enddef
autocmd FileType svelte command! -nargs=* AddAttribute call AddAttribute()


export def Write(method: string): string
    if method == "style"
        var lines = [
            \ '<style>',
            \ '</style>',
        ]
        return join(lines, "\n")
    endif
    return ""
enddef

defcompile
